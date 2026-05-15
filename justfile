commit:
    git add .
    git commit -m $(uuidgen)

push:
    git add .
    git commit -m $(uuidgen)
    git push

sops file:
    EDITOR="code --wait" nix run nixpkgs#sops -- ./modules/sops/secrets/{{file}}

rebuild command host:
    nix run nixpkgs#nixos-rebuild -- {{command}} --flake .#{{host}} \
        --target-host p47hf1nd3r@{{host}} \
        --sudo \
        --ask-sudo-password
