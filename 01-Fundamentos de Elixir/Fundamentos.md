# Fundamentos de Elixir

## REPL (Read Eval Print Loop)
> iex

## Asignaciones
> pi = 3.1416

## Operadores aritméticos básicos
> 1+2
> 1-2
> 1*2
> 1/2

## Tipos de datos
> i pi
> i 7
> i (1/2)

## Átomos
> :hola

## Palabras clave nil, true y false
> :nil
> i nil
> i true
> i false
> nil == :nil
> true == :true

## Operadores lógicos de comparación
> 1 == 2
> 1 != 2 
> 1 < 2
> 1 > 2
> 1 >= 2
> 1 <= 2
> :a < :b
> :ab < :aa

## Operador triple
> 1 == 1.0
> 1 === 1.0
> 1 !== 1.0

## Operadores lógicos de Elixir
> not true
> true and true
> true or false
> !nil
> !1
>  1 && true
> nil && true
> false || true
> true || nil
> 1 || nil
> nil || :nothing

## Invocar funciones
> rem(1,2)
> round(1.75)

## Funciones en Elixir
Tab
> is_atom(1)
> is_integer(1)

## Modulos
Tab

Atom.

Integer.

https://hexdocs.pm/elixir/1.16.0/Kernel.html

## Cadenas de caracteres
> "hola mundo"
> String.length("hola)
> String.downcase("HOLA)
> String.at("Hola",1)
> "Hola: \"Hola\""

## Entrada y salida por consola
> IO.puts("Hola mundo)
> IO.gets("")
>

## Concatenar e interpolar strings
> "hola" == "hola"
> "hola" != "hola"
> "hola" <> "mundo"
> "hola" <> " " <> "mundo"
> "Hola, #{:mundo}"

## Crear archivos de código fuente en Elixir

### Extencion VSCode 
- ElixirLS: Elixir support and debugger
  - nombre.ex para compilar en binario
  - nombre.exs para compilar en el momento

para ejecutar

> elixir nombre.exs