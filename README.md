# uv-aliases

Useful aliases for [uv](https://github.com/astral-sh/uv), powered by [alias](https://github.com/yantonov/alias).

## Table of contents

- [Installation](#installation)
- [Examples](#examples)
- [Configuration](#configuration)

## Installation

```bash
git clone https://github.com/yantonov/uv-aliases.git
cd uv-aliases
./install.sh
```

Add the repository directory to your `PATH`.

## Examples

**Run Python management commands** using `uv py` instead of `uv python`:

```bash
uv py --help
uv py list
```

**Add JupyterLab** as a development dependency:

```bash
uv jupyter add
```

**Launch JupyterLab** in the project environment:

```bash
uv jupyter run
```

**Use regular `uv` commands** as usual; commands without matching aliases are forwarded to `uv`:

```bash
uv --version
uv sync
uv add requests
uv run python --version
```

List available aliases with:

```bash
uv --aliases
```

## Configuration

Aliases are defined in [`config.toml`](config.toml). Edit it to add or modify shortcuts. See the [alias configuration documentation](https://github.com/yantonov/alias#alias-types) for details.
