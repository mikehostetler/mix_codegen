# MixCodegen

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `mix_codegen` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:mix_codegen, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/mix_codegen](https://hexdocs.pm/mix_codegen).

# Ecto
lib/mw/domain/user.ex
lib/mw/domain/gen/user.ex
lib/mw/data/schema/user.ex
lib/mw/data/schema/gen/user.ex
lib/mw/data/model/user.ex
lib/mw/data/schema/gen/user.ex

# Migration & Seeds
priv/repo/migrations/20181021153457_add_user_table.exs
mw/priv/repo/seed/user.ex
mw/priv/repo/seed/gen/user.ex

# Tests
mw/test/domain/user_test.exs
mw/test/data/schema/user_test.exs
mw/test/data/model/user_test.exs



# Phoenix
lib/mw_web/controllers/user_controller.ex
lib/mw_web/templates/user/edit.html.eex
lib/mw_web/templates/user/form.html.eex
lib/mw_web/templates/user/index.html.eex
lib/mw_web/templates/user/new.html.eex
lib/mw_web/templates/user/show.html.eex
lib/mw_web/views/user_view.ex
test/mw_web/controllers/user_controller_test.exs



mix ecto.gen.domain Route Route route method:string slug:string controller:string action:string

mix codegen.

mix skeleton.gen.html TestLib User/user users name:string email:string
mix codegen.gen.model User/user users name:string email:string

# Install / Uninstall
mix archive.install hex mix_codegen
mix archive.install hex mix_codegen_ecto_migration

# CLI API
mix codegen

mix codegen.ecto.migration table
mix codegen.mw.model lib_name resource/resource plural_name field:type field:type

# Codegen based on input file
mix codegen                       # Print Help
mix codegen --input codegen.json  # Run Batched Codegen
{
  "codegen.ecto.migration": [
    "add_table -r Mw.Repo",
    "add_blerg -r Mw.Repo"
  ],
  "codegen.mw.model": [
    ["lib_name", "resource/resource", "plural_name", "field:type", "field:type"]
    ["lib_two", "resource/resource", "plural_name", "field:type", "field:type"]
  ]
}

* Primary Codegen takes file input, parses the JSON and makes multiple calls to:
`Mix.Tasks.Codegen.XXX.run(json_string_args)`
