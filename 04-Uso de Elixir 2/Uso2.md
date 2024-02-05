# Uso de Elixir

## Typespecs básicos

> defmodule Prueba do
>     @spec suma(number(), number()) :: number()
>     def suma(a,b) do
>         a + b
>     end

>     @spec prueba :: number
>     def prueba() do
>         suma(1,2)
>     end

>     @spec prueba2 :: 5
>     def prueba2() do
>         5
>     end
> end

## Typespecs de tipos propios

> defmodule Prueba2 do
>     @type dia :: number()
>     @type mes :: number() | String.t()
>     @type fecha :: {dia(, mes())}

>     @spec ver_fecha(fecha()) :: :ok
>     def ver_fecha({dia,mes}) do
>         IO.puts "fecha #{dia}/#{mes}"
>     end
> end

## Behaviours
saludador.ex

> defmodule Comportamiento.Saludador do
>     @doc """ saludar recibe como parametro el nombre y devuelve un saludo """
>     @callback saludar(String.t()) :: String.t()

>     def saludar(modulo, nombre) do
>         modulo.saludar(nombre)
>     end
> end

formal.ex

> defmodule Comportamiento.SaludadorFormal do
>     @behaviours Comportamiento.Saludador
>     def saludar(nombre), do: "Buenos dias,encantado #{nombre}"
> end

informal.ex

> defmodule Comportamiento.SaludadorInformal do
>     @behaviours Comportamiento.Saludador
>     def saludar(nombre), do: "ey #{nombre}"
> end

> iex -S mix
> Comportamiento.Saludador.saludar(Comportamiento.SaludoInformal,'Angel')
> Comportamiento.Saludador.saludar(Comportamiento.SaludoFormal,'Angel')


## Usar rescue
errors.exs

> result = try do
>     x=5
>     y=0
>     x/0
> rescue
>     e in ArithmeticError -> "Infinito" <> e.message
>     Protocol.UndefinedError -> "Error indefinido"
>         -> "Atrapa todos"
> end
> IO.puts result

> elixir errors.exs

## Usar raise

calculadora.exs

> defmodule Calculadora.ErrorCalculo do
>     defexception message:"Se ha producido un error de calculo"
> end

> defmodule Calculadora do
>     def dividir(x,y) do
>         if y ==0 do
>         #raise "dividiendo entre 0"
>         #raise ArgumentError, message: "division entre 0"
>         raise Calculadora.ErrorCalculo
>         else
>             x/y
>         end
>     end
> end
> IO.puts Calculadora.dividir(5,0)

> elixir calculadora.exs

## Usar with
jasones.ex

> defmodule jasones do
>     def total_sueldos do
>         whith {:ok, file} <- File.read("empleados.json"),
>             {:ok, data} <- Jason.decode(file),
>             {:ok, empleados} <- Map.fecth(data,"empleados") do
>                 empleados |> Enum.map(fn k -> k["sueldo"] end) |> Enum.sum
>         else
>             :error -> "Error general"
>             {:error, } -> "Error especifico"
>         end
>     end
> end

> Jasones.total_sueldos

## Usar sigils
> ~s(hola "mundo")
> ~c(hola 'mundo')
> nombre = "Angel"
> ~s(hola #{nombre})
> ~S(hola #{nombre})
> ~c(hola #{nombre})
> ~C(hola #{nombre})

> ~w(lunes martes miercoles)
> ~w(lunes martes miercoles)s
> ~w(lunes martes miercoles)c
> ~w(lunes martes miercoles)a

> ~D(2024-01-21)
> ~D(2024-01-21).day
> ~D(2024-01-21).month
> ~D(2024-01-21).year