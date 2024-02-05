defmodule Calculadora2Test do
  use ExUnit.Case

  setup_all do
      IO.puts "antes que nada"
  end

  setup do
      IO.puts "setup global"
  end

  setup :hello_world

  defp hello_world( ) do
      IO.puts "hello_world setup"
  end

  test "suma dos numeros otra vez" do
      assert true
  end

  describe "la calculadora" do

      setup do
          IO.puts "setup local a la calculadora"
      end

      test "suma dos numeros" do
          assert Calculadora.suma(2,2) == 4
      end

      test "resta dos numeros" do
          assert Calculadora.resta(3,2) == 1
      end

  end

end
