<<<<<<< HEAD

# SiteLaunch

SiteLaunch is a lightweight tool to expose your local website or service to the public internet. It allows you to start and stop local services and forward them to a public-facing IP and port.

## Table of Contents
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Logging](#logging)
- [Directory Structure](#directory-structure)
- [Contributors](#contributors)
- [Credits](#credits)

## Installation

To set up the `SiteLaunch` tool, run the following commands:

1. Clone the repository:
    ```bash
    git clone https://github.com/qays3/SiteLaunch.git
    cd SiteLaunch
    ```

2. Make the `setup.sh` script executable and run it:
    ```bash
    chmod +x setup.sh
    ./setup.sh
    ```

This will install the required dependencies, set up permissions, and create the necessary log directories.

## Usage

### Running a Local Service

To expose a local service to the public internet, use the following command:
```bash
./sitelaunch <ip> <port> start
```
- `<ip>`: Local IP address where the service is running.
- `<port>`: Port on which the local service is running.
- `start`: Command to start exposing the service.

For example:
```bash
./sitelaunch 192.168.1.10 8080 start
```

### Stopping a Service

To stop a public service that was previously started, use the following command:
```bash
./sitelaunch <ip> <port> stop
```
- `<ip>`: Local IP address where the service was running.
- `<port>`: Port on which the local service was running.
- `stop`: Command to stop the service.

For example:
```bash
./sitelaunch 192.168.1.10 8080 stop
```

## Configuration

All configurations are handled through the command-line arguments. No additional configuration files are needed.

## Logging

Service logs are automatically generated and stored in the `logs/sitelaunch.log` file. This log file records all the start and stop events for services.

To view the log:
```bash
cat logs/sitelaunch.log
```

## Directory Structure

```plaintext
SiteLaunch/
│
├── docker/
│   ├── Dockerfile
│   └── docker-compose.yml
│
├── scripts/
│   └── sitelaunch.sh
│
├── logs/
│   └── sitelaunch.log    
│
├── main.go             
├── setup.sh                 
├── .env                
└── README.md
```

- **docker/**: Contains the Docker setup for containerizing the tool.
- **scripts/**: Contains the Bash script `sitelaunch.sh` used for starting and stopping services.
- **logs/**: Stores the service logs.
- **main.go**: The Go file that controls the tool and integrates with the Bash script.
- **setup.sh**: The script to install dependencies and set up the tool.

## Contributors

<div style="display: flex; align-items: center; margin-bottom: 20px;">
    <a href="https://github.com/qays3" style="text-decoration: none; display: flex; align-items: center;">
        <img src="https://github.com/qays3.png" alt="@qays3" title="@qays3" width="100px" height="100px" style="border-radius: 50%; margin-right: 10px;">
    </a>
</div>

## Credits

[qays3](https://github.com/qays3) ([Support qays](https://buymeacoffee.com/hidden))
 
=======
# SiteLaunch-v2
>>>>>>> 102a2f92d44d922dbb47a8e3aa35e1d02904ddf9
