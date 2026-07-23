#!/bin/bash

# Manim (ManimGL) Installation Script
# For 3b1b/manim repository

set -e

echo "🎬 Installing Manim (ManimGL)..."

# Check Python version
python_version=$(python3 --version 2>&1 | awk '{print $2}' | cut -d. -f1,2)
required_version="3.7"

if [ "$(printf '%s\n' "$required_version" "$python_version" | sort -V | head -n1)" != "$required_version" ]; then
    echo "❌ Error: Python 3.7+ required. Found: $python_version"
    exit 1
fi

echo "✅ Python version: $python_version"

# Detect OS
OS="$(uname -s)"
case "${OS}" in
    Linux*)     MACHINE=Linux;;
    Darwin*)    MACHINE=Mac;;
    CYGWIN*)    MACHINE=Cygwin;;
    MINGW*)     MACHINE=MinGw;;
    *)          MACHINE="UNKNOWN:${OS}"
esac

echo "🔍 Detected OS: $MACHINE"

# Install dependencies based on OS
case $MACHINE in
    Mac)
        echo "🍺 Installing dependencies via Homebrew..."
        if ! command -v brew &> /dev/null; then
            echo "❌ Homebrew not found. Please install it first:"
            echo "   /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
            exit 1
        fi
        
        if ! command -v ffmpeg &> /dev/null; then
            echo "🍺 Installing ffmpeg via Homebrew..."
            brew install ffmpeg
        else
            echo "✅ ffmpeg is already installed"
        fi
        
        if ! command -v latex &> /dev/null; then
            echo "🍺 Installing mactex via Homebrew (optional)..."
            brew install --cask mactex || echo "⚠️  Failed to install MacTeX. Proceeding without it (LaTeX is optional)."
        else
            echo "✅ LaTeX (mactex) is already installed"
        fi
        echo "✅ macOS dependencies verified"
        ;;
        
    Linux)
        echo "🐧 Installing Linux dependencies..."
        
        # Detect package manager
        if command -v apt-get &> /dev/null; then
            sudo apt-get update
            sudo apt-get install -y ffmpeg libpango1.0-dev pkg-config python3-dev
            echo "📚 Installing LaTeX (optional, can take a while)..."
            sudo apt-get install -y texlive-full
        elif command -v yum &> /dev/null; then
            sudo yum install -y ffmpeg pango-devel pkgconfig python3-devel
            sudo yum install -y texlive-scheme-full
        elif command -v pacman &> /dev/null; then
            sudo pacman -S ffmpeg pango pkgconf python
            sudo pacman -S texlive-most
        else
            echo "❌ Unsupported Linux package manager. Please install manually:"
            echo "   - ffmpeg"
            echo "   - pango with development headers"
            echo "   - LaTeX distribution (optional)"
            exit 1
        fi
        echo "✅ Linux dependencies installed"
        ;;
        
    *)
        echo "❌ Unsupported OS: $MACHINE"
        echo "Please install dependencies manually:"
        echo "   - FFmpeg"
        echo "   - OpenGL"
        echo "   - LaTeX (optional)"
        exit 1
        ;;
esac

# Create virtual environment (recommended)
echo "🐍 Setting up Python environment..."
if [ ! -d "manim_env" ]; then
    python3 -m venv manim_env
    echo "✅ Created virtual environment: manim_env"
else
    echo "ℹ️  Using existing virtual environment: manim_env"
fi

# Activate virtual environment
source manim_env/bin/activate
echo "✅ Activated virtual environment"

# Upgrade pip
python3 -m pip install --upgrade pip

# Install Manim
echo "🎬 Installing ManimGL..."
python3 -m pip install manimgl

echo "🎉 Installation complete!"
echo ""
echo "To use Manim:"
echo "1. Activate the environment: source manim_env/bin/activate"
echo "2. Test installation: manimgl --version"
echo "3. Run example: manimgl example_scenes.py OpeningManimExample"
echo ""
echo "Note: This installs ManimGL (3b1b/manim), not Manim Community Edition"