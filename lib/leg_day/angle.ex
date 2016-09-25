defmodule LegDay.Angle do
  use GenServer

  def start_link upper, lower do
    {:ok, _} = GenServer.start_link __MODULE__, []
  end

  def init(_) do
    {:ok, %{}}
  end

  def handle_cast({:move, to: angle, actuator: act}, _from, state) do
    %{upper: up} = LegDay.Store.get

    time = angle - up
    neg = false
    if time < 0 do
      neg = true
    end

    case act do
      1 ->
        time = time / 2.5
    end
  end
end
