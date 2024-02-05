defmodule Comportamiento.Saludador do
  @doc """ saludar recibe como parametro el nombre y devuelve un saludo """
  @callback saludar(String.t()) :: String.t()

  def saludar(modulo, nombre) do
      modulo.saludar(nombre)
  end
end
