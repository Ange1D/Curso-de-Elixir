defmodule Comportamiento.SaludadorInformal do
  @behaviours Comportamiento.Saludador

  def saludar(nombre), do: "ey #{nombre}"
end
