defmodule Empresa.Writer do

  alias mpresa.Empleado, Empleado

  #import Jason
  #import Jason, only: [{:encode, 1}]
  import Jason, only: [encode: 1, decode: 1]

  defp to_json(m) do
    {:ok, json_version} = encode(m)
    json_version
  end

  #defp to_map(%Empresa.Empleado{nombre: n, posicion: p , sueldo: s}) do
  #  %{"nombre" => n, "posicion" => p , "sueldo" => s}
  #end

  defp to_map(%Empleado{nombre: n, posicion: p , sueldo: s}) do
    %{"nombre" => n, "posicion" => p , "sueldo" => s}
  end

  defp to_map(_x) do
      nil
  end

  defp to_json(m) do
      {:ok, json_version} = Jason.encode(m)
      json_version
  end

  defp dump(str) do
      File.write("empleados.json", str)
  end

  def write(empleados) do
      empleados
      |> Enum.map(&to_map/1)
      |> Enum.filter(fn
          nil -> false
              -> true
      end)
      |> to_json
      |> dump
  end

end
