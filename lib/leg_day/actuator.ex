defmodule LegDay.Actuator do
  use GenServer
  alias Nerves.UART
  
  def start_link actu_id do
    GenServer.start_link __MODULE__, [actu_id], name: :"actuator: #{actu_id}"
  end

  def init(actu_id) do
    [h|_] = Map.keys(UART.enumerate)

    {:ok, pid} = UART.start_link

    UART.open pid, h, speed: 9001, active: false

    {:ok, %{actu_id: actu_id, serial_pid: pid, state: :off}}
  end

  def handle_cast({:run, %{time: time, negative: neg, state: state, running_pid: run_pid}}, %{actu_id: id, serial_pid: pid}) do
    if state != :off do
      send run_pid, :die
    end

    case neg do
      true -> UART.write(pid, "#{id}:retract")
      false -> UART.write(pid, "#{id}:no")
    end

    spawn_link __MODULE__, time, [time, id, pid]
  end

  defp timer time, actu_id, uart_id do
    receive do
      :die -> :ok
    after time ->
      UART.write(pid, "#{actu_id}:stop")
      {:ok, :time}
    end
  end
end
