defmodule Hola2 do
  @mundo :world
  @mapa %{host: "localhost", port: 3000, user: "admin", password: "admin"}
  @lista []

  def hello do
      @mundo
      Map.put(@mapa, :cargando, true)
  end

  def uno, do: IO.inspect(@lista)

  @lista [2 | @lista]
  def dos, do: IO.inspect(@lista)

end
