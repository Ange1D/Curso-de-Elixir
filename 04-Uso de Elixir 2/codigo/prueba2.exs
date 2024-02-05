defmodule Prueba2 do

  @type dia :: number()
  @type mes :: number() | String.t()

  @type fecha :: {dia(, mes())}

  @spec ver_fecha(fecha()) :: :ok
  def ver_fecha({dia,mes}) do
      IO.puts "fecha #{dia}/#{mes}"
  end

end
