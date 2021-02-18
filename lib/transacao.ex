defmodule Transacao do
  defstruct data: Date.utc_today, tipo: nil, valor: 0, de: nil, para: nil

  @transacoes "transacoes.txt"

  def gravar(tipo, de, valor, data, para \\ nil) do
    transacoes = busca_transacoes() ++
     [%__MODULE__{tipo: tipo, de: de, valor: valor, data: data, para: para}]
     File.write(@transacoes, :erlang.term_to_binary(transacoes))
  end

  def busca_todas(), do: busca_transacoes()
  def busca_por_ano(ano), do: Enum.filter(busca_transacoes(), &(&1.data.year == ano))
  def busca_por_mes(ano, mes), do: Enum.filter(busca_transacoes(), &(&1.data.year == ano && &1.data.month == mes))

    defp busca_transacoes() do
      {:ok, binario} = File.read(@transacoes)

      binario
      |> :erlang.binary_to_term()
  end
end
