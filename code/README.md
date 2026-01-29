# V2Ray One-Click Installation Script

The easiest V2Ray installation & management script.

## Features

- **Quick Installation** - One command to install
- **Zero Learning Curve** - Simple and intuitive commands
- **Automatic TLS** - Auto-configure TLS with Caddy
- **API Operations** - Manage configs via API
- **V2Ray Compatible** - Full V2Ray command compatibility
- **Multiple Protocols** - Support for all common protocols:
  - Shadowsocks
  - VMess (TCP/mKCP/QUIC)
  - VMess (WS/H2/gRPC)-TLS
  - VLESS (WS/H2/gRPC)-TLS
  - Trojan (WS/H2/gRPC)-TLS
  - VMess with Dynamic Ports
- **Built-in Protection** - Block BT traffic and China IPs
- **BBR Support** - One-click BBR optimization
- **Easy Management** - Change port/UUID/password/domain/path and more

## System Requirements

- Ubuntu 18.04+ / Debian 9+ / CentOS 7+
- 64-bit system (x86_64 or arm64)
- Root privileges
- systemd

## Installation on Ubuntu Server

### Quick Start

```bash
# 1. Update system packages
apt update -y && apt install -y wget unzip git

# 2. Clone the repository
git clone https://github.com/233boy/v2ray.git

# 3. Navigate to the directory
cd v2ray

# 4. Run the installer (local install mode)
bash install.sh -l
```

### Installation Options

```bash
# Standard local installation
bash install.sh -l

# Use proxy for downloading V2Ray core
bash install.sh -l -p http://127.0.0.1:2333

# Specify V2Ray core version
bash install.sh -l -v v5.4.1

# Use custom V2Ray core file
bash install.sh -l -f /path/to/v2ray-linux-64.zip
```

### After Installation

After successful installation, use the `v2ray` command to manage your server:

```bash
# Show main menu
v2ray

# Show help
v2ray help

# Check status
v2ray status
```

## Usage Guide

### Basic Commands

| Command | Description |
|---------|-------------|
| `v2ray` | Show main menu |
| `v2ray status` | Check running status |
| `v2ray start` | Start V2Ray |
| `v2ray stop` | Stop V2Ray |
| `v2ray restart` | Restart V2Ray |
| `v2ray log` | View access log |
| `v2ray logerr` | View error log |

### Configuration Management

| Command | Description |
|---------|-------------|
| `v2ray add [protocol]` | Add new configuration |
| `v2ray info [name]` | View configuration details |
| `v2ray del [name]` | Delete configuration |
| `v2ray url [name]` | Get share URL |
| `v2ray qr [name]` | Generate QR code |

### Quick Add Protocols

```bash
# Add VMess TCP
v2ray add tcp

# Add VMess WebSocket + TLS (requires domain)
v2ray add ws example.com

# Add VLESS WebSocket + TLS
v2ray add vws example.com

# Add Trojan WebSocket + TLS
v2ray add tws example.com

# Add Shadowsocks
v2ray add ss

# Add VMess with dynamic ports
v2ray add tcpd
```

### Change Configuration

```bash
# Change port
v2ray port [name] [port | auto]

# Change UUID
v2ray id [name] [uuid | auto]

# Change password
v2ray passwd [name] [password | auto]

# Change domain
v2ray host [name] [domain]

# Change path
v2ray path [name] [path | auto]

# Change encryption method (Shadowsocks)
v2ray method [name] [method | auto]
```

### Update & Maintenance

```bash
# Update V2Ray core
v2ray update core

# Update geo data files
v2ray update dat

# Update Caddy (if installed)
v2ray update caddy

# Enable BBR
v2ray bbr

# Test run
v2ray test

# Reinstall script
v2ray reinstall

# Uninstall
v2ray uninstall
```

## Protocol Examples

### VMess + WebSocket + TLS (Recommended)

```bash
# Add with auto-generated settings
v2ray add ws your-domain.com

# Add with custom UUID
v2ray add ws your-domain.com 12345678-1234-1234-1234-123456789abc

# Add with custom path
v2ray add ws your-domain.com auto /custom-path
```

### VLESS + gRPC + TLS

```bash
v2ray add vgrpc your-domain.com
```

### Trojan + H2 + TLS

```bash
v2ray add th2 your-domain.com
```

### Shadowsocks

```bash
# Add with auto settings
v2ray add ss

# Add with custom port and password
v2ray add ss 12345 my-password aes-256-gcm
```

## TLS Configuration

For TLS-based protocols (WS/H2/gRPC), the script uses Caddy for automatic certificate management.

### Requirements for Auto TLS:

1. A valid domain name
2. Domain must resolve to your server IP
3. Ports 80 and 443 must be available

### Manual TLS (no-auto-tls)

If you're using CDN or have your own certificate:

```bash
v2ray no-auto-tls ws your-domain.com
```

## Directory Structure

```
/etc/v2ray/
├── bin/           # V2Ray binary
├── conf/          # Configuration files
├── sh/            # Script files
└── config.json    # Main config

/var/log/v2ray/
├── access.log     # Access log
└── error.log      # Error log
```

## Troubleshooting

### Check V2Ray Status

```bash
v2ray status
systemctl status v2ray
```

### View Logs

```bash
# Access log
v2ray log

# Error log
v2ray logerr

# Or use journalctl
journalctl -u v2ray -f
```

### Test Configuration

```bash
v2ray test
```

### Common Issues

1. **Port already in use**: Check which process is using the port
   ```bash
   netstat -tlnp | grep <port>
   ```

2. **Domain not resolving**: Ensure DNS A record points to server IP
   ```bash
   dig your-domain.com
   ```

3. **TLS certificate issues**: Check Caddy logs
   ```bash
   journalctl -u caddy -f
   ```

## Security Notes

- Script updates are disabled for security reasons
- Always review code before installation
- Keep V2Ray core updated
- Use strong passwords/UUIDs
- Consider firewall rules

## License

[GNU General Public License v3.0](LICENSE)

## Credits

- Original script by [233boy](https://github.com/233boy)
- V2Ray core by [v2fly](https://github.com/v2fly/v2ray-core)
- Caddy server by [caddyserver](https://github.com/caddyserver/caddy)

## Support

- GitHub Issues: [Report bugs](https://github.com/233boy/v2ray/issues)
- Documentation: [233boy.com](https://233boy.com/v2ray/v2ray-script/)
