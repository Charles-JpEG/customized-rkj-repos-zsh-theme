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
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%}✗"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[cyan]%}➦"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[magenta]%}✂"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}+"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✓"
ZSH_THEME_GIT_PROMPT_SHA_BEFORE=" %{$fg_bold[cyan]%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$reset_color%}"

# Enhanced git status function with more information
function git_prompt_info_enhanced() {
  local ref
  if [[ "$(git config --get oh-my-zsh.hide-status)" == "1" ]]; then
    return
  fi
  
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  
  local branch_name="${ref#refs/heads/}"
  local git_status=""
  local ahead_behind=""
  
  # Get Git status with custom implementation
  local status_output
  status_output=$(git status --porcelain 2>/dev/null)
  
  if [[ -n "$status_output" ]]; then
    # Check for different types of changes
    echo "$status_output" | grep -q "^M " && git_status+="${ZSH_THEME_GIT_PROMPT_MODIFIED}"
    echo "$status_output" | grep -q "^A " && git_status+="${ZSH_THEME_GIT_PROMPT_ADDED}"
    echo "$status_output" | grep -q "^D " && git_status+="${ZSH_THEME_GIT_PROMPT_DELETED}"
    echo "$status_output" | grep -q "^R " && git_status+="${ZSH_THEME_GIT_PROMPT_RENAMED}"
    echo "$status_output" | grep -q "^??" && git_status+="${ZSH_THEME_GIT_PROMPT_UNTRACKED}"
    echo "$status_output" | grep -q "^UU\|^AA\|^DD" && git_status+="${ZSH_THEME_GIT_PROMPT_UNMERGED}"
    # Check for modified files in working directory
    echo "$status_output" | grep -q "^ M\|^ D\|^ A" && git_status+="${ZSH_THEME_GIT_PROMPT_MODIFIED}"
  else
    # Repository is clean, show green tick
    git_status="${ZSH_THEME_GIT_PROMPT_CLEAN}"
  fi
  
  # Check if we're ahead/behind remote
  local upstream=$(git rev-parse --abbrev-ref @{upstream} 2>/dev/null)
  if [[ -n "$upstream" ]]; then
    local ahead=$(git rev-list --count HEAD..@{upstream} 2>/dev/null)
    local behind=$(git rev-list --count @{upstream}..HEAD 2>/dev/null)
    
    if [[ "$ahead" -gt 0 ]] && [[ "$behind" -gt 0 ]]; then
      ahead_behind=" %{$fg_bold[yellow]%}↕$behind↑$ahead↓%{$reset_color%}"
    elif [[ "$ahead" -gt 0 ]]; then
      ahead_behind=" %{$fg_bold[red]%}↓$ahead%{$reset_color%}"
    elif [[ "$behind" -gt 0 ]]; then
      ahead_behind=" %{$fg_bold[green]%}↑$behind%{$reset_color%}"
    fi
  fi
  
  # Check for stashes
  local stash_count=$(git stash list 2>/dev/null | wc -l | tr -d ' ')
  local stash_info=""
  if [[ "$stash_count" -gt 0 ]]; then
    stash_info=" %{$fg_bold[magenta]%}⚑$stash_count%{$reset_color%}"
  fi
  
  # Get short SHA
  local short_sha=$(git rev-parse --short HEAD 2>/dev/null)
  local sha_display=""
  if [[ -n "$short_sha" ]]; then
    sha_display="${ZSH_THEME_GIT_PROMPT_SHA_BEFORE}${short_sha}${ZSH_THEME_GIT_PROMPT_SHA_AFTER}"
  fi
  
  echo "%{$fg_bold[cyan]%}git:(%{$fg_bold[green]%}${branch_name}${sha_display}${git_status}%{$fg_bold[cyan]%})${ahead_behind}${stash_info}%{$reset_color%}"
}

# Use the enhanced git function, but keep the original as fallback
function mygit() {
  git_prompt_info_enhanced 2>/dev/null || {
    if [[ "$(git config --get oh-my-zsh.hide-status)" != "1" ]]; then
      ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
      ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
      
      # Simple fallback with basic status
      local branch_name="${ref#refs/heads/}"
      local short_sha=$(git rev-parse --short HEAD 2>/dev/null)
      local status_output=$(git status --porcelain 2>/dev/null)
      local git_status=""
      
      if [[ -n "$status_output" ]]; then
        git_status="${ZSH_THEME_GIT_PROMPT_MODIFIED}"
      else
        git_status="${ZSH_THEME_GIT_PROMPT_CLEAN}"
      fi
      
      echo "%{$fg_bold[cyan]%}git:(%{$fg_bold[green]%}${branch_name} ${short_sha}${git_status}%{$fg_bold[cyan]%})%{$reset_color%}"
    fi
  }
}

# Custom clear function that mimics Cmd+K behavior
function custom_clear_screen() {
  # Clear the screen and scrollback buffer (like Cmd+K on macOS)
  if [[ "$OSTYPE" == darwin* ]]; then
    # On macOS, use the native clear with scrollback
    printf '\e[3J\e[H\e[2J'
  else
    # On other systems, clear screen and move cursor to top
    printf '\e[3J\e[H\e[2J'
  fi
  
  # Reset the prompt
  zle reset-prompt
}

# Create a ZLE widget for the custom clear function
zle -N custom_clear_screen

# Bind Ctrl+L to the custom clear function
bindkey '^L' custom_clear_screen

# alternate prompt with git & hg
PROMPT=$'%{$fg_bold[blue]%}┌─[$(mygit)$(hg_prompt_info)%{$fg_bold[blue]%}] - %{$fg_bold[blue]%}[%{$fg_bold[default]%}%~%{$fg_bold[blue]%}]%{$reset_color%} - %{$fg_bold[blue]%}[%b%{$fg[yellow]%}'%D{"%Y-%m-%d %H:%M:%S"}%b$'%{$fg_bold[blue]%}]
%{$fg_bold[blue]%}└─[%{$fg_bold[green]%}%n%{$fg_bold[blue]%}] - %(?:%{$fg_bold[blue]%}:%{$fg_bold[red]%})[%{$fg_bold[magenta]%}%?%(?:%{$fg_bold[blue]%}:%{$fg_bold[red]%})]%{$reset_color%} '
PS2=$' \e[0;34m%}%B>%{\e[0m%}%b '
