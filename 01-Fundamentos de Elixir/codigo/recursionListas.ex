defmodule RecursionListas do
  def dobles([]) do
    IO.inspect []
    []
  end

  def dobles([cabeza | cola]) do
    IO.inspect cabeza
    [cabeza *2 | dobles(cola)]
  end

  def pares([]), do: []
  def pares([cabeza | cola]) when rem(cabeza,2) ==0, do: [cabeza | pares(cola)]
  def pares([cabeza | cola]), do: pares(cola)

  def suma([],a), do: a
  def suma([cabeza | cola],a). do: suma(cola, a + cabeza)
  def suma(lista), do: suma(lista, 0)
  
end
