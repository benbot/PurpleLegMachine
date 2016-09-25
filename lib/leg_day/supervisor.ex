defmodule LegDay.Supervisor do
  use Supervisor

  def start_link do
    result = {:ok, sup} = Supervisor.start_link __MODULE__, []
    start_workers sup
    result
  end

  def start_workers sup do

    {:ok, store} = Supervisor.start_child sup, 
                    worker(LegDay.Store, [])
    {:ok, _pid} = Supervisor.start_child sup, 
                    supervisor(LegDay.InputSup, [store])

  end


  def init(_) do
    children = [
      supervisor(LegDay.MovementSup, [])
    ]

    supervise children, strategy: :one_for_one
  end
end
