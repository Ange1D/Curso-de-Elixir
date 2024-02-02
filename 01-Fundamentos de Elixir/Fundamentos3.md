# Fundamentos de Elixir 3

## Bitstrings
> <<15::4>>
> <<16::4>>
> <<1::2, 3::2>> == <<7::4>>
> <<25::8>>
> <<25::16>>
> is_bitstring(1)
> is_bitstring(<<1>>)
> is_binary(<<1>>)
> is_binary(<<1::8>>)
> is_binary(<<1::6>>)
> is_binary(<<"hola">>)
> i "hola"

## Charlists
> [104, 111, 108, 97]
> <<104, 111, 108, 97>>
https://unicode.org/charts/

## Funciones de alto orden
> apply(&rem/2, [9,2])
> mayusculas = &String.upcase/1
> apply(mayusculas,["hola])

## Programación funcional
- Filter
> &Enum.filter/2
> Enum.filter([1, 2, 3], fn x -> rem(x,2) == 0 end)
> Enum.filter(%{a: 1, b: 2, c: 3}, fn {_, x} -> rem(x,2) == 0 end)

- Map
> Enum.map([1, 2, 3], fn x -> 2* x end)
> Enum.map(%{a: 1, b: 2, c: 3}, fn {x, _} -> x end)

- reduce
> Enum.reduce([1, 2, 3],0, fn x,acc -> x+ acc end)
> lista = ["hola"]
> Enum.reduce(lista. %{}, fn cad, mapa -> Map.put(mapa,cad, String.length(cad)) end )

## Pipelines
> lista = [1, 2, 3]
> lista |> Enum.filter(fn x -> rem(x,2) == 0 end)
> lista |> Enum.filter(fn x -> rem(x,2) == 0 end) |> Enum.map(fn x -> 2*x end)
> lista |> Enum.filter(fn x -> rem(x,2) == 0 end) |> Enum.map(fn x -> 2*x end) |> IO.inspect()
> lista |> Enum.filter(fn x -> rem(x,2) == 0 end) |> Enum.map(fn x -> 2*x end) |> IO.inspect() |> Enum.reduce(0, fn x, a -> x +a end)
> "hola" |> String.upcase

## Rangos
> 1..10
> i 1..10
> (1..10).__struct__
> 1..10 |> Enum.map(&IO.inspect/1)
> 1..10 |> Enum.sum
> 1..100 |> Enum.map(&IO.inspect/1) |> Enum.take(5)
> 1..100 |> Stream.map(&IO.inspect/1) |> Enum.take(5)

## Funciones recursivas
> defmodule RecursionListas do
>     def dobles([]) do
>         IO.inspect []
>         []
>     end

>     def dobles([cabeza | cola]) do
>         IO.inspect cabeza
>         [cabeza *2 | dobles(cola)]
>     end

>     def pares([]), do: []
>     def pares([cabeza | cola]) when rem(cabeza,2) ==0, do: [cabeza | pares(cola)]
>     def pares([cabeza | cola]), do: pares(cola)

>     def suma([],a), do: a
>     def suma([cabeza | cola],a). do: suma(cola, a + cabeza)
>     def suma(lista), do: suma(lista, 0)
> end