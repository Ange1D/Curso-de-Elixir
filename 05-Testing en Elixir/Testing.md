# Testing en Elixir

# ExUnit y cómo se usa

> defmodule Calculadora do
>     def suma(a,b), do: a+b
>     def resta(a,b), do: a*b
> end

> defmodule CalculadoraTest do
>     use ExUnit.Case

>     test "suma dos numeros" do
>         assert Calculador.suma(2,2) == 4
>     end

>     test "resta dos numeros" do
>         assert Calculador.resta(3,2) == 1
>     end
> end

> mix test

# Aserciones de utilidad en ExUnit

> defmodule CalculadoraTest do
>     use ExUnit.Case

>     setup_all do
>         IO.puts "antes que nada"
>     end

>     setup do
>         IO.puts "setup global"
>     end

>     setup :hello_world

>     defp hello_world( ) do
>         IO.puts "hello_world setup"
>     end

>     test "suma dos numeros otra vez" do
>         assert true
>     end

>     describe "la calculadora" do
        
>         setup do
>             IO.puts "setup local a la calculadora"
>         end

>         test "suma dos numeros" do
>             assert Calculador.suma(2,2) == 4
>         end

>         test "resta dos numeros" do
>             assert Calculador.resta(3,2) == 1
>         end

>     end

> end

> mix test