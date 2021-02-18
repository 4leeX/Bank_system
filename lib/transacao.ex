defmodule Transacao do
  defstruct data: Date.utc_today, tipo: nil, valor: 0, de: nil, para: nil

  @transacoes "transacoes.txt"

  def gravar(tipo, de, valor, data, para \\ nil) do
    {:ok, binario} = File.read(@transacoes)
    transacoes = binario
    |> :erlang.binary_to_term()
    transacoes = transacoes ++
     [%__MODULE__{tipo: tipo, de: de, valor: valor, data: data, para: para}]
     transacoes
  end
end
