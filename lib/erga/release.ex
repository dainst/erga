defmodule Erga.Release do
  require Logger
  @app :erga

  def migrate do
    load_app()

    for repo <- repos() do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end
  end

  def rollback(repo, version) do
    load_app()
    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
  end

  # Run ` _build/prod/rel/erga/bin/erga eval 'Erga.Release.add_user("<user email>", "<user password>")'` from the command line.
  def add_user(email, password) do
    start_repo()

    Erga.Repo.insert!(%Erga.Accounts.User{
      email: email,
      password_hash: Pow.Ecto.Schema.Password.pbkdf2_hash(password)
    })
  end

  def reset_projects(seeds_file) do
    start_repo()
    full_path = Path.absname(seeds_file)

    dir = "#{Application.get_env(:erga, :uploads_directory)}/**"

    Logger.info("Deleting contents of upload directory '#{dir}':")
    Path.wildcard(dir)
    |> Enum.map(fn item -> File.rm_rf!(item) end)
    |> Enum.each(fn item -> Logger.info(item) end)

    Code.eval_file(full_path)
  end

  defp repos do
    Application.fetch_env!(@app, :ecto_repos)
  end

  defp start_repo do
    load_app()
    Application.put_env(@app, :only_repo, true)
    Application.ensure_all_started(@app)
  end

  defp load_app do
    Application.load(@app)
  end
end
