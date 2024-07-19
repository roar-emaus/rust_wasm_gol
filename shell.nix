{ pkgs ? import <nixpkgs> {} }:

let
  rustChannel = "nightly";  # Use "stable" if preferred
  rustTarget = "wasm32-unknown-unknown";
in
pkgs.mkShell {
  buildInputs = [
    pkgs.rustup
    pkgs.nodejs
    pkgs.cmake
    pkgs.lld
  ];

  shellHook = ''
    export RUSTUP_TOOLCHAIN=${rustChannel}
    export CARGO_TARGET_WASM32_UNKNOWN_UNKNOWN_LINKER=lld
    export CARGO_HOME=$HOME/.cargo
    export PATH=$CARGO_HOME/bin:$PATH
    rustup install ${rustChannel}
    rustup default ${rustChannel}
    rustup target add ${rustTarget}
    echo "Rust environment set up for wasm32-unknown-unknown target"
  '';
}

