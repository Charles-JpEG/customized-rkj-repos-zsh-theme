# Customized rkj-repos ZSH Theme

This project is a customized rkj-repos zsh-theme.

## Overview

This is a customized version of the popular rkj-repos Oh My Zsh theme with enhanced functionality for better cross-platform compatibility, particularly optimized for macOS terminal behavior. The theme maintains the elegant two-line prompt format while adding intelligent clear screen handling that preserves prompt state across different operating systems.

## Features

### Visual Elements
- **Two-line prompt layout** for better readability and easier grep searching
- **Git integration** with branch display and status indicators
- **Mercurial (hg) support** with comprehensive repository information
- **Color-coded status indicators**:
  - ✱ Modified files (yellow)
  - ✗ Deleted files (red)
  - + Added files (green)
  - ➦ Renamed files (cyan)
  - ✂ Unmerged files (magenta)
  - ✈ Untracked files (blue)
- **Timestamp display** showing current date and time
- **User and host information** with colorful styling
- **Exit code display** for the last command

### Cross-Platform Terminal Compatibility
- **macOS Cmd+K optimization**: Seamless integration with macOS terminal's Cmd+K shortcut
- **Linux terminal support**: Enhanced clear behavior for various Linux terminal emulators
- **Windows compatibility**: Support for Git Bash, WSL, and other Windows terminal environments
- **Smart clear screen handling**: Preserves prompt state after terminal clear operations

### Technical Enhancements
- Platform detection and adaptive behavior
- Custom ZLE widgets for improved terminal interaction
- Precmd hooks for consistent prompt rendering
- Fallback mechanisms for different shell environments

## Installation

### Prerequisites
- [Oh My Zsh](https://ohmyz.sh/) installed
- Zsh shell (version 5.0 or higher recommended)

### Method 1: Manual Installation
1. Clone this repository:
   ```bash
   git clone [ORIGINAL_REPO_URL_PLACEHOLDER] ~/.oh-my-zsh/custom/themes/customized-rkj-repos
   ```

2. Copy the theme file:
   ```bash
   cp ~/.oh-my-zsh/custom/themes/customized-rkj-repos/customized-rkj-repos.zsh-theme ~/.oh-my-zsh/custom/themes/
   ```

3. Edit your `~/.zshrc` file and set the theme:
   ```bash
   ZSH_THEME="customized-rkj-repos"
   ```

4. Reload your shell:
   ```bash
   source ~/.zshrc
   ```

### Method 2: Symlink Installation
1. Clone this repository to your preferred location:
   ```bash
   git clone [ORIGINAL_REPO_URL_PLACEHOLDER] ~/path/to/customized-rkj-repos-theme
   ```

2. Create a symlink in your Oh My Zsh custom themes directory:
   ```bash
   ln -s ~/path/to/customized-rkj-repos-theme/customized-rkj-repos.zsh-theme ~/.oh-my-zsh/custom/themes/
   ```

3. Set the theme in your `~/.zshrc`:
   ```bash
   ZSH_THEME="customized-rkj-repos"
   ```

4. Restart your terminal or source your configuration:
   ```bash
   source ~/.zshrc
   ```

## Usage

Once installed, the theme will automatically:
- Display your current Git branch and status when in a Git repository
- Show Mercurial information when in an Hg repository
- Provide timestamp information on each prompt
- Handle terminal clear operations intelligently across different platforms

### Keyboard Shortcuts
- **Ctrl+L**: Clear screen and redraw prompt (cross-platform)
- **Cmd+K** (macOS): Native clear behavior with prompt preservation

## Customization

You can customize various aspects of the theme by modifying the theme file:

### Git Status Symbols
```bash
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[green]%}+"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%}✱"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%}✗"
# ... and more
```

### Colors and Styling
The theme uses Oh My Zsh's color system. You can modify colors by changing the `$fg[color]` and `$fg_bold[color]` values throughout the theme file.

## Platform-Specific Features

### macOS
- Optimized for Terminal.app and iTerm2
- Proper handling of Cmd+K clear behavior
- Enhanced scrollback buffer management

### Linux
- Compatible with popular terminal emulators (GNOME Terminal, Konsole, Alacritty, etc.)
- Optimized clear screen handling for various distributions

### Windows
- Support for Git Bash, Windows Terminal, and WSL environments
- Consistent behavior across different Windows terminal applications

## Troubleshooting

### Prompt Not Displaying Correctly
- Ensure Oh My Zsh is properly installed
- Verify the theme file is in the correct location
- Check that your terminal supports color output

### Git Information Not Showing
- Verify you're in a Git repository
- Ensure Git is installed and accessible in your PATH
- Check that `git config --get oh-my-zsh.hide-status` is not set to "1"

### Clear Screen Issues
- The theme automatically detects your platform and configures appropriate clear behavior
- If issues persist, try manually sourcing your `.zshrc` file

## Contributing

Contributions are welcome! Please feel free to:
- Report bugs or issues
- Suggest new features or improvements
- Submit pull requests with enhancements

## License

This theme is based on the original rkj-repos theme from Oh My Zsh. Please refer to the original project's license terms.

## Acknowledgments

- Original rkj-repos theme creators and contributors
- Oh My Zsh community
- [Original Project](https://github.com/ohmyzsh/ohmyzsh/blob/master/themes/rkj-repos.zsh-theme)

## Changelog

### Latest Version
- Enhanced macOS Cmd+K compatibility
- Cross-platform clear screen optimization
- Improved prompt preservation mechanisms
- Better error handling and fallback options

---

*For more information about Oh My Zsh themes, visit the [official documentation](https://github.com/ohmyzsh/ohmyzsh/wiki/Themes).*
