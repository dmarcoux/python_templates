# <a href="https://github.com/dmarcoux/python_templates">dmarcoux/python_templates</a>

Templates for common files/configs in [Python](https://www.python.org/)
projects.

## How to Use This Template

1. Create a new repository based on this repository:

- Go to this [repository's page](https://github.com/dmarcoux/python_templates),
  click on the `Use this template` button and follow instructions.

  *OR*

- With [GitHub's CLI](https://github.com/cli/cli), run:

  ```bash
  gh repo create NEW_REPOSITORY_NAME --template=dmarcoux/python_templates --clone --private/--public
  ```

2. Adapt this README to the project. This complete section can be deleted...

## Python Development Environment with Nix Flakes

Reproducible development environment for Python projects which relies on
[Nix](https://github.com/NixOS/nix) [Flakes](https://nixos.wiki/wiki/Flakes),
a purely functional and cross-platform package manager.

**Start development environment:**

```bash
nix develop
```

**Create a virtual environment:**

```bash
python -m venv venv
```

**Activate the virtual environment:**

```bash
source venv/bin/activate
```

**Deactivate the virtual environment:**

```bash
deactivate
```

**Freeze dependencies:**

```bash
pip freeze > requirements.txt
```

**Install dependencies:**

```bash
pip install -r requirements.txt
```
