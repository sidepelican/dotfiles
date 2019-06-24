package main

import (
	"flag"
	"fmt"
	"os/exec"
)

var (
	dryRun bool
)

func do(command string) {
	fmt.Println("\x1b[36m❯", command, "\x1b[0m")
	if dryRun {
		return
	}

	out, err := exec.Command("sh", "-c", command).CombinedOutput()
	if err != nil {
		fmt.Println("\x1b[31mError:", err, "\x1b[0m")
	}
	fmt.Print(string(out))
}

func main() {
	flag.BoolVar(&dryRun, "dry-run", false, "dry run")
	flag.Parse()

	if dryRun {
		fmt.Println("dryRun enabled.")
	}

	dirs := []string{
		"~/Library/Developer/Xcode/UserData/FontAndColorThemes",
		"~/.config",
	}
	for _, dir := range dirs {
		do("mkdir -p " + dir)
	}

	files := []string{
		".vimrc",
		".config/karabiner",
		"Library/Developer/Xcode/UserData/FontAndColorThemes/Default\\ \\(Dark\\).xccolortheme",
		"Library/Developer/Xcode/UserData/FontAndColorThemes/Dusk.xccolortheme",
	}
	for _, file := range files {
		do(fmt.Sprintf("ln -ins ~/projects/dotfiles/%s ~/%s", file, file))
	}
}
