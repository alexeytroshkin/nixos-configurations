commit:
    git add .
    git commit -m $(uuidgen)

push:
    git add .
    git commit -m $(uuidgen)
    git push

sops file:
    EDITOR="code --wait" nix run nixpkgs#sops -- ./modules/nixos/sops/secrets/{{file}}

rebuild command host target="":
    nix run --inputs-from path:. nixpkgs#nixos-rebuild -- {{command}} --flake path:.#{{host}} \
        --target-host p47hf1nd3r@{{ if target == "" { host } else { target } }} \
        --sudo \
        --ask-sudo-password
