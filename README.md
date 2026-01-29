# V2Ray Installation & Management Script

A secure, self-contained V2Ray installation and management script. All binaries are hosted in this repository - no external downloads from third-party sources.

## Features

- **Secure Installation** - All binaries downloaded from this repository only
- **One-Click Install** - Simple installation process
- **Easy Management** - Intuitive command-line interface
- **Auto TLS** - Automatic TLS configuration with Caddy
- **Multiple Protocols** - Support for various proxy protocols:
  - VMess (TCP/mKCP/QUIC/WS/H2/gRPC)
  - VLESS (WS/H2/gRPC with TLS)
  - Trojan (WS/H2/gRPC with TLS)
  - Shadowsocks
  - Socks5
- **Dynamic Ports** - VMess with dynamic port support
- **Built-in Protection** - Block BT traffic and China IPs
- **BBR Support** - TCP congestion control optimization

## System Requirements

- Ubuntu 18.04+ / Debian 9+ / CentOS 7+
- 64-bit system (x86_64 or ARM64)
- Root privileges
- systemd

## Quick Installation

```bash
# 1. Install dependencies
apt update -y && apt install -y wget unzip git

# 2. Clone this repository
git clone https://github.com/charmgene/wall.git

# 3. Navigate to code directory
cd wall/code

# 4. Run installer
bash install.sh -l
```

## Installation Options

```bash
# Standard installation (recommended)
bash install.sh -l

# With proxy for downloading
bash install.sh -l -p http://127.0.0.1:8080

# Specify V2Ray version
bash install.sh -l -v v5.4.1

# Use local V2Ray file
bash install.sh -l -f /path/to/v2ray-linux-64.zip
```

## Usage

After installation, use the `v2ray` command:

```bash
v2ray          # Show main menu
v2ray help     # Show help
v2ray status   # Check status
```

### Basic Commands

| Command | Description |
|---------|-------------|
| `v2ray` | Interactive main menu |
| `v2ray status` | Show running status |
| `v2ray start` | Start V2Ray |
| `v2ray stop` | Stop V2Ray |
| `v2ray restart` | Restart V2Ray |
| `v2ray log` | View access log |
| `v2ray logerr` | View error log |

### Configuration Management

| Command | Description |
|---------|-------------|
| `v2ray add [protocol]` | Add new configuration |
| `v2ray info [name]` | View configuration |
| `v2ray del [name]` | Delete configuration |
| `v2ray url [name]` | Get share URL |
| `v2ray qr [name]` | Show QR code |

### Add Protocols

```bash
# VMess TCP
v2ray add tcp

# VMess WebSocket + TLS
v2ray add ws example.com

# VLESS WebSocket + TLS
v2ray add vws example.com

# Trojan WebSocket + TLS
v2ray add tws example.com

# Shadowsocks
v2ray add ss

# VMess with dynamic ports
v2ray add tcpd
```

### Change Configuration

```bash
v2ray port [name] [port]      # Change port
v2ray id [name] [uuid]        # Change UUID
v2ray passwd [name] [pass]    # Change password
v2ray host [name] [domain]    # Change domain
v2ray path [name] [path]      # Change path
```

### Update & Maintenance

```bash
v2ray update core             # Update V2Ray core
v2ray update dat              # Update geo data files
v2ray update caddy            # Update Caddy
v2ray bbr                     # Enable BBR
v2ray test                    # Test configuration
v2ray reinstall               # Reinstall script
v2ray uninstall               # Uninstall
```

## TLS Configuration

For TLS-based protocols, Caddy handles automatic certificate management.

### Requirements:
1. Valid domain name
2. Domain resolves to server IP
3. Ports 80 and 443 available

### Manual TLS (no-auto-tls)

If using CDN or custom certificates:

```bash
v2ray no-auto-tls ws example.com
```

## Directory Structure

```
/etc/v2ray/
├── bin/           # V2Ray binary and geo files
├── conf/          # Configuration files
├── sh/            # Script files
└── config.json    # Main configuration

/var/log/v2ray/
├── access.log     # Access log
└── error.log      # Error log
```

## Troubleshooting

### Check Status
```bash
v2ray status
systemctl status v2ray
```

### View Logs
```bash
v2ray log           # Access log
v2ray logerr        # Error log
journalctl -u v2ray -f
```

### Test Configuration
```bash
v2ray test
```

### Common Issues

**Port in use:**
```bash
netstat -tlnp | grep <port>
```

**Domain not resolving:**
```bash
dig your-domain.com
```

**TLS issues:**
```bash
journalctl -u caddy -f
```

## Security

- All downloads from this repository only
- No third-party script execution
- Script updates disabled by default
- SSL certificate verification enabled

## Repository Structure

```
wall/
├── README.md           # This file
├── wall.sh             # Quick installer
├── code/
│   ├── install.sh      # Main installer
│   ├── v2ray.sh        # Entry point
│   ├── README.md       # Detailed documentation
│   └── src/            # Script modules
└── release-assets/     # (gitignored) Binary files
```

## Release Assets

The following files are included in releases:

| File | Description |
|------|-------------|
| `v2ray-linux-64.zip` | V2Ray core (x86_64) |
| `v2ray-linux-arm64-v8a.zip` | V2Ray core (ARM64) |
| `jq-linux-amd64` | jq binary (x86_64) |
| `jq-linux-arm64` | jq binary (ARM64) |
| `caddy_linux_amd64.tar.gz` | Caddy (x86_64) |
| `caddy_linux_arm64.tar.gz` | Caddy (ARM64) |
| `geoip.dat` | GeoIP database |
| `geosite.dat` | GeoSite database |
| `code.zip` | Script files |

## License

[GNU General Public License v3.0](code/LICENSE)

## Support

- [GitHub Issues](https://github.com/charmgene/wall/issues)
