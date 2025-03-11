defmodule Network do

  @doc """
  Connect to server over ip and os_port

  Function return:
  {:ok, socket_connection} | {:error, reason}
  """
  def connect(server_ip \\ ~c"tcpbin.com", os_port \\ 4242) do
    :gen_tcp.connect(server_ip, os_port, [mode: :binary, active: false], 5000)
  end

  @doc """
  Send message to server over socket connection

  Function return:
  :ok | {:error, reason}
  """
  def send_message(socket, message \\ "Hello from a passive socket\n") do
    :gen_tcp.send(socket, message)
  end

  @doc """
  Receive all message from the connection. It is not matter who's mesages is it.
  We read all messages from client and server, because TCP is stateful.

  When we working with socket data, it like work with file, but read data cannot be read again

  In this case, we read all the socket data at once.

  Function return:
  {:ok, message} | {:error, reason}
  """
  def receive_message(socket) do
    :gen_tcp.recv(socket, 0, 5000)
  end

  @doc """
  Create test connection and send test message
  """
  def run() do
    with {:ok, socket} <- connect(),
         :ok <- send_message(socket),
         {:ok, message} <- receive_message(socket) do
      {:ok, message}
    else
      {:error, reason} ->
        {:error, reason}

      _any ->
        {:error, "500 error"}
    end
  end
end
