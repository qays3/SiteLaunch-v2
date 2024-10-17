package main

import (
	"log"
	"os"
	"os/exec"
)

func main() {
	if len(os.Args) != 4 {
		log.Fatalf("Usage: %s <ip> <port> <start|stop>\n", os.Args[0])
	}

	localIP := os.Args[1]
	localPort := os.Args[2]
	action := os.Args[3]

	cmd := exec.Command("./scripts/sitelaunch.sh", localIP, localPort, action)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr

	if err := cmd.Run(); err != nil {
		log.Fatalf("Error executing sitelaunch.sh: %v\n", err)
	}
}
