defmodule LegDay.Get do
  use GenServer
  alias LegDay.Store

  def start_link store do
    init store

    {:ok, self}
  end

  def init(store) do

    #{:ok, socket} = :gen_tcp.connect({0, 0,0 ,0}, 9001, [:binary, {:active, :true}])
    socket = []

    spawn_link __MODULE__, :listen, [socket, store]

    {:ok, %{}}
  end

  def listen(_socket, store) do
    receive do
      {:ok, _, msg} ->
        Store.set store, Poison.Parser.parse(msg)
      {:error, _, _} ->
        raise "Connection Lost!"
    end
  end
end
