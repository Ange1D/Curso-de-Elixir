result = try do
  x=5
  y=0
  x/0
rescue
  e in ArithmeticError -> "Infinito" <> e.message
  Protocol.UndefinedError -> "Error indefinido"
      -> "Atrapa todos"
end
IO.puts result
