#!/usr/bin/env python3
import os
import sys
import platform
import subprocess
import shutil
from pathlib import Path

# Color helpers for terminal output
class Colors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

def print_status(msg, color=Colors.OKBLUE):
    print(f"{color}{Colors.BOLD}==> {msg}{Colors.ENDC}")

def print_success(msg):
    print_status(msg, Colors.OKGREEN)

def print_error(msg):
    print_status(msg, Colors.FAIL)

def print_warning(msg):
    print_status(msg, Colors.WARNING)

def check_python_version():
    print_status("Checking Python version...")
    major, minor = sys.version_info[:2]
    print(f"Found Python: {major}.{minor}")
    if (major, minor) < (3, 7):
        print_error("Python 3.7 or higher is required.")
        sys.exit(1)
    print_success("Python version is compatible.")

def install_system_dependencies(system_os):
    print_status(f"Installing system dependencies for OS: {system_os}")
    
    if system_os == "Darwin":  # macOS
        if shutil.which("brew"):
            print_status("Installing dependencies via Homebrew...")
            try:
                subprocess.run(["brew", "install", "ffmpeg"], check=True)
                print_success("FFmpeg installed successfully.")
                print_warning("Note: LaTeX (mactex) can optionally be installed manually via 'brew install --cask mactex'")
            except subprocess.CalledProcessError as e:
                print_error(f"Failed to install dependencies via Homebrew: {e}")
        else:
            print_error("Homebrew not found. Please install Homebrew first (https://brew.sh) or install ffmpeg manually.")
            
    elif system_os == "Linux":
        if shutil.which("apt-get"):
            print_status("Installing Linux dependencies via apt-get...")
            try:
                subprocess.run(["sudo", "apt-get", "update"], check=True)
                subprocess.run(["sudo", "apt-get", "install", "-y", "ffmpeg", "libpango1.0-dev", "pkg-config", "python3-dev"], check=True)
                print_success("Linux dependencies installed.")
                print_warning("Note: Optional LaTeX can be installed via 'sudo apt-get install -y texlive-full'")
            except subprocess.CalledProcessError as e:
                print_error(f"Failed to install dependencies: {e}")
        elif shutil.which("yum"):
            print_status("Installing Linux dependencies via yum...")
            try:
                subprocess.run(["sudo", "yum", "install", "-y", "ffmpeg", "pango-devel", "pkgconfig", "python3-devel"], check=True)
                print_success("Linux dependencies installed.")
            except subprocess.CalledProcessError as e:
                print_error(f"Failed to install dependencies: {e}")
        elif shutil.which("pacman"):
            print_status("Installing Linux dependencies via pacman...")
            try:
                subprocess.run(["sudo", "pacman", "-S", "--noconfirm", "ffmpeg", "pango", "pkgconf", "python"], check=True)
                print_success("Linux dependencies installed.")
            except subprocess.CalledProcessError as e:
                print_error(f"Failed to install dependencies: {e}")
        else:
            print_error("Unsupported package manager. Please install 'ffmpeg', 'pango', and development headers manually.")
            
    elif system_os == "Windows":
        print_status("Checking for FFmpeg on Windows...")
        if shutil.which("ffmpeg"):
            print_success("FFmpeg already installed and in PATH.")
        else:
            print_warning("FFmpeg was not found in PATH.")
            if shutil.which("winget"):
                print_status("Attempting to install FFmpeg via winget...")
                try:
                    subprocess.run(["winget", "install", "Gyan.FFmpeg"], check=True)
                    print_success("FFmpeg installed via winget! Please restart your terminal for PATH changes to take effect.")
                except subprocess.CalledProcessError:
                    print_error("Failed to install FFmpeg via winget automatically. Please install FFmpeg manually.")
            else:
                print_error("Please install FFmpeg manually and add it to your System PATH: https://ffmpeg.org/download.html")

def setup_virtual_environment(system_os):
    print_status("Setting up virtual environment...")
    venv_dir = Path("manim_env")
    
    if not venv_dir.exists():
        try:
            subprocess.run([sys.executable, "-m", "venv", "manim_env"], check=True)
            print_success("Created virtual environment: manim_env")
        except subprocess.CalledProcessError as e:
            print_error(f"Failed to create virtual environment: {e}")
            sys.exit(1)
    else:
        print_success("Using existing virtual environment: manim_env")

    # Define paths to executables inside virtual environment
    if system_os == "Windows":
        pip_path = venv_dir / "Scripts" / "pip.exe"
        python_path = venv_dir / "Scripts" / "python.exe"
    else:
        pip_path = venv_dir / "bin" / "pip"
        python_path = venv_dir / "bin" / "python"

    # Upgrade pip and install ManimGL
    print_status("Upgrading pip inside virtual environment...")
    try:
        subprocess.run([str(pip_path), "install", "--upgrade", "pip"], check=True)
        print_status("Installing ManimGL inside virtual environment...")
        subprocess.run([str(pip_path), "install", "manimgl"], check=True)
        print_success("ManimGL successfully installed!")
    except subprocess.CalledProcessError as e:
        print_error(f"Failed to install Python packages: {e}")
        sys.exit(1)

def clone_examples():
    print_status("=== Cloning Manim Example Repositories ===")
    
    target_dir = Path("external_examples")
    target_dir.mkdir(exist_ok=True)
    
    repos = {
        "manim_sandbox": "https://github.com/manim-kindergarten/manim_sandbox.git",
        "manim_with_ease": "https://github.com/behackl/manim-with-ease.git",
        "manim_examples_tannergilbert": "https://github.com/TannerGilbert/Manim-Examples.git",
        "mvps_tom_edgar": "https://github.com/Tom-Edgar/MVPS.git",
        "3b1b_videos": "https://github.com/3b1b/videos.git"
    }
    
    if not shutil.which("git"):
        print_error("git command not found. Please install git to clone examples.")
        return
        
    for name, url in repos.items():
        repo_path = target_dir / name
        if repo_path.exists():
            print(f"Repository {name} already exists. Skipping.")
        else:
            print_status(f"Cloning {name} (shallow clone)...")
            try:
                subprocess.run(["git", "clone", "--depth", "1", url, str(repo_path)], check=True)
                print_success(f"Successfully cloned {name}")
            except subprocess.CalledProcessError as e:
                print_error(f"Failed to clone {name}: {e}")

def main():
    system_os = platform.system()
    check_python_version()
    
    print("\n" + "="*50)
    print("      Manim Setup and Examples Downloader")
    print("="*50)
    print("1. Install system dependencies & setup environment (Install ManimGL)")
    print("2. Clone curated Manim example repositories")
    print("3. Both (Full Setup)")
    print("4. Exit")
    print("="*50)
    
    choice = input("Enter your choice [1-4]: ").strip()
    
    if choice == "1":
        install_system_dependencies(system_os)
        setup_virtual_environment(system_os)
    elif choice == "2":
        clone_examples()
    elif choice == "3":
        install_system_dependencies(system_os)
        setup_virtual_environment(system_os)
        clone_examples()
    elif choice == "4":
        print_status("Exiting setup.")
    else:
        print_error("Invalid choice. Exiting.")

if __name__ == "__main__":
    main()
