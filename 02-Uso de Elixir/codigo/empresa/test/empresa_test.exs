defmodule EmpresaTest do
  use ExUnit.Case
  doctest Empresa

  test "greets the world" do #'test' es un marco defmacro
    assert Empresa.hello() == :world
  end
end
