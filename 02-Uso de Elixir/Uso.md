# Uso de Elixir

## Herramienta mix
> mix help
mix new nombre
> mix new hola
> iex -S mix
> Hola.hello

## Comentarios y documentación
> #comentario
> @moduledoc """Documentación de modulo"""
> @doc """Documentación de función"""

## Anotaciones de módulo 
> defmodule Hola do
>     @mundo :world
>     @mapa %{host: "localhost", port: 3000, user: "admin", password: "admin"}
>     @lista []

>     def hello do
>         @mundo
>         Map.put(@mapa, :cargando, true)
>     end

>     def uno, do: IO.inspect(@lista)

>     @lista [2 | @lista]
>     def dos, do: IO.inspect(@lista)

> end


## Gestionar dependencias
> mix new empresa
> cd empresa
https://hex.pm/
https://hex.pm/packages/jason

empresa/mix.exs
> defp deps do
>    [
>        {:jason, "~> 1.4"}
>    ]
> end

> mix deps.get
> iex -S mix

## Creación de módulo
> cd empresa
empresa.ex

> defmodule Empresa do
>     defmodule Empleado do
>       defstruct [:nombre, :posicion, :sueldo]
>     end
> end

> iex -S  mix
> %Empresa.empleado{}

> cd lib
writer.ex

> defmodule Empresa.Writer do

>     defp to_map(%Empresa.Empleado{nombre: n, posicion: p , sueldo: s}) do
>         %{"nombre" => n, "posicion" => p , "sueldo" => s}
>     end

>     defp to_map(_x) do
>         nil
>     end

>     defp to_json(m) do
>         {:ok, json_version} = Jason.encode(m)
>         json_version
>     end

>     defp dump(str) do
>         File.write("empleados.json", str)
>     end

>     def write(empleados) do
>         empleados
>         |> Enum.map(&to_map/1)
>         |> Enum.filter(fn
>             nil -> false
>                 -> true
>         end)
>         |> to_json
>         |> dump
>     end

> end

> recompile
> e1 = %Empresa.Empleado{nombre: "a", posicion:"b", sueldo: 1}
> e2 = ...
> [e1,e2,e3]
> Empresa.Writer.write([e1,e2,e3])

## Palabras clave alias e import

> defmodule Empresa.Writer do

>     alias mpresa.Empleado, Empleado

>     #import Jason
>     #import Jason, only: [{:encode, 1}]
>     import Jason, only: [encode: 1, decode: 1]

>     defp to_map(%Empleado{nombre: n, posicion: p , sueldo: s}) do
>       %{"nombre" => n, "posicion" => p , "sueldo" => s}
>     end

>     defp to_json(m) do
>         {:ok, json_version} = encode(m)
>         json_version
>     end

    .
    .
    .

## Macros, require y use
> defmodule EmpresaTest do
>     use ExUnit.core 

>     test "world" do #'test' es un marco defmacro
>         assert Empresa.hello()= :world
>     end
> end

> Integer.is_odd(5) #es un macro
> require Integer
> Integer.is_odd(5)