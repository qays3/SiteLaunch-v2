package main

import (
	"log"
	"os"
	"os/exec"
)

func main() {
	if len(os.Args) != 5 {
		log.Fatal("Usage: sitelaunch <ip> <port> <start|stop>")
	}
	ip := os.Args[1]
	port := os.Args[2]
	action := os.Args[3]

	cmd := exec.Command("./scripts/sitelaunch.sh", ip, port, action)
	err := cmd.Run()
	if err != nil {
		log.Fatalf("Error executing command: %v", err)
	}
}
