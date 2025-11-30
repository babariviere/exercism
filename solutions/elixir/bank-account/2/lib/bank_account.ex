defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    spawn_link(fn -> loop(%{balance: 0, open: true}) end)
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
    send(account, :close)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    ref = make_ref()
    send(account, {:get, self(), ref})

    receive do
      {^ref, :account_closed} -> {:error, :account_closed}
      {^ref, balance} -> balance
    after
      5000 -> {:error, :account_closed}
    end
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    ref = make_ref()
    send(account, {:update, self(), ref, amount})

    receive do
      {^ref, :ok} -> :ok
      {^ref, :account_closed} -> {:error, :account_closed}
    after
      5000 -> {:error, :account_closed}
    end
  end

  # Server's loop
  defp loop(state) do
    receive do
      {:get, caller, ref} ->
        handle_get(state, caller, ref)
        loop(state)

      {:update, caller, ref, amount} ->
        new_state = handle_update(state, caller, ref, amount)
        loop(new_state)

      :close ->
        loop(%{state | open: false})
    end
  end

  defp handle_get(%{open: false}, caller, ref) do
    send(caller, {ref, :account_closed})
  end

  defp handle_get(%{balance: balance}, caller, ref) do
    send(caller, {ref, balance})
  end

  defp handle_update(%{open: false} = state, caller, ref, _amount) do
    send(caller, {ref, :account_closed})
    state
  end

  defp handle_update(%{balance: balance} = state, caller, ref, amount) do
    send(caller, {ref, :ok})
    %{state | balance: balance + amount}
  end
end
