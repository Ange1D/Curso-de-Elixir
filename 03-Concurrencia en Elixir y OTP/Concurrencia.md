# Concurrencia en Elixir y OTP

## Crear procesos – Concurrencia
concurrencia.exs

> def Concurrencia do

>     def saludar(nombre) do
>         IO.puts "Hola, #{nombre}"
>     end

>     def infinito, do: infinito
>end

> c("concurrencia.exs")
> Concurrencia.saludar("a")
> spawn(Concurrencia.saludar("a"))
> pid = Concurrencia.saludar("a")
> i pid
> Process.alive?(pid)
> pid = spawn(Concurrencia.infinito, :infinito, [])
> Process.alive?(pid)
> Process.info(pid)
> self()

> 1..100 |> Enum.map(fn ->(Concurrencia.infinito, :infinito, []) end)

## Comunicación entre procesos y paso de mensajes

> def Concurrencia2 do

>     def saludar() do
>         receive do
>             x -> IO.puts("Hola, #{x}") 
>         end
>     end

>     def saludarDos() do
>         receive do
>             {pid, x} -> send(pid,"Hola, #{x}") 
>         end
>         saludarDos()
>     end
> end

> pid = spawn(Concurrencia2, :saludar, [])
> Process.alive?(pid)
> Process.info(pid)
> send(pid,"b")
> Process.alive?(pid)
> pid = spawn(Concurrencia2, :saludarDos, [])
> send(pid, {self(), "c"})
> Process.alive?(pid)

## Mantener un estado de memoria local en un proceso
estado.exs

> defmodule Estado do

>     def contador(), do: contador(0)

>     def contador(value) do
>         new_value = receive do
>         {:get, pid} ->
>             send(pid, value)
>             contador(value)
>             value
>         {:inc} ->
>             value + 1
>         {:dec} ->
>             value - 1
>         {:reset} ->
>         0
>         end
>         contador(new_value)
>     end

>     def contadorDos() do
>     value = Process.get(:valor) || 0
>         receive do
>             {:get, pid} ->
>                 send(pid, Process.get(:valor))
>             {:inc} ->
>                 Process.put(:valor, value + 1)
>             {:dec} ->
>                 Process.put(:valor, value - 1)
>             {:reset} ->
>                 Process.put(:valor, 0)
>         end
>         contadorDos
>     end
> end

