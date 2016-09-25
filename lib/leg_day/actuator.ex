defmodule LegDay.Actuator do
  use GenServer
  alias Nerves.UART
  
  def start_link actu_id do
    GenServer.start_link __MODULE__, actu_id, name: :"actuator: #{actu_id}"
  end

  def init(actu_id) do
    [h|_] = Map.keys(UART.enumerate)

    {:ok, pid} = UART.start_link

    UART.open pid, h, speed: 9600, active: false

    {:ok, %{actu_id: actu_id, serial_pid: pid, state: :off, run_pid: []}}
  end

  def handle_cast({:run, %{time: time, negative: neg, batch: batch}}, store = %{state: state, actu_id: id, serial_pid: pid}) do
    if state != :off do
      #TODO: be a good programmer
    end

    case neg do
      true -> UART.write pid, "#{id}retract"
      false -> UART.write pid, "#{id}no"
      _ -> {:error, "OH NO"}
    end

    run_pid = spawn_link __MODULE__, :timer, [time, id, pid, batch]

    {:noreply, %{store | state: :on, run_pid: run_pid}}
  end

  def run name, time, neg, batch \\ [] do
    GenServer.cast name, {:run, %{time: time, negative: neg, batch: batch}}
  end

  def wave duration do
    run :"actuator: 1", 2000, true
    :timer.sleep(duration)
    run :"actuator: 1", 2000, false
    :timer.sleep(duration)
    wave duration
  end

  def timer time, actu_id, uart_id, next \\ [] do
    receive do
      :die -> :ded
    after time ->
      unless next != [] do
        UART.write(uart_id, "#{actu_id}stop")
        {:timeded, :time}
      else
        [{name, duration, neg}|t] = next

        run name, duration, neg

        {:timeded, :next}
      end
    end
  end
end
