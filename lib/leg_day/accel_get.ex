defmodule LegDay.AccelGet do
  use GenServer

  def start_link accel_store do
    GenServer.start_link __MODULE__, [accel_store]
  end

  def init(accel_store) do
    spawn_link __MODULE__, :listen, []

    {:ok, 0}
  end

  def listen do
    receive do
      _ -> IO.puts "got something"
    end
  end
end
