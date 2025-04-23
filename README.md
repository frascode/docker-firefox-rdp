# Firefox via RDP

Firefox in a container based on Ubuntu 20.04, accessible via RDP.

## Features

- Remote access to Firefox via RDP protocol (port 3389)
- Configure initial URL using environment variable
- Enable/disable kiosk mode
- Scalability for HiDPI displays

## Usage

### Build the container
```
docker build -t firefox-rdp .
```

### Start the container with default settings

```
docker run -d -p 3389:3389 --name firefox firefox-rdp
```

### Start the container with custom configuration

```
docker run -d \
  -p 3389:3389 \
  -e KIOSK_MODE=false \
  -e START_URL="https://www.google.com" \
  -e SCALE=1 \
  -e RESOLUTION="1366x768x24" \
  --name firefox firefox-rdp
```

## Available Environment Variables

| Variable | Description | Default Value |
|-----------|-------------|-------------------|
| KIOSK_MODE | Enable/disable full-screen mode | true |
| START_URL | Initial URL to load at startup | about:blank |
| SCALE | Scale factor for HiDPI displays | 1 |
| RESOLUTION | Virtual screen resolution | 1366x768x24 |

## Connection

Use an RDP client such as Remmina, Microsoft Remote Desktop, or mstsc.exe to connect to the container:

- Address: `localhost` (or the IP address of your Docker server)
- Port: `3389`
- Username: `user`
- Password: `user`

## Technical Notes

The container includes both VNC and RDP services internally, but only the RDP port is exposed externally. VNC runs listening only on localhost, ensuring that only RDP is accessible from outside.

Firefox is configured to always start with a clean session, without restoring previous tabs or session states. This ensures a consistent starting experience every time the container is restarted.

## Security

For production environments, consider:
- Changing the default user password
- Using an HTTPS proxy for secure external access
- Limiting the container's network access
