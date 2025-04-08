# NixOS (btrfs)
## Installation
### Format

replace `'"/dev/sda"'` with your drive
```bash
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko --flake github:travbp/nix-config#nixos-prod --arg device '"/dev/sda"'
```

### Install

```bash
sudo nixos-install --flake github:travbp/nix-config#nixos-prod --no-root-passwd
```

### Reboot

```bash
reboot
```


## Finding Files to Persist
```bash
nix run nixpkgs#fd -- --one-file-system --base-directory / --type f --hidden --exclude "{tmp,etc/passwd,root/.cache}"
```

clean output
```
etc/.clean
etc/.updated
etc/NIXOS
etc/group
etc/machine-id
etc/resolv.conf
etc/shadow
etc/subgid
etc/subuid
etc/sudoers
root/.nix-channels
var/.updated
```

## Converting Docker Compose to Nix Compose
```bash
nix run github:aksiksi/compose2nix -- -project=<project_name> -runtime=docker
```