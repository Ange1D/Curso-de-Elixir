 # Fundamentos de Elixir 2

 ## Condicional IF
> variable = 10
> if variable >= 20 do 
>    IO.puts "Verdadero"
> else
>    IO.puts "Falso"
> end

## UNLESS y COND
> admin = false

> #if !admin
> unless admin do 
>    IO.puts "No es admin"
> end


> variable = 50

> mensaje = cond do
>    variable == 0 -> "1"
>    variable < 30 -> "2"
>    variable < 60 -> "3"
>    variable < 90 -> "4"
>    true -> "90 o mas"
> end

## Definir funciones
calculadora.ex
> defmodule Calculadora do
>    def suma(a, b) do
>        c = a + b
>        c
>    end
> end

> IO.inspect Calculadora.suma(1,2)

## Compilar código
> elixirc calculadora.ex
> iex
> Calculadora,suma(1,2)

## Guardas
calculadora2.exs
> defmodule Calculadora do

>    #guarda
>    def dividir(_a,b) when b == 0 do
>        :inf
>    end

>    def dividir(a,b) do
>        a/b
>    end
> end

> c("calculadora2.exs")
> Calculadora.dividir(1/0)

## Funciones anónimas
> cuadrado = fn n -> n*n end
> cuadrado.(5)

> defmodule Calculadora
>    def operar(func) do
>        func.(1,2)
>    end
> end

> IO.puts Calculadora.operar(fn a,b -> a+b end)

> restar = fn a,b -> a-b end
> IO.puts Calculadora.operar(restar)

## Capturar funciones
&nombre/argumentos
> &rem/2
> recortar = &String.trim/1
> recortar.("    hola   ")

## Invocar funciones del mismo módulo y funciones privadas
> defmodule Calcular do
>     def total(a,b) do
>         #Calcular.porcentaje(b) * a
>         porcentaje(b) * a
>     end
>     #funcion privada defp
>     defp porcentaje(b) do
>         cond do 
>             b == :a -> 1
>             b == :b -> 2
>         end
>     end
> end

> IO.inspect Calcular.total(10,:b)

## Tuplas
> {1, :hola, 1.2, "hola"}
> division = fn a,b -> {div(a,b),rem(a,b)} end
> division.(2,1)
> Tuple.append({1,2},3)

## Pattern matching
> x = 1 + 2
> x = {:hello, :world}
> a
> {a,b} = {:hello, :world}
> a
> b
> {1,a,3} = {1,2,3}
> a
> {0,texto} = {0,"hola mundo"}

## Pattern matching con funciones
> defmodule Calculadora do

>     def dividir(_a,0) do
>         :inf
>     end

>     def dividir(a,b) when is_number(a) and is_number(b) do
>         a/b
>     end

>     def dividir(_a,_b) do
>         :invalid
>     end

>     def print2({:ok,x}) do
>        IO.puts("ok")
>    end

>    def print2({:error,_}) do
>        IO.puts("error")
>    end

> end

## Case
> exp = {:ok, "hola"}
> case exp do
>     {:ok, x} when is_number(x) -> "ok con #{x}"
>     {:ok, x} -> "ok con #{x}"
>     {:error, _} -> "error"
>     _ -> "cualquier cosa"
> end

## Operador pin
> ^x = 4
> ^x = 5
> {:ok, ^x, y} = {:ok, 5, 0}
> {:ok, ^x, y} = {:ok, 4, 0}

## Recursividad usando pattern matching
> defmodule Recursiva do
>     def factorial(0) do
>         1
>     end

>     def factorial(n) do
>         n * factorial(n-1)
>     end
> end

## Listas de Elixir
> [1,2,3]
> hd [1,2,3]
> tl [1,2,3]
> base = []
> [1 | base]
> uno = [1 | base]
> [2 | uno]
> dos = [2 | uno]
> [a,b,c] = [1,2,3]
> b
> [a | c] = [1,2,3,4]
> a
> c
> [a,b | c] = [1,2,3,4]
> a
> b
> c

## Operadores y funciones de las listas
> lista = [1,2,3]
> [4 | lista]
> [1,2,3] ++ [4,5,6]
> [1,2,3] -- [2]
> Enum.at(> ["a","b","c"], 2)
> length lista

## Keyword lists
> kwlist = [{:hola,1}, {world, 2}]
> kwlist[:hola]
> kwlist ++ [{:mundo, 3 }]
> [a: 1, b: 2]

> mensaje = if calificacion >= 6, do: "apobado", else: "reprobado"

## Mapas
> %{:a => "a", 1 => "uno", "dos" => 2

## Pattern matching en Elixir con mapas y keyword lists}
> %{} = %{a: 1, b: 2}
> %{b: y, a: x} = %{a: 1, b: 2}
> x
> [] = [name: "Ange1D"]
> [name: n] = [name: "Ange1D"]

## Operadores de mapa 
> Map.merge(%{a: 1, b: 2}, %{c:3})
> Map.put(%{a: 1, b: 2}, :c 3)
> %{ %{a: 1, b: 2} | b: 4}

## Estructuras
> defmodule Perfil do
>     defstrct [:nombre]
> end

> %Perfil{}
> i %Perfil{}
> m = %Perfil{}
> m.__struct__
> m.nombre