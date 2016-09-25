defmodule LegDay.InputSup do
  use Supervisor

  def start_link(accel_store, gyro_store) do
    result = {:ok, _pid} = Supervisor.start_link __MODULE__, {accel_store, gyro_store}
  end

  def init({accel_store, gyro_store}) do
    children = [
      worker(LegDay.AccelGet, [accel_store]),
      worker(LegDay.GyroGet, [gyro_store])
    ]

    supervise children, strategy: :one_for_one
  end
end
