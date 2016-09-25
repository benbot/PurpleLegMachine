defmodule LegDay.InputSup do
  use Supervisor

  def start_link(store) do
    result = {:ok, _pid} = Supervisor.start_link __MODULE__, store
  end

  def init(store) do
    children = [
      worker(LegDay.Get, [store]),
    ]

    supervise children, strategy: :one_for_one
  end
end
