defmodule jasones do
  def total_sueldos do
      whith {:ok, file} <- File.read("empleados.json"),
          {:ok, data} <- Jason.decode(file),
          {:ok, empleados} <- Map.fecth(data,"empleados") do
              empleados |> Enum.map(fn k -> k["sueldo"] end) |> Enum.sum
      else
          :error -> "Error general"
          {:error, } -> "Error especifico"
      end
  end
end
