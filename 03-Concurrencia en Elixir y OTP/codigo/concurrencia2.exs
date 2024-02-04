def Concurrencia2 do

  def saludar() do
      receive do
          x -> IO.puts("Hola, #{x}")
      end
  end

  def saludarDos() do
      receive do
          {pid, x} -> send(pid,"Hola, #{x}")
      end
      saludarDos()
  end

end