> c("estado.exs)
> pid =  spawn(Estado, :contador, [])
> send(pid, {:get, self()})
> flush()
> send(pid, {:inc})
> flush()
> Process.info(pid)
> Process.info(self())[:dictionary]

> pid =  spawn(Estado, :contadorDos, [])
> send(pid, {:get, self()})
> flush()
> Process.info(pid)
> Process.info(self())[:dictionary][:valor]


## Detectar fallos en proceso
dcal.exs

> defmodule DCalc do
>     def calculadora do
>         receive do
>             {pid, :+, a,b} -> send(pid, a+b)
>             {pid, :-, a,b} -> send(pid, a-b)
>             {pid, :x, a,b} -> send(pid, a*b)
>             {pid, :/, a,0} -> exit("division entre cero")
>             {pid, :/, a,b} -> send(pid, a/b)
>         end
>         calculadora
>     end
> end

> c("dcal.exs")
> pid =  spawn(DCalc, :calculadora, [])
> Process.link(pid)
> Process.info(pid)
> send(pid,{self(), :+, 1,2})
> send(pid,{self(), :/, 1,0})
#se reinicia
> pid
> pid =  spawn(DCalc, :calculadora, [])
> Process.unlink(pid)
> send(pid,{self(), :/, 1,0})
> pid =  spawn_link(DCalc, :calculadora, [])
> send(pid,{self(), :/, 1,0})

## Monitorización y control de procesos

> c("dcal.exs")
> pid =  spawn(DCalc, :calculadora, [])
> ref = Process.monitor(pid)
> Process.demonitor(ref)
> Process.monitor(pid)
> send(pid,{self(), :/, 1,0})
> Process.alive?(pid)
> flush()
> h & spawn_monitor/3
> {pid, ref} = spawn_monitor(DCalc, :calculadora, [])

##  GenServer
dcalc.exs

> defmodule DCalc do
>     def calculadora(contador) do
>         receive do
>             {pid, :+, a,b} -> send(pid, a+b)
>             {pid, :-, a,b} -> send(pid, a-b)
>             {pid, :x, a,b} -> send(pid, a*b)
>             {pid, :/, a,0} -> exit("division entre cero")
>             {pid, :/, a,b} -> send(pid, a/b)
>             {pid, :cont} -> send(pid, contador)
>         end
>         calculadora(contador + 1)
>     end
> end

gcalc.exs

> defmodule GCalc do
>     use GenServer

>     def init(param) do
>     IO.puts "Inicio GenServer GCalc"
>     IO.inspect param
>     {:ok, %{conteo: 0}}
>     end

>     def handle_info(msg, state) do
>        IO.puts "Me mandan mensaje #{msg}"
>        {:noreply, state}
>     end
> end

> c("gcalc.exs")
> GenServer.start
> GenServe.start_link(GCalc, {"hola", "mundo"})
> pid("0.111.0")
> send(pid, :hello)

## Enviar mensajes con un GenServer

> defmodule GCalc do
>     use GenServer

>     def add(pid, x, y) do
>         Genserver.call(pid,{:add,x,y})
>     end

>     def init(param) do
>         IO.puts "Inicio GenServer GCalc"
>         IO.inspect param
>         {:ok, %{conteo: 0}}
>     end

>     def handle_call({:add, n, m}, _from, %{conteo: conteo}) do
>         IO.puts "handle call #{n} y #{n}"
>         #Process.sleep(6000)
>         #IO.puts "WAKEUP"
>         result = n+m
>         {:reply, result, %{conteo: conteo + 1}}
>     end

>     def handle_cast(:reset, _state) do
>         IO.puts "handle cast"
>         {:noreply, %{conteo: 0}}
>     end

>     def handle_info(:hello, %{conteo: conteo}) do
>         IO.puts "conteo #{conteo}"
>         {:noreply, %{conteo: conteo + 1}}
>     end

>     def handle_info(:world, state) do
>         {:noreply, state}
>     end
> end

> c("gcalc2.exs")
> {:ok, pid} = GenServer.start(Gcalc2, [])
> GenServer.call(pid, {add, 1,2} )
> GenServer.call(pid, {add, 1,2}, 7000 ) #5000 default
> Genserver.cast(pid, :reset)
> Genserver.add(pid,1,2)


## Control de errores y gestión de GenServers
> defmodule GCalc3 do
>     use GenServer

>     def add(pid, x, y) do
>         Genserver.call(pid,{:add,x,y})
>     end

>     def init(param) do
>     IO.puts "Inicio GenServer GCalc"
>     IO.inspect param
>     #Process.sleep(6000)
>     #{:ok, %{conteo: 0}}
>     #{:ok, %{conteo: 0, 3000}}
>     #{:stop."base de datos no esta online"}
>     :ignore
>    end

>     def handle_info(msg,state) do
>         IO.inspect msg, label: "INFO"
>         {:noreply, state}
>     end

>     def handle_call({div,n,m},_from,state) do
>         if m == 0 do
>             {:stop, "no se puede dividir entre cero", state}
>         else
>             {:reply, n/m, state}
>         end
>     end

>     def terminate(reason, state) do
>         IO.puts "terminado"
>         nil
>     end

    .
    .
    .

> end

> c("gcalc3.exs")
> GenServer.start_link(Gcalc3, [], timeout: 1000)
> GenServer.start_link(Gcalc3, [])
> GenServer.start_link(Gcalc3, [])
> {:ok, pid} = GenServer.start(Gcalc3, [])
> GenServer.call(pid("0.111.0"), {:div,5,0})

## Renombrar un proceso
> c("dcalc.exs")
> pid =  spawn(DCalc, :calculadora, [])
> Process.register(pid, :calculator)
> send(:calculator,{self(), :x, 1, 2})
> flush()
> is_atom(Calculator)

> defmodule GCalc4 do
>     use GenServer

>     def add(pid, x, y) do
>         Genserver.call(GCalc4.Calculator,{:add,x,y})
>     end

>     def start_link() do
>         GenServer.start_link(GCalc4, nil, name: GCalc4.Calculator)
>     end

>     def init(param) do
>         IO.puts "Inicio GenServer GCalc"
>         IO.inspect param
>         {:ok, %{conteo: 0}}
>     end
    .
    .
    .

> GCalc4.start_link()
> GCalc4.add(1,2)
> :observer.start()

## Crear árboles de supervision (Supervisors)
calculadora.ex 

> defmodule Supervisame.Calculadora do
>     use GenServer

>     def start_link(), do: GenServer.start_link(___MODULE___, :ok, name: ___MODULE___)

>     def add( a, b), do: GenServer.call(___MODULE___, {:add, a, b})
>     def sub( a, b), do: GenServer.call(___MODULE___, {:sub, a, b})
>     def mil( a, b), do: GenServer.call(___MODULE___, {:mul, a, b})
>     def div( a, b), do: GenServer.call(___MODULE___, {:div, a, b})
    
>     def init(:ok) do
>         I0.puts "[Calculadora] Iniciando GenServer" 
>         {:ok, 0}
>     end

>     def handle_call({:add, a, b}, _from, state) do
>         IO.puts "[Calculadora] #{a} + #{b}"
>         {:reply, a + b, state + 1}
>     end

>     def handle_call({:sub, a, b}, _from, state) do
>         IO.puts "[Calculadora] #{a} - #{b}"
>         {:reply, a - b, state + 1}
>     end

>     def handle_call({:ml, a, b}, _from, state) do
>         IO.puts "[Calculadora] #{a} * #{b}"
>         {:reply, a * b, state + 1}
>     end

>     def handle_call({:div, a, b}, _from, state) do
>         IO.puts "[Calculadora] #{a} / #{b}"
>         {:reply, a / b, state + 1}
>     end

>     def handle_call({:count}, _from, state) do
>         IO.puts "[Calculadora] count=#{state}"
>         {:reply, state, state}
>     end
> end

pila.ex

> defmodule Supervisame.Pila do
>     use GenServer

>     alias Supervisame.Calculadora

>     def start_link(calc), do: GenServer.start_link(__MODULE___, :ok, name: __MODULE___)

>     def push(val), do: GenServer.call(__MODULE___, {:push, val})

>     def init(:ok) do
>         IO.puts "[Pila] Iniciando GenServer"
>         {:ok, { []}}
>     end

>     def handle_call({:push, :add}, _from,  [a, b | stack]) do
>         IO.puts "[Pila] Push ADD"
>         resul = Calculadora.add( a, b)
>         {:reply, resul,[resul | stack]}
>     end

>     def handle_call({:push, :sub}, _from, [a, b I stack]) do
>         IO.puts "[Pila] Push SUB"
>         resul = Calculadora.sub(a, b)
>         {:reply, resul, [resul | stack]}
>     end

>     def handle_call({:push, :mul}, _from, [a, b | stack]) do
>         IO.puts "[Pila] Push MUL"
>         resul = Calculadora.mul( a, b)
>         {:reply, resul, [resul | stack]}
>     end

>     def handle_call({:push, :div}, _from, [a, b I stack]) do
>         IO.puts "[Pila] Push DIV"
>         resul = Calculadora.div( a, b)
>         {:reply, resul, [resul | stack]}
>     end

>     def handle_call({:push, x}, _from,  stack) when is_number(x) do
>         IO.puts "[Pila] Push #{x}"
>         {:reply, x, [x | stack]}
>     end
> end

> iex -S mix
> Supervisame.Calculadora.start_link([])
> Supervisame.Calculadora.add(1,2)
> Supervisame.Pila.start_lin([])
> Supervisame.Pila.push(1)
> Supervisame.Pila.push(0)
> Supervisame.Pila.push(:div)

> childs = [{Supervisame.Calculadora, []},{Supervisame.Pila, []}]
> {:ok, pid} = Supervisor.start_link(childs, strategy: :one_for_one)
> Supervisame.Pila.push(:nope)
> Supervisame.Pila.push(3)
> Supervisame.Pila.push(0)
> Supervisame.Pila.push(:div)

## Estrategias para trabajar con Supervisor
supervisame.ex

> defmodule Supervisame do
>     use Supervisor

>     def start_link(_args) do
>         IO.puts "[Spervisame] Iniciando supervisor"
>         Supervisor.start_link([
>             {Supervisame.Calculadora, []},
>             {Supervisame.Pila, []}
>         ], strategy: :one_for_one)
>     end
> end

> iex -S mix
> Supervisame.start_link([])

# Estrategias de creación de supervisores
supervisame2.ex

> defmodule Supervisame2 do
>     use Supervisor

>     def start_link(args) do
>         IO.puts "[Supervisame] Iniciando supervisor"
>         IO.inspect args
>         Supervisor.start_link(__MODULE_, :ok, name: __MODULE__)
>     end

>     def init(args) do
>         IO.puts "[Supervisame] Llamo a init"
>         IO.inspect args
>         children = [
>             {Supervisame2.Calculadora, []},
>             {Supervisame2.Pila, []}
>         ]
>         Supervisor.init(children, strategy: :one_for_one)
>     end   
> end

/* no se usa porque falta init
main_sup.ex

> defmodule Supervisame.MainSup do
>     use Supervisor

>     def start_link(args) do
>         IO.puts "[MainSup] Lanzando mainsup"
>         IO.inspect args
>         Supervisor.start_link([
>             {Supervisame, []}
>         ], strategy: :one_for_one)
>     end
> end
*/

> Supervisor.start_link([{supervisame2, []},], strategy: :one_for_one)

## Uso de Application
> mix new prueba 1 --sup
> cd prueba1
> mix run

## Ejemplo de aplicaciones con hijos
https://github.com/elixir-plug/plug 
mix.exs
> defp deps do [
>     {:plug_cowboy, "~> 2.0"}
> ]end


> mix deps.get

endpoint.ex

> import Plug.Conn
>  def init(opts) do
>    IO.puts "Plug"
>    opts
>  end

>   def call(conn, _opts) do
>     conn
>     |> put_resp_header("Content-Type","text/html")
>     |> send_resp(200,"<h1>Hola</h1>")
>   end
> end

application.ex
> children = [
>       {Prueba.Hola, :ok},
>       {Plug.Cowboy, [scheme: :http, plug: Prueba.EndPoint, options:[port: 4001]]}
> ]

> mix run --no-halt
||
>iex -S mix
>r(Prueba.Endpoint)

http://localhost:4001/