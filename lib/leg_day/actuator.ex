defmodule LegDay.Actuator do
  use GenServer
  
  def start_link name, pins do
    GenServer.start_link __MODULE__, pins, name: name
  end

  def init(pins) do
    {:ok, []}
  end
end
