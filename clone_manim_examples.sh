#!/bin/bash

# Exit on any error
set -e

TARGET_DIR="external_examples"
echo "Creating directory: $TARGET_DIR"
mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR"

# Helper function to clone repository shallowly if it doesn't already exist
clone_repo() {
    local repo_url=$1
    local dir_name=$2
    if [ -d "$dir_name" ]; then
        echo "Repository $dir_name already exists, skipping."
    else
        echo "Cloning $repo_url into $dir_name (shallow clone)..."
        git clone --depth 1 "$repo_url" "$dir_name"
    fi
}

echo "=== Starting cloning of Manim example repositories ==="

# 1. manim_sandbox (Huge community sandbox repository)
clone_repo "https://github.com/manim-kindergarten/manim_sandbox.git" "manim_sandbox"

# 2. manim-with-ease (Clean, modern ManimCE code by core contributor)
clone_repo "https://github.com/behackl/manim-with-ease.git" "manim_with_ease"

# 3. Manim-Examples by TannerGilbert (Great basic/intermediate guides)
clone_repo "https://github.com/TannerGilbert/Manim-Examples.git" "manim_examples_tannergilbert"

# 4. MVPS by Tom-Edgar (Mathematical curve animations)
clone_repo "https://github.com/Tom-Edgar/MVPS.git" "mvps_tom_edgar"

# 5. 3b1b/videos (The official 3Blue1Brown videos repository - Optional / Large)
clone_repo "https://github.com/3b1b/videos.git" "3b1b_videos"

echo "=== All repositories successfully cloned into '$TARGET_DIR/' ==="
echo "You can now use these scripts as context or examples for your AI model."
