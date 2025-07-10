# user, host, full path, and time/date on two lines for easier vgrepping

function hg_prompt_info {
  if (( $+commands[hg] )) && [[ -e ~/.hgrc ]] && grep -q "prompt" ~/.hgrc; then
    hg prompt --angle-brackets "\
<hg:%{$fg[magenta]%}<branch>%{$reset_color%}><:%{$fg[magenta]%}<bookmark>%{$reset_color%}>\
</%{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>\
%{$fg[red]%}<status|modified|unknown><update>%{$reset_color%}<
patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>>" 2>/dev/null
  fi
}

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[green]%}+"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%}✱"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%}✗"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[cyan]%}➦"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[magenta]%}✂"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[blue]%}✈"
ZSH_THEME_GIT_PROMPT_SHA_BEFORE=" %{$fg_bold[cyan]%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$reset_color%}"

function mygit() {
  if [[ "$(git config --get oh-my-zsh.hide-status)" != "1" ]]; then
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
    echo "%{$fg_bold[cyan]%}git:(%{$fg_bold[green]%}${ref#refs/heads/}$(git_prompt_short_sha)$(git_prompt_status)%{$fg_bold[cyan]%})%{$reset_color%}"
  fi
}

function retcode() {}

# alternate prompt with git & hg
PROMPT=$'%{$fg_bold[blue]%}┌─[$(mygit)$(hg_prompt_info)%{$fg_bold[blue]%}] - %{$fg_bold[blue]%}[%{$fg_bold[default]%}%~%{$fg_bold[blue]%}]%{$reset_color%} - %{$fg_bold[blue]%}[%b%{$fg[yellow]%}'%D{"%Y-%m-%d %I:%M:%S"}%b$'%{$fg_bold[blue]%}]
%{$fg_bold[blue]%}└─[%{$fg_bold[green]%}%n%b%{$fg[black]%}@%{$fg[cyan]%}%m%{$fg_bold[blue]%}] - [%{$fg_bold[magenta]%}%?$(retcode)%{$fg_bold[blue]%}]%{$reset_color%} '
PS2=$' \e[0;34m%}%B>%{\e[0m%}%b '

# Function to detect platform and handle clear behavior
function preserve_prompt_clear() {
  case "$OSTYPE" in
    darwin*)
      # macOS - handle Cmd+K behavior
      alias clear='printf "\033[2J\033[3J\033[H" && zle && zle reset-prompt'
      ;;
    linux*)
      # Linux - standard behavior, but ensure prompt preservation
      alias clear='command clear && zle && zle reset-prompt 2>/dev/null || command clear'
      ;;
    cygwin*|msys*|win32*)
      # Windows (Cygwin/MSYS2/Git Bash)
      alias clear='command clear && zle && zle reset-prompt 2>/dev/null || command clear'
      ;;
    *)
      # Other Unix-like systems
      alias clear='command clear && zle && zle reset-prompt 2>/dev/null || command clear'
      ;;
  esac
}

# Function to redraw prompt after terminal clear
function precmd_preserve_prompt() {
  # This ensures prompt is redrawn properly after clear operations
  if [[ -n "$ZSH_THEME_TERM_TITLE_IDLE" ]]; then
    print -Pn "\e]0;$ZSH_THEME_TERM_TITLE_IDLE\a"
  fi
}

# Add the precmd hook
autoload -U add-zsh-hook
add-zsh-hook precmd precmd_preserve_prompt

# Initialize the clear alias for macOS
preserve_prompt_clear

# Custom widget to handle clear and redraw prompt (cross-platform)
function clear-screen-and-redraw() {
  # Use appropriate clear method based on platform
  case "$OSTYPE" in
    darwin*)
      # macOS - full clear including scrollback
      printf "\033[2J\033[3J\033[H"
      ;;
    *)
      # Linux, Windows, and other platforms
      printf "\033[2J\033[H"
      ;;
  esac
  
  # Redraw prompt if in ZLE context
  if [[ -n "$ZLE_STATE" ]]; then
    zle reset-prompt
    zle redisplay
  fi
}

# Create the custom widget
zle -N clear-screen-and-redraw

# Bind it to Ctrl+L for consistent behavior across platforms
bindkey '^L' clear-screen-and-redraw

# Platform-specific enhancements
case "$OSTYPE" in
  darwin*)
    # macOS-specific: Handle Cmd+K behavior
    function cmd-k-clear() {
      clear-screen-and-redraw
    }
    # Optional: bind Ctrl+K as alternative for Cmd+K behavior
    # bindkey '^K' clear-screen-and-redraw
    ;;
  linux*)
    # Linux-specific optimizations
    function linux-clear() {
      clear-screen-and-redraw
    }
    ;;
  cygwin*|msys*|win32*)
    # Windows (Git Bash, WSL, etc.) specific
    function win-clear() {
      clear-screen-and-redraw
    }
    # In some Windows terminals, Ctrl+L might need different handling
    bindkey '^L' clear-screen-and-redraw
    ;;
esac
