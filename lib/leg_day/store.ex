defmodule LegDay.Store do
  use GenServer

  def init(inital_value) do
    {:ok, inital_value}
  end

  def start_link do
    GenServer.start_link __MODULE__, [%{upper: 126, lower: 72.03}], name: __MODULE__
  end

  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:update, new_state}, _state) do
    {:noreply, new_state}
  end

  def get do
    GenServer.call __MODULE__, :get
  end

  def set payload do
    GenServer.cast __MODULE__, {:set, payload}
  end
end
