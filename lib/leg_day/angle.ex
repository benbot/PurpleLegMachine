defmodule LegDay.Angle do
  use GenServer

  def start_link upper, lower do
    {:ok, _} = GenServer.start_link __MODULE__, []
  end

  def init(_) do
    {:ok, %{}}
  end
end
