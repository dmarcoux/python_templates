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

2. Decide whether you want the development environment to be based on
   devcontainer/Docker or Nix Flakes. Both have their pros and cons.
   devcontainer/Docker is way more mainstream than Nix Flakes, but has a slight
   overhead due to the containers.

   1. If you pick the devcontainer/Docker development environment, delete the Nix
      Flakes files `flake-FHS.nix` and `flake-STANDARD.nix`.

   2. If you pick the Nix Flakes development environment, delete the
      devcontainer/Docker files `Dockerfile`, `docker-compose.yml` and the
      directory `.devcontainer`. Keep either `flake-FHS.nix` or
      `flake-STANDARD.nix` depending on what your project needs. Rename the chosen
      file to `flake.nix`. For most projects, `flake-STANDARD.nix` will be the
      right pick since it's simpler and all dependencies are packaged by Nix. Only
      in rare cases when dependencies rely on
      [FHS](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard), then use
      `flake-FHS.nix`. As an example of this is
      [Playwright](https://playwright.dev/) since it installs browsers in the
      typical FHS paths.

3. Search for `CHANGEME` in the newly created repository to adapt it to the
   project's needs.

4. Adapt this README to the project. This complete section can be deleted. Keep
   the relevant _Development Environment_ section below based on the one you
   selected in the previous steps.

## Python Development Environment with devcontainer/Docker

The development environment is based on [devcontainer](https://containers.dev/)
which relies on [Docker](https://www.docker.com/) and
[Docker-Compose](https://docs.docker.com/compose/). devcontainer is [supported
in various IDEs/editors](https://containers.dev/supporting), in addition to
having a [CLI](https://github.com/devcontainers/cli).

Refer to the [Makefile](./Makefile) to see various commands, like starting the
development environment or formatting the code.

## Python Development Environment with Nix Flakes

Reproducible development environment for Python projects which relies on
[Nix](https://github.com/NixOS/nix) [Flakes](https://nixos.wiki/wiki/Flakes),
a purely functional and cross-platform package manager.

Refer to the [Makefile](./Makefile) to see various commands, like starting the
development environment or formatting the code.

## Python Development Environment with devenv

Reproducible development environment for Python projects which relies on
[devenv](https://devenv.sh/). Underneath, it uses
[Nix](https://github.com/NixOS/nix), a purely functional and cross-platform
package manager.

WIP: For now, refer to
[sports_tracker](https://github.com/dmarcoux/sports_tracker) and its
[devenv.nix](https://github.com/dmarcoux/sports_tracker/blob/main/devenv.nix)
file.
