defmodule LegDay.Store do
  use GenServer

  def init(inital_value) do
    {:ok, inital_value}
  end

  def start_link store_name do
    # TODO get initial value
    
    GenServer.start_link __MODULE__, [0], name: store_name
  end

  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:update, new_state}, _state) do
    {:noreply, new_state}
  end

  def get name do
    GenServer.call name, :get
  end

  def set name, payload do
    GenServer.cast name, {:set, payload}
  end
end
