defmodule Comportamiento.SaludadorFormal do
  @behaviours Comportamiento.Saludador

  def saludar(nombre), do: "Buenos dias,encantado #{nombre}"
end
