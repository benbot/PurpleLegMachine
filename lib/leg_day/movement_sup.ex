defmodule LegDay.MovementSup do
  use Supervisor

  def start_link do
    {:ok, _pid} = Supervisor.start_link __MODULE__, []
  end

  def init(_) do
    children = [
      worker(LegDay.Actuator, [:lower, []], id: :lower),
      worker(LegDay.Actuator, [:upper, []], id: :upper)
    ]

    supervise children, strategy: :one_for_all
  end
end
