package main

import (
	"flag"
	"fmt"
	"log"
	"os"
	"os/exec"
)

var logger *log.Logger

func init() {
	file, err := os.OpenFile("logs/sitelaunch.log", os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0666)
	if err != nil {
		fmt.Println("Could not open log file:", err)
		os.Exit(1)
	}
	logger = log.New(file, "", log.LstdFlags)
}

func LogInfo(message string) {
	logger.Println("INFO: " + message)
}

func LogWarning(message string) {
	logger.Println("WARNING: " + message)
}

func LogError(message string) {
	logger.Println("ERROR: " + message)
}

func LogCritical(message string) {
	logger.Println("CRITICAL: " + message)
}

func runService(localAddr, publicPort string) {
	LogInfo(fmt.Sprintf("Starting service with %s on public port %s...", localAddr, publicPort))
	cmd := exec.Command("./start.sh", "-w", localAddr, "-p", publicPort)
	if err := cmd.Run(); err != nil {
		LogError(fmt.Sprintf("Failed to start service: %v", err))
		os.Exit(1)
	}
	cmd = exec.Command("./deploy.sh")
	if err := cmd.Run(); err != nil {
		LogError(fmt.Sprintf("Failed to deploy service: %v", err))
		os.Exit(1)
	}
	LogInfo(fmt.Sprintf("Public server running on port %s...", publicPort))
}

func stopService() {
	LogInfo("Stopping service...")
	cmd := exec.Command("./cleanup.sh")
	if err := cmd.Run(); err != nil {
		LogError(fmt.Sprintf("Failed to clean up service: %v", err))
		os.Exit(1)
	}
	LogInfo("Service stopped.")
}

func main() {
	localAddr := flag.String("w", "", "Local web server address (e.g., localhost:8000)")
	publicPort := flag.String("p", "", "Public port to expose the service")
	run := flag.Bool("run", false, "Run the service")
	stop := flag.Bool("stop", false, "Stop the service")
	flag.Parse()

	if *run {
		if *localAddr == "" || *publicPort == "" {
			LogError("Both -w (local address) and -p (public port) must be specified.")
			os.Exit(1)
		}
		runService(*localAddr, *publicPort)
	}

	if *stop {
		stopService()
	}
}
