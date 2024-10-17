# SiteLaunch

**SiteLaunch** is a lightweight tool designed for network administrators to expose local websites or services to the public internet. It facilitates the starting and stopping of local services while forwarding them to a public-facing IP and port. This tool serves as a testing script to help in network management and service exposure.


![alt text](img/white-sitelaunch.png)



## Table of Contents
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Logging](#logging)
- [Directory Structure](#directory-structure)
- [Contributors](#contributors)
- [Credits](#credits)

## Prerequisites

To ensure you can ping your public IP and that the provided script works correctly for TCP port forwarding, follow these essential steps:

### 1. **Enable ICMP on Your Router**
ICMP (Internet Control Message Protocol) allows devices on a network to send error messages and operational information, including the ability to respond to `ping` requests. Enabling ICMP on your router is crucial for allowing `ping` traffic.

- **Access Router Settings**:
  1. Open a web browser and enter your router's IP address in the address bar. Common IP addresses include `192.168.1.1`, `192.168.0.1`, or other variations based on your router's make and model.
  2. Log in with your admin credentials. If you haven't changed them, these are often found on a sticker on the router or in the user manual.

- **Find ICMP Settings**:
  1. Navigate to the section that includes firewall settings, security settings, or advanced settings. This location varies by router brand.
  2. Look for options related to ICMP or specifically labeled as "Allow ping" or "Enable ICMP." Make sure this option is enabled to allow incoming ping requests.

### 2. **Configure Host Firewall**
If your server operates with a firewall, such as `iptables`, it must allow ICMP traffic to ensure `ping` requests can reach your machine.

- To allow incoming ICMP requests, execute the following commands in your terminal:
   ```bash
   sudo iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
   sudo iptables -A OUTPUT -p icmp --icmp-type echo-reply -j ACCEPT
   ```
   - The first command permits incoming echo requests (ping).
   - The second command allows outgoing echo replies.

### 3. **Check Public IP Accessibility**
Once you have configured both your router and the host firewall, you can verify if your public IP is accessible:

- **Ping Your Public IP**:
   Open a terminal (or Command Prompt on Windows) and run the following command:
   ```bash
   ping <your_public_ip>
   ```
   - Replace `<your_public_ip>` with your actual public IP address. You can find your public IP by searching "what is my IP" in a web browser.

### 4. **Ensure the Script Functions**
To ensure that the provided script works for port forwarding effectively, follow these steps:

1. **Run the Script**:
   Execute the script using the correct parameters as shown below:
   ```bash
   ./sitelaunch.sh <LOCAL_IP> <LOCAL_PORT> start
   ```
   - Replace `<LOCAL_IP>` with the local IP address of the service you want to expose.
   - Replace `<LOCAL_PORT>` with the port number where your service is running.
   - Use the `start` command to initiate exposure.

   **Example**:
   ```bash
   ./sitelaunch.sh 192.168.1.10 8080 start
   ```

2. **Test TCP Forwarding**:
   - After successfully running the script, test TCP port forwarding by attempting to connect to your public IP on the specified port. You can use tools like `telnet` or `curl` to check connectivity:
   ```bash
   telnet <your_public_ip> <public_port>
   ```
   - Replace `<public_port>` with the port you forwarded in the script. If the connection is successful, you should see a response indicating that the service is accessible.

### 5. **Double Check Your Configuration**
After setting everything up, ensure your configuration is correct:

- **Firewall Logs**: Monitor your firewall logs to verify that ICMP requests are being accepted and that no other firewall rules are unintentionally blocking traffic.
- **Service Running**: Confirm that the service you want to access is running on the local machine and is actively listening on the specified port. You can use commands like `netstat -tuln` to check active connections and listening ports.

### Summary
Following these detailed steps should enable you to successfully ping your public IP and confirm that the TCP port forwarding script operates as intended. If you encounter any issues, review each step carefully, and verify your configurations on both the router and server to ensure proper setup.

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

This process will install the required dependencies, set up permissions, and create the necessary log directories.

## Usage

### Running a Local Service

To expose a local service to the public internet, use the following command:
```bash
./sitelaunch <ip> <port> start
```
- `<ip>`: Local IP address where the service is running.
- `<port>`: Port on which the local service is running.
- `start`: Command to start exposing the service.

**Example**:
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

**Example**:
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