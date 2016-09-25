defmodule LegDay.MovementSup do
  use Supervisor

  def start_link do
    result = {:ok, sup} = Supervisor.start_link __MODULE__, []
    start_workers sup
    result
  end

  def init(_) do
    supervise [], strategy: :one_for_all
  end

  def start_workers sup do
    {:ok, upper} = Supervisor.start_child sup,
                    worker(LegDay.Actuator, [1], id: :upper)
    {:ok, lower} = Supervisor.start_child sup,
                    worker(LegDay.Actuator, [2], id: :lower)

    {:ok, _} = Supervisor.start_child sup,
                worker(LegDay.Angle, [upper, lower])

  end
end
