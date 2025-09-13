#!/bin/bash
# Corporate Vim Setup Script
# Run this in Git Bash to set up your development environment

set -e  # Exit on any error

echo "🏢 Setting up Corporate Vim environment..."

# Create vim directories
echo "📁 Creating Vim directories..."
mkdir -p ~/.vim/{backup,swap,undo,autoload,plugged}

# Install vim-plug (plugin manager)
echo "🔌 Installing vim-plug..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Copy the vimrc (you should save the artifact content as .vimrc)
echo "📝 Please save the vimrc configuration to ~/.vimrc"
echo "   You can copy it from the artifact above"

# Install Python packages needed for development
echo "🐍 Installing Python packages..."

# Essential Python development packages
python -m pip install --user flake8 black isort mypy pytest

# Additional useful packages for Python development
python -m pip install --user autopep8 rope jedi pylint bandit

# Python package management
python -m pip install --user pdm

# Configure PDM
python -m pdm --pep582
python -m pdm config --global python.use_venv False

# Install Node.js packages if Node is available
if command -v npm &> /dev/null; then
    echo "📦 Installing Node.js packages..."
    npm install -g prettier eslint pyright
else
    echo "⚠️  Node.js not found. Skipping Node.js packages."
    echo "   Consider installing Node.js for additional tooling support."
fi

# Create a sample Python project structure
echo "🏗️  Creating sample Python project structure..."

rm -rf ~/python_projects/sample_project/
mkdir -p ~/python_projects/sample_project/{src,tests,docs}

python -m pdm init --project ~/python_projects/sample_project/ --non-interactive --overwrite

cat > ~/python_projects/sample_project/src/__init__.py << 'EOF'
"""Sample Python project."""

__version__ = "0.1.0"
EOF

cat > ~/python_projects/sample_project/src/main.py << 'EOF'
"""Main module for sample project."""


def hello_world(name: str = "World") -> str:
    """Return a greeting message.
    
    Args:
        name: The name to greet.
        
    Returns:
        A greeting message.
    """
    return f"Hello, {name}!"


def main() -> None:
    """Main entry point."""
    print(hello_world())


if __name__ == "__main__":
    main()
EOF

cat > ~/python_projects/sample_project/tests/__init__.py << 'EOF'
"""Tests for sample project."""
EOF

cat > ~/python_projects/sample_project/tests/test_main.py << 'EOF'
"""Tests for main module."""

import pytest
from src.main import hello_world


def test_hello_world_default():
    """Test hello_world with default parameter."""
    result = hello_world()
    assert result == "Hello, World!"


def test_hello_world_custom_name():
    """Test hello_world with custom name."""
    result = hello_world("Alice")
    assert result == "Hello, Alice!"


def test_hello_world_empty_string():
    """Test hello_world with empty string."""
    result = hello_world("")
    assert result == "Hello, !"
EOF

# Create configuration files for tools
echo "⚙️  Creating configuration files..."

# Black configuration
cat >> ~/python_projects/sample_project/pyproject.toml << 'EOF'
[tool.black]
line-length = 88
target-version = ['py38', 'py39', 'py310', 'py311']
include = '\.pyi?$'
extend-exclude = '''
/(
  # directories
  \.eggs
  | \.git
  | \.hg
  | \.mypy_cache
  | \.tox
  | \.venv
  | venv
  | _build
  | buck-out
  | build
  | dist
)/
'''

[tool.isort]
profile = "black"
multi_line_output = 3
line_length = 88

[tool.mypy]
python_version = "3.10"
strict = true
show_absolute_path = false


[tool.pytest.ini_options]
testpaths = ["tests"]
addopts = "-v --tb=short"
EOF

# Create a simple Makefile for common tasks
cat > ~/python_projects/sample_project/Makefile << 'EOF'
.PHONY: format lint test clean help

help:  ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

format:  ## Format code with black and isort
	python -m isort src tests
	python -m black src tests

lint:  ## Lint code with flake8 and mypy
	python -m mypy src

test:  ## Run tests with pytest
	python -m pytest

clean:  ## Clean up cache files
	find . -type f -name "*.pyc" -delete
	find . -type d -name "__pycache__" -delete
	find . -type d -name "*.egg-info" -exec rm -rf {} +
	find . -type d -name ".pytest_cache" -exec rm -rf {} +
	find . -type d -name ".mypy_cache" -exec rm -rf {} +
EOF

# Create aliases file for Git Bash
echo "🔗 Creating useful aliases..."
cat > ~/.bash_aliases << 'EOF'
# Corporate Vim Development Aliases

# Python development
alias py='python'
alias pym='python -m'
alias pytest='python -m pytest'
alias black='python -m black'
alias flake8='python -m flake8'
alias isort='python -m isort'
alias mypy='python -m mypy'

# Git shortcuts
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'

# Directory navigation
alias ll='ls -la'
alias la='ls -la'
alias ..='cd ..'
alias ...='cd ../..'

# Vim shortcuts
alias vi='vim'
alias v='vim'

# Project shortcuts
alias proj='cd ~/python_projects'
alias sample='cd ~/python_projects/sample_project'
EOF

# Add to .bashrc if it exists
if [ -f ~/.bashrc ]; then
    echo "" >> ~/.bashrc
    echo "# Load custom aliases" >> ~/.bashrc
    echo "if [ -f ~/.bash_aliases ]; then" >> ~/.bashrc
    echo "    . ~/.bash_aliases" >> ~/.bashrc
    echo "fi" >> ~/.bashrc
fi

echo ""
echo "✅ Corporate Vim setup complete!"
echo ""
echo "📋 Next steps:"
echo "1. Copy the vimrc configuration from the artifact to ~/.vimrc"
echo "2. Open Vim and run :PlugInstall to install plugins"
echo "3. Restart your Git Bash session to load aliases"
echo "4. Navigate to ~/python_projects/sample_project and try: vim src/main.py"
echo ""
echo "🎯 Key shortcuts in Vim:"
echo "   ,w  - Save file"
echo "   ,r  - Run Python file"
echo "   ,t  - Run tests with pytest"
echo "   ,f  - Format with Black"
echo "   ,l  - Lint with Flake8"
echo "   Ctrl+n - Toggle file tree"
echo "   Ctrl+p - Fuzzy file finder"
echo "   F5  - Run current Python file"
echo "   F6  - Run as Python module"
echo ""
echo "🔧 Available Python tools:"
echo "   python -m black <file>     - Format code"
echo "   python -m flake8 <file>    - Lint code"
echo "   python -m pytest           - Run tests"
echo "   python -m mypy <file>      - Type checking"
echo "   python -m isort <file>     - Sort imports"
echo ""
echo "Happy coding! 🚀"
