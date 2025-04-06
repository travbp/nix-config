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
