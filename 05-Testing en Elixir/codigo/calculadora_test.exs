defmodule CalculadoraTest do
  use ExUnit.Case

  test "suma dos numeros" do
      assert Calculadora.suma(2,2) == 4
  end

  test "resta dos numeros" do
      assert Calculadora.resta(3,2) == 1
  end

end
