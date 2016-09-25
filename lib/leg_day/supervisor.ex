defmodule LegDay.Supervisor do
  use Supervisor

  def start_link do
    result = {:ok, sup} = Supervisor.start_link __MODULE__, []
    start_workers sup
    result
  end

  def start_workers sup do

    {:ok, accel} = Supervisor.start_child sup, 
                    worker(LegDay.Store, [:accel_store], id: :accell)

    {:ok, gyro} = Supervisor.start_child sup, 
                    worker(LegDay.Store, [:gyro_store], id: :gyro)

    {:ok, _pid} = Supervisor.start_child sup, 
                    supervisor(LegDay.InputSup, [accel, gyro])

  end


  def init(_) do
    children = [
      supervisor(LegDay.MovementSup, [])
    ]

    supervise children, strategy: :one_for_one
  end
end
