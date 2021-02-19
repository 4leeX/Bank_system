defmodule Transacao do
  defstruct data: Date.utc_today, tipo: nil, valor: 0, de: nil, para: nil

  @transacoes "transacoes.txt"

  def gravar(tipo, de, valor, data, para \\ nil) do
    transacoes = busca_transacoes() ++
     [%__MODULE__{tipo: tipo, de: de, valor: valor, data: data, para: para}]
     File.write(@transacoes, :erlang.term_to_binary(transacoes))
  end

  def todas(), do: busca_transacoes()
  def por_ano(ano), do: Enum.filter(todas(), &(&1.data.year == ano))
  def por_mes(ano, mes), do: Enum.filter(todas(), &(&1.data.year == ano && &1.data.month == mes))
  def por_dia(data), do: Enum.filter(todas(), &(&1.data == data) )

    def calcular_mes(ano, mes), do: calcular(por_mes(ano, mes))

    def calcular(transacoes) do
      Enum.reduce(transacoes, 0, fn x, acc -> acc + x.valor end)
    end

    defp busca_transacoes() do
      {:ok, binario} = File.read(@transacoes)

      binario
      |> :erlang.binary_to_term()
  end
end
