defmodule ErgaWeb.ConnCase do
  alias Erga.Accounts.User
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use ErgaWeb.ConnCase, async: true`, although
  this option is not recommended for other databases.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      import Plug.Conn
      import Phoenix.ConnTest
      import ErgaWeb.ConnCase

      alias ErgaWeb.Router.Helpers, as: Routes

      # The default endpoint for testing
      @endpoint ErgaWeb.Endpoint
    end
  end

  @doc """
  Authentify the test user for tests

  Necessary addition for preventing the login to interfere with the tests
  """
  defp auth_user(conn) do
    user = %User{
      email: "admin",
      password_hash: Pow.Ecto.Schema.Password.pbkdf2_hash("erga123!")
    }
    conn = Pow.Plug.assign_current_user(conn, user, otp_app: :my_app)
    %{conn: conn}
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Erga.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Erga.Repo, {:shared, self()})
    end
    conn = Phoenix.ConnTest.build_conn()

    {:ok, auth_user(conn) }
  end
end
