# SiteLaunch

A tool for deploying local websites to a public IP with ease. SiteLaunch takes your website running on `localhost` and makes it accessible to the public over the internet. Built using Go, Docker, and Bash, it simplifies web deployment on Linux environments.

## Project URL
[https://github.com/qays3/SiteLaunch](https://github.com/qays3/SiteLaunch)

## Features
- Expose any local web server (e.g., `localhost:3000`) to a public IP.
- Simple command-line interface for easy deployment.
- Supports Linux environments for portability.
- Automatically detects web services running on different ports.

## Prerequisites
- Docker
- Go installed on your system
- Linux-based OS

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/qays3/SiteLaunch.git
   ```

2. Navigate to the project directory:
   ```bash
   cd SiteLaunch
   ```

3. Build the Docker container:
   ```bash
   docker build -t sitelaunch .
   ```

4. Install Go dependencies:
   ```bash
   go mod tidy
   ```

## Usage

To make your local website accessible via a public IP, run the following command:

```bash
sitelaunch -w localhost:port deployment
```

### Example
For example, if your website is running on `localhost:8000`:
```bash
sitelaunch -w localhost:8000 deployment
```

This command will take your local website and expose it to a public IP, allowing access from anywhere.

## Folder Structure

```
SiteLaunch/
│
├── docker/
│   ├── Dockerfile
│   └── docker-compose.yml
│
├── scripts/
│   ├── start.sh          
│   ├── deploy.sh         
│   └── cleanup.sh        
│
├── logs/                 
│   └── sitelaunch.log    
│
├── main.go     
├── run.sh          
├── .env                  
└── README.md             


```

## Components

- **Docker**: Used to containerize the application for portability.
- **Go**: Powers the core logic of the tool, handling web server communication and IP exposure.
- **Bash Scripts**: Manages service startup, deployment, and cleanup operations.

 