# Erga Deployment

This assumes you have a VM/machine with the prerequisites met (see below). 

All commands run from the repository root.

## 1. Run [build_release.sh](build_release.sh)

```bash
./build_release.sh
```

## 2. Stop systemd service
```bash
sudo systemctl stop erga
```

## 3. Copy build

```bash
sudo cp -r _build/prod/rel/erga/* /erga/ && sudo chown -R erga:erga /erga/
```

## 4. Restart systemd service
```bash
sudo systemctl start erga
```

# Prerequisites

## Software

* Erlang/Elixir
* npm
* PostgreSQL

## Filesystem

Create user `erga` and directories `/erga` and `/uploads`.

```bash
sudo useradd -r -s /bin/bash erga
sudo mkdir /uploads
sudo mkdir /erga
sudo chown erga /erga
sudo chown erga /uploads
```

## Database

Setup user and empty database for erga. 

With a successful build you can seed the database. 

All commands run from the repository root.

```bash
mix phx.gen.secret
<secret> # Copy the returned value.

export DATABASE_URL=ecto://postgres:<password>@localhost/<database>
export SECRET_KEY_BASE=<secret>
export host=<host/IP>
export PORT=80

# Setup database tables.
/erga/bin/erga eval "Erga.Release.migrate"

# Add first user.
/erga/bin/erga eval 'Erga.Release.add_user("<email>", "<password>")'

# Seed initial projects.
/erga/bin/erga eval 'Erga.Release.reset_projects("priv/repo/idai-world-seeds.exs")'
```

## Run as service

You can already run the application. You need the environment variables set above.
```
/erga/bin/erga start
```

Otherwise create a systemd service at `/etc/systemd/system/erga.service`.