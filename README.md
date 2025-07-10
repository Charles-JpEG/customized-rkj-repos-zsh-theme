# Customized rkj-repos ZSH Theme

This project is a customized rkj-repos zsh-theme with enhanced Git and Mercurial integration features.

## Overview

This is a customized version of the popular rkj-repos Oh My Zsh theme with enhanced Git status functionality and comprehensive repository information display. The theme maintains the elegant two-line prompt format while adding advanced Git features including remote tracking status, stash indicators, and detailed working directory information. It also includes robust Mercurial support for mixed-VCS environments.

## Features

### Visual Elements
- **Two-line prompt layout** for better readability and easier vgrepping
- **Enhanced Git integration** with comprehensive status information:
  - Branch name display
  - Working directory status indicators
  - Remote tracking information (ahead/behind commits)
  - Stash count display
  - Commit SHA display
- **Mercurial (hg) support** with detailed repository information including:
  - Branch and bookmark information
  - Tags display
  - Status indicators for modified and unknown files
  - Patch queue information
- **Color-coded Git status indicators**:
  - ✱ Modified files (yellow)
  - ✗ Deleted files (red)
  - + Added files (green)
  - ➦ Renamed files (cyan)
  - ✂ Unmerged files (magenta)
  - ✈ Untracked files (blue)
- **Advanced Git status features**:
  - ↑ Commits ahead of remote (green)
  - ↓ Commits behind remote (red)
  - ↕ Diverged from remote (yellow)
  - ⚑ Stash count indicator (magenta)
- **Timestamp display** showing current date and time in format: YYYY-MM-DD HH:MM:SS
- **User and host information** with colorful styling
- **Exit code display** for the last command with color coding

### Technical Features
- **Enhanced Git function** with fallback to basic Git info for reliability
- **Robust error handling** for Git operations
- **Configurable Git status** respecting oh-my-zsh.hide-status setting
- **Optimized performance** with efficient Git command execution
- **Unicode symbol support** for modern terminal compatibility

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
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[cyan]%}➦"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[magenta]%}✂"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[blue]%}✈"
ZSH_THEME_GIT_PROMPT_SHA_BEFORE=" %{$fg_bold[cyan]%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$reset_color%}"
```

### Advanced Git Status Indicators
The theme includes enhanced Git status indicators:
- **↑** - Commits ahead of remote (green)
- **↓** - Commits behind remote (red) 
- **↕** - Diverged from remote (yellow)
- **⚑** - Stash count (magenta)

### Colors and Styling
The theme uses Oh My Zsh's color system. You can modify colors by changing the `$fg[color]` and `$fg_bold[color]` values throughout the theme file.

### Prompt Layout
The theme features a two-line prompt structure:
- **Top line**: Git/Hg info, current directory path, timestamp
- **Bottom line**: Username@hostname, exit code

### Disabling Git Status
To hide Git status information, set:
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
- Enhanced Git status function with comprehensive repository information
- Added remote tracking status (ahead/behind commits) with visual indicators
- Integrated stash count display with ⚑ symbol
- Improved error handling and fallback mechanisms for Git operations
- Added commit SHA display functionality
- Enhanced Mercurial support with detailed repository information
- Optimized performance for Git command execution
- Added respect for oh-my-zsh.hide-status configuration option

---

*For more information about Oh My Zsh themes, visit the [official documentation](https://github.com/ohmyzsh/ohmyzsh/wiki/Themes).*
