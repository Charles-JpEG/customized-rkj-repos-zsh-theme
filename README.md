# Customized rkj-repos ZSH Theme

This project is a customized rkj-repos zsh-theme with enhanced Git and Mercurial integration features.

## Overview

This is a customized version of the popular rkj-repos Oh My Zsh theme with enhanced Git status functionality and comprehensive repository information display. The theme maintains the elegant two-line prompt format while adding advanced Git features including remote tracking status, stash indicators, and detailed working directory information. It also includes robust Mercurial support for mixed-VCS environments.

## Features

### Visual Elements
- **Two-line prompt layout** for better readability and easier vgrepping
- **Enhanced Git integration** with comprehensive status information:
  - Branch name display in green
  - Working directory status indicators with custom implementation
  - Remote tracking information (ahead/behind commits)
  - Stash count display
  - Commit SHA display in cyan
- **Mercurial (hg) support** with detailed repository information including:
  - Branch and bookmark information
  - Tags display
  - Status indicators for modified and unknown files
  - Patch queue information
- **Smart Git status indicators**:
  - ✓ Clean repository (green) - when everything is committed
  - ✗ Modified files (yellow) - for uncommitted changes
  - ✗ Deleted files (red) - for deleted files
  - + Added files (green) - for staged files
  - + Untracked files (red) - for new, untracked files
  - ➦ Renamed files (cyan)
  - ✂ Unmerged files (magenta)
- **Advanced Git status features**:
  - ↑ Commits ahead of remote (green)
  - ↓ Commits behind remote (red)
  - ↕ Diverged from remote (yellow)
  - ⚑ Stash count indicator (magenta)
- **Timestamp display** showing current date and time in 24-hour format: YYYY-MM-DD HH:MM:SS
- **Compact user information** displaying only username (no hostname)
- **Smart exit code display** with visual indicators:
  - Blue brackets for successful commands (exit code 0)
  - Bright red brackets for failed commands (exit code ≠ 0)
  - Exit code number always displayed in magenta

### Technical Features
- **Custom Git status implementation** independent of Oh My Zsh Git functions
- **Robust error handling** for Git operations with fallback mechanisms
- **Configurable Git status** respecting oh-my-zsh.hide-status setting
- **Custom clear screen functionality** with Ctrl+L binding that mimics Cmd+K behavior
- **Cross-platform compatibility** with enhanced clear screen handling
- **Unicode symbol support** for modern terminal compatibility
- **Performance optimized** Git status checking

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
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%}✗"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[cyan]%}➦"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[magenta]%}✂"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}+"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✓"
ZSH_THEME_GIT_PROMPT_SHA_BEFORE=" %{$fg_bold[cyan]%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$reset_color%}"
```

### Git Status Color Coding
The theme uses an intuitive color system:
- **Green** - Good/Clean states (✓ clean repo, + staged files)
- **Red** - Issues that need attention (+ untracked files, ✗ deleted files)
- **Yellow** - Changes in progress (✗ modified files)
- **Cyan** - Informational (➦ renamed files, commit SHA)
- **Magenta** - Special states (✂ unmerged files, ⚑ stashes)

### Advanced Git Status Indicators
- **↑** - Commits ahead of remote (green)
- **↓** - Commits behind remote (red) 
- **↕** - Diverged from remote (yellow)
- **⚑** - Stash count (magenta)

### Exit Code Display
- **Blue brackets** `[0]` - Successful command execution
- **Bright red brackets** `[error_code]` - Failed command execution
- Exit code number always in magenta for consistency

### Prompt Layout
The theme features a clean two-line prompt structure:
- **Top line**: Git/Hg repository info, current directory path, timestamp
- **Bottom line**: Username, exit code with color-coded brackets

### Time Format
The timestamp uses 24-hour format (HH:MM:SS) for precision and international compatibility.

### Keyboard Shortcuts
- **Ctrl+L**: Enhanced clear screen that mimics macOS Cmd+K behavior

### Disabling Git Status
To hide Git status information globally:
```bash
git config --global oh-my-zsh.hide-status 1
```

## Usage

Once installed, the theme will automatically:
- Display your current Git branch and status when in a Git repository
- Show enhanced Git information including:
  - Commits ahead/behind remote tracking branch
  - Stash count if stashes are present
  - Detailed working directory status
- Show Mercurial information when in an Hg repository with proper configuration
- Provide timestamp information on each prompt
- Display exit codes for failed commands

### Git Repository Information
When you're in a Git repository, the prompt displays:
- **Branch name** in green
- **Status indicators** for modified, added, deleted files
- **Remote tracking status** with ahead/behind commit counts
- **Stash indicator** if you have stashed changes
- **Commit SHA** (short form)

### Mercurial Repository Information
For Mercurial repositories (requires hgext.prompt extension):
- Branch and bookmark information
- Tags display
- Working directory status
- Patch queue information

## Troubleshooting

### Prompt Not Displaying Correctly
- Ensure Oh My Zsh is properly installed
- Verify the theme file is in the correct location (`~/.oh-my-zsh/custom/themes/`)
- Check that your terminal supports color output and Unicode characters

### Git Information Not Showing
- Verify you're in a Git repository
- Ensure Git is installed and accessible in your PATH
- Check that `git config --get oh-my-zsh.hide-status` is not set to "1"
- Verify that your Git repository has a valid remote configured for ahead/behind indicators

### Mercurial Information Not Showing
- Ensure Mercurial is installed and accessible
- Verify you have the `hgext.prompt` extension enabled in your `~/.hgrc`
- Check that you're in a valid Mercurial repository

### Performance Issues
- The enhanced Git status may be slower in very large repositories
- Consider disabling Git status globally if needed: `git config --global oh-my-zsh.hide-status 1`

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
- **Custom Git status implementation** - Independent of Oh My Zsh Git functions for better reliability
- **Smart status indicators** - Green ✓ for clean repositories, intuitive color coding
- **Enhanced exit code display** - Bright red brackets for errors, blue for success
- **24-hour time format** - More precise and internationally compatible timestamp
- **Compact user display** - Username only (no hostname) for cleaner prompt
- **Custom clear screen function** - Ctrl+L mimics macOS Cmd+K behavior with scrollback clearing
- **Improved Git status detection** - Comprehensive checking for all Git states
- **Better color scheme** - Intuitive color coding with green for good states, red for issues
- **Removed empty functions** - Cleaned up unnecessary `retcode()` function
- **Performance optimizations** - Efficient Git command execution with proper error handling

---

*For more information about Oh My Zsh themes, visit the [official documentation](https://github.com/ohmyzsh/ohmyzsh/wiki/Themes).*
