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
  
  echo "%{$fg_bold[cyan]%}git:(%{$fg_bold[green]%}${branch_name}$(git_prompt_short_sha)$(git_prompt_status)%{$fg_bold[cyan]%})${ahead_behind}${stash_info}%{$reset_color%}"
}

# Use the enhanced git function, but keep the original as fallback
function mygit() {
  git_prompt_info_enhanced 2>/dev/null || {
    if [[ "$(git config --get oh-my-zsh.hide-status)" != "1" ]]; then
      ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
      ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
      echo "%{$fg_bold[cyan]%}git:(%{$fg_bold[green]%}${ref#refs/heads/}$(git_prompt_short_sha)$(git_prompt_status)%{$fg_bold[cyan]%})%{$reset_color%}"
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
%{$fg_bold[blue]%}└─[%{$fg_bold[green]%}%n%{$fg_bold[blue]%}] - [%{$fg_bold[magenta]%}%?%{$fg_bold[blue]%}]%{$reset_color%} '
PS2=$' \e[0;34m%}%B>%{\e[0m%}%b '
