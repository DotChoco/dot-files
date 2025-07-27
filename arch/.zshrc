# Colores RGB (formato ANSI de 24 bits)
CWD_COLOR="%F{#e5c07b}"
TIME_COLOR="%F{#98c371}"
GIT_COLOR="%F{#cc6f82}"
RESET_COLOR="%f"

# Símbolos unicode
ARROW="❯"
GIT_SYMBOL=""  # Requiere Nerd Fonts. Si no los tienes, puedes usar "G:"

# Función para obtener el nombre del directorio actual
function prompt_cwd_leaf() {
  local cwd="${PWD/#$HOME/~}"
  echo "${cwd##*/}"
}

# Función para obtener la rama git si aplica
function prompt_git_branch() {
  if command -v git &> /dev/null; then
    local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [[ -n "$branch" ]]; then
      echo " $GIT_COLOR$GIT_SYMBOL $branch$RESET_COLOR"
    fi
  fi
}

# Definir el prompt
function build_prompt() {
  local leaf=$(prompt_cwd_leaf)
  local time=$(date +"%H:%M")
  local git_branch=$(prompt_git_branch)
  PROMPT="${CWD_COLOR}${leaf}${TIME_COLOR} at ${time}${RESET_COLOR}${git_branch} ${TIME_COLOR}${ARROW}${RESET_COLOR} "
}

# Hook para actualizar el prompt dinámicamente
autoload -Uz add-zsh-hook
add-zsh-hook precmd build_prompt
