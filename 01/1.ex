defmodule Network do

  @doc """
  Connect to server over ip and os_port

  Function return:
  {:ok, socket_connection} | {:error, reason}
  """
  def connect(server_ip \\ ~c"tcpbin.com", os_port \\ 4242) do
    :gen_tcp.connect(server_ip, os_port, [mode: :binary], 5000)
  end

  @doc """
  Send message to server over socket connection

  Function return:
  :ok | {:error, reason}
  """
  def send_message(socket, message \\ "Hello world!\n") do
    :gen_tcp.send(socket, message)
  end

  @doc """
  Create test connection and send test message
  """
  def run() do
    with {:ok, socket} <- connect(),
         :ok <- send_message(socket, "Hand shake") do
      {:ok, :success}
    else
      {:error, reason} ->
        {:error, reason}

      _any ->
        {:error, "500 error"}
    end
  end
end
