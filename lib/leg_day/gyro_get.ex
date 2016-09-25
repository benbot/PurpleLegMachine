defmodule LegDay.GyroGet do
  use GenServer

  def start_link gyro_store do
    GenServer.start_link __MODULE__, [gyro_store]
  end

  def init(gyro_store) do
    spawn_link __MODULE__, :listen, []

    {:ok, 0}
  end

  def listen do
    receive do
      _ -> IO.puts "got something"
    end
  end
end
