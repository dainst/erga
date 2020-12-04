#!/bin/bash

# Based on https://hexdocs.pm/phoenix/releases.html#content with
# environment variables set at runtime.

mix deps.get --only prod

MIX_ENV=prod mix compile

npm run deploy --prefix ./assets
mix phx.digest

MIX_ENV=prod mix release --overwrite