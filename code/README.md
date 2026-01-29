# V2Ray Script - Code Directory

This directory contains the V2Ray installation and management scripts.

## Files

| File | Description |
|------|-------------|
| `install.sh` | Main installation script |
| `v2ray.sh` | Entry point (symlinked to `/usr/local/bin/v2ray`) |
| `src/` | Script modules |

## Script Modules

| File | Purpose |
|------|---------|
| `src/init.sh` | Initialization and variables |
| `src/core.sh` | Core functionality |
| `src/download.sh` | Download management |
| `src/help.sh` | Help and about |
| `src/systemd.sh` | Systemd service management |
| `src/caddy.sh` | Caddy configuration |
| `src/dns.sh` | DNS configuration |
| `src/log.sh` | Log management |
| `src/bbr.sh` | BBR optimization |
| `src/old.sh` | Migration from old versions |

## Installation

```bash
# From the code directory
bash install.sh -l
```

## Options

```bash
-l, --local-install    Use local script files (required)
-f, --core-file PATH   Use custom V2Ray file
-p, --proxy ADDR       Use proxy for downloads
-v, --core-version VER Specify V2Ray version
-h, --help             Show help
```

## Security

- All downloads from `github.com/charmgene/wall` only
- No third-party script execution
- SSL certificate verification enabled

## After Installation

Use the `v2ray` command to manage your server:

```bash
v2ray          # Main menu
v2ray help     # Show all commands
v2ray add tcp  # Add VMess TCP config
v2ray info     # View config
v2ray status   # Check status
```

See the [main README](../README.md) for complete documentation.
