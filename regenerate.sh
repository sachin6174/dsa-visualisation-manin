#!/bin/bash

# ==============================================================================
# DSA Visualisation Manim - Repository Regeneration Script
# ==============================================================================
# This script automates the complete restoration of all git-ignored files and 
# environments required to run the animations.
# ==============================================================================

# Exit immediately if a command exits with a non-zero status
set -e

# Formatting colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Print help message
show_help() {
    echo "Usage: ./regenerate.sh [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -c, --clean     Wipe existing environment, examples, and media before regenerating"
    echo "  -e, --env       Set up Python virtual environment and dependencies (manim, manimgl)"
    echo "  -x, --examples  Clone external Manim examples (shallow clone)"
    echo "  -m, --media     Re-render all array visualizations to media/"
    echo "  -a, --all       Wipe, rebuild environment, download examples, and render media (full restoration)"
    echo "  -h, --help      Show this help message"
    echo ""
    echo "If no options are specified, the script will interactive prompt or run all steps safely."
}

# Flags
CLEAN=false
SETUP_ENV=false
CLONE_EXAMPLES=false
RENDER_MEDIA=false
RUN_ALL=false

# Parse arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -c|--clean) CLEAN=true ;;
        -e|--env) SETUP_ENV=true ;;
        -x|--examples) CLONE_EXAMPLES=true ;;
        -m|--media) RENDER_MEDIA=true ;;
        -a|--all) RUN_ALL=true ;;
        -h|--help) show_help; exit 0 ;;
        *) log_error "Unknown parameter passed: $1"; show_help; exit 1 ;;
    esac
    shift
done

# If no flags are provided, run interactive selection or default to non-destructive all
if [ "$CLEAN" = false ] && [ "$SETUP_ENV" = false ] && [ "$CLONE_EXAMPLES" = false ] && [ "$RENDER_MEDIA" = false ] && [ "$RUN_ALL" = false ]; then
    log_info "No options specified. Starting interactive recovery..."
    echo "--------------------------------------------------------"
    echo "Select an option:"
    echo "1) Full Regeneration (Clean + Re-env + Re-examples)"
    echo "2) Repair Environment & Examples (Non-destructive)"
    echo "3) Re-render Animations (Generate videos)"
    echo "4) Exit"
    echo "--------------------------------------------------------"
    read -p "Enter choice [1-4]: " choice
    case $choice in
        1) CLEAN=true; SETUP_ENV=true; CLONE_EXAMPLES=true ;;
        2) SETUP_ENV=true; CLONE_EXAMPLES=true ;;
        3) RENDER_MEDIA=true ;;
        *) log_info "Exiting without doing anything."; exit 0 ;;
    esac
fi

if [ "$RUN_ALL" = true ]; then
    CLEAN=true
    SETUP_ENV=true
    CLONE_EXAMPLES=true
    RENDER_MEDIA=true
fi

# Ensure other scripts are executable
chmod +x install_manim.sh clone_manim_examples.sh 2>/dev/null || true

# 1. Clean Phase
if [ "$CLEAN" = true ]; then
    log_warning "Cleaning up existing directories..."
    if [ -d "manim_env" ]; then
        log_info "Removing manim_env/..."
        rm -rf manim_env
    fi
    if [ -d "external_examples" ]; then
        log_info "Removing external_examples/..."
        rm -rf external_examples
    fi
    if [ -d "media" ]; then
        log_info "Removing media/..."
        rm -rf media
    fi
    log_success "Cleanup complete."
fi

# 2. Virtual Environment Setup Phase
if [ "$SETUP_ENV" = true ]; then
    log_info "Setting up Python virtual environment..."
    
    # Check Python
    if ! command -v python3 &> /dev/null; then
        log_error "Python 3 is required but not found. Please install Python 3.7+ first."
        exit 1
    fi

    # Check dependencies (Homebrew/system dependencies)
    log_info "Verifying system requirements (ffmpeg, etc.)...."
    # We call the install_manim.sh script which checks OS and installs ffmpeg if missing
    ./install_manim.sh
    
    # Install the community version of manim as well, since ArrayVisualization.py uses standard manim
    log_info "Ensuring both manimgl (3b1b) and manim (community) are installed..."
    source manim_env/bin/activate
    python -m pip install manim
    deactivate
    
    log_success "Virtual environment setup completed successfully."
fi

# 3. Examples Cloning Phase
if [ "$CLONE_EXAMPLES" = true ]; then
    log_info "Cloning external Manim examples..."
    ./clone_manim_examples.sh
    log_success "Examples cloned successfully."
fi

# 4. Rendering Phase
if [ "$RENDER_MEDIA" = true ]; then
    log_info "Rendering Array visualizations..."
    if [ ! -d "manim_env" ]; then
        log_error "Virtual environment (manim_env) is missing! Run with -e first."
        exit 1
    fi
    
    source manim_env/bin/activate
    
    # Render ArrayVisualization scene in ArrayInSwift directory
    log_info "Rendering ArrayVisualization scene..."
    manim ArrayInSwift/ArrayVisualization.py ArrayVisualization -ql --media_dir media
    
    # Render BubbleSortVisualization scene
    log_info "Rendering BubbleSortVisualization scene..."
    manim ArrayInSwift/ArrayVisualization.py BubbleSortVisualization -ql --media_dir media
    
    deactivate
    log_success "Render completed! Check media/videos for the generated MP4 files."
fi

log_success "Regeneration tasks completed successfully!"
