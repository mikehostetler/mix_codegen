# Mix Codegen

## Overview

Mix Codegen is a library that aids in building a JSON driven code generation framework.  This is the root package, to use Mix Codegen you will need another package that implements a template.

## Why? We already have this in Elixir
Yes, we do.  I built this package to stretch my own skills (started Elixir in Oct, 2018) and because I found myself running various Mix Generator commands many times as I built apps, and I wanted a way to run those commands repeatedly, driven by code.

## Installation

### Add Dependency and Template Package

This package is not available in Hex yet.  You will need to add it to your project via this repository's GIT URL to your list of dependencies in `mix.exs`.

You will also need a template package, which can be found having the name prefixed by `mix_codegen_$packagename`.

```elixir
def deps do
  [
    {:mix_codegen, git: "https://github.com/mikehostetler/mix_codegen.git"},
    {:mix_codegen_ecto_migration, git: "https://github.com/mikehostetler/mix_codegen_ecto_migration.git"}
  ]
end
```

### Create a Codegen Config file

Create a file with the name `codegen.json` in your Mix Project's `config/` folder with the following format:

```json
{}
```

### Run the Codegen

With a `codegen.json` file created, you can run your codegen with the following command:

`mix codegen run`