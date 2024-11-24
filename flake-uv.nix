{
  description = "Python development environment with uv";

  inputs = {
    # Use https://www.nixhub.io/ to easily find the exact commit to use in order to pin an input (and its packages) to a specific version
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };

        # Locales
        glibcLocales = pkgs.glibcLocales;

        # Bundle of SSL certificates
        cacert = pkgs.cacert;

        # Extremely fast Python package and project manager - https://docs.astral.sh/uv/
        uv = pkgs.uv;
      in
      {
        # Create a development shell
        devShells.default = pkgs.mkShell {
          # Packages installed in the development shell
          packages = [
            pkgs.python312
            # Timezones
            pkgs.tzdata
            # Locales
            glibcLocales
            # Bundle of SSL certificates
            cacert
            # Extremely fast Python package and project manager - https://docs.astral.sh/uv/
            uv
          ];

          # Commands to be executed in the development shell
          shellHook = ''
            # Set LANG for locales
            export LANG="C.UTF-8"

            # Remove duplicate commands from Bash shell command history
            export HISTCONTROL=ignoreboth:erasedups

            # Without this, there are warnings about LANG, LC_ALL and locales.
            # Many tests fail due those warnings showing up in test outputs too...
            # This solution is from: https://gist.github.com/aabs/fba5cd1a8038fb84a46909250d34a5c1
            export LOCALE_ARCHIVE="${glibcLocales}/lib/locale/locale-archive"

            # For the bundle of SSL certificates to be used in applications (like curl and others...)
            export SSL_CERT_FILE=${cacert}/etc/ssl/certs/ca-bundle.crt

            # Put uv's version in `.uv-version`. This file is used in CI.
            uv version | cut --delimiter=' ' --fields=2 > .uv-version

            # Put Python's version in `.python-version`. This file is used in CI.
            python --version | cut --delimiter=' ' --fields=2 > .python-version

            # Create (if needed) and activate the Python virtual environment
            if [ ! -d ".venv" ]; then
              uv venv .venv
            fi
            source .venv/bin/activate

            # Sync the project's dependencies (from `pyproject.toml`) with the virtual environment
            uv sync

            # Patch ruff binary. It is dynamically linked to ld, which will not work with Nix
            ${pkgs.lib.getExe pkgs.patchelf} --set-interpreter ${pkgs.stdenv.cc.bintools.dynamicLinker} $VIRTUAL_ENV/bin/ruff
          '';
        };
      }
    );
}
