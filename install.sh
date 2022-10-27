#!/usr/bin/env bash
# ############################################################################
## The script is using to install {ENV_NAME} environment
##
## It does:
## * pull the latest {REPO_NAME} source code form the git repository
## * use ~/.local/src/{REPO_NAME} as a main directory for this environment
## * execute "~/.local/src/{REPO_NAME}/{ENV_NAME}/{ENV_NAME} install" command
##
## Repository: {REPO_URL_HTTP}
##
# ############################################################################
if [[ -z "${BASH_VERSION:-}" ]]; then echo "Error: Bash is required." >&2; exit 1; fi

# --[ Project specific constants ]--------------------------------------------
VERSION=1.0.0
ENV_NAME=myenv
REPO_NAME="${ENV_NAME}"
REPO_URL_SSH="git@github.com:revgen/${REPO_NAME}.git"
REPO_URL_HTTP="https://github.com/revgen/${REPO_NAME}"
REPO_BRANCH="${REPO_BRANCH:-"${BRANCH:-"master"}"}"
TITLE="The script will install ${ENV_NAME} environment"
USE_HTTP="${USE_HTTP:-"true"}"
NONINTERACTIVE="${NONINTERACTIVE:-"false"}"
ENV_HOME="${HOME}/.local/src/${REPO_NAME}"

# --[ Variables and functions ]-----------------------------------------------
set -Euo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT
OLD_PWD="$(pwd)"

# Settings for color output
if [[ -t 1 ]] && [[ -n "$(tput colors || true)" ]] && [[ -z "${NO_COLOR-}" ]]; then
    NOFORMAT='\033[0m' INFO='\033[0;32m' ERROR='\033[0;31m';
else NOFORMAT='' INFO=''  ERROR=''; fi
# ----------------------------------------------------------------------------
usage() {
  head -n 30 "${0}" \
  | sed -n '/^##/,/^$/s/^## \{0,1\}//p' | sed 's/{SCRIPT_NAME}/'"${ENV_NAME}"'/g' \
  | sed 's/{ENV_NAME}/'"${ENV_NAME}"'/g' | sed 's/{REPO_NAME}/'"${REPO_NAME}"'/g' \
  | sed 's/{REPO_BRANCH}/'"${REPO_BRANCH}"'/g'
  # | sed 's/{REPO_URL_SSH}/'"${REPO_URL_SSH}"'/g' | sed 's/{REPO_URL_HTTP}/'"${REPO_URL_HTTP}"'/g' \
  # | sed 's/{ENV_HOME}/'"${ENV_HOME}"'/g' | 
  exit 1
}
cleanup() { cd "${OLD_PWD:-"${PWD}"}" >/dev/null || true; }
debug() { echo >&2 -e "$*"; }
info() { echo >&2 -e "${INFO}$*${NOFORMAT}"; }
error() { echo >&2 -e "${ERROR}$*${NOFORMAT}"; }
prompt_ny() {
  if [[ "${NONINTERACTIVE}" == "true" ]]; then debug "Noninteractive mode."; return 1; fi
  read -r -p "${1} " opt
  if [[ "${opt:-"n"}" == "y" ]] || [[ "${opt}" == "Y" ]]; then return 1; fi
  return 0
}
version() { echo -e "${INFO}${REPO_NAME} v${VERSION}${NOFORMAT} (ENV_HOME=${ENV_HOME})"; exit 0; }

# ----------------------------------------------------------------------------
install_local() {
  if [[ "${USE_HTTP:-"false"}" == "true" ]]; then repo_url=${REPO_URL_HTTP};
  else repo_url=${REPO_URL_SSH}; fi

  info "${TITLE}."
  case "${OSTYPE}" in
    linux*) info "* System    : $(grep PRETTY_NAME /etc/os-release | sed 's/"//g' | sed 's/PRETTY_NAME=//g')" ;;
    darwin*|macos*) info "* System    : $(sw_vers -productName) $(sw_vers -productVersion)" ;;
    *) error "Unsupported system"; exit 1 ;;
  esac
  info "* Name      : ${ENV_NAME}"
  info "* Repository: ${repo_url}"
  info "* Branch    : ${REPO_BRANCH}"
  info "* Target    : ${ENV_HOME}"

  if prompt_ny "Do you want to continiue (y/N)? "; then info "Skip"; exit 1; fi

  debug "Creating ${ENV_HOME} if not exists"
  mkdir -p "${ENV_HOME}" > /dev/null
  if [[ ! -d "${ENV_HOME}/.git" ]]; then
    info "Git clone ${repo_url}"
    git clone "${repo_url}" "${ENV_HOME}" || exit 1
  fi

  cd "${ENV_HOME}" || exit 1
  info "Switch to the $(pwd || true) directory"
  if git status -s | grep -qv "^$"; then
    error "You have changes in the repository '${PWD}'"
    git status -s | head -n 10
    if prompt_ny "Are you sure you are ready to overwride all changes (y/N)?"; then info "Skip"; exit 1; fi
  fi
  debug "Checkout ${REPO_BRANCH} branch"
  git checkout "${REPO_BRANCH}" || exit 1
  debug "Update local repo"
  git remote prune origin || exit 1
  git fetch || exit 1
  debug "Reset to the remote origin/${REPO_BRANCH}"
  git reset --hard "origin/${REPO_BRANCH}" || exit 1
  info "Update '${ENV_NAME}' environment complete in the '${ENV_HOME}' directory"

  install_script="${PWD}/${ENV_NAME}"
  info "Execute ${install_script}..."
  if [[ -f "${install_script}" ]]; then
    bash "${install_script}" install-local || exit 1
    info "Environment '${ENV_NAME}' installation complete."
    info "Now you need to restart current terminal session. You can close and reopen terminal again."
  else
    error "The script ${install_script} not found. Skip local setup."
    exit 1
  fi
}
# ----------------------------------------------------------------------------
for arg in "$*"; do
  case "${arg:-""}" in
    help|--help|-h) usage; exit 1 ;;
    version|--version) version; exit 0 ;;
    --silent|--noninteractive) NONINTERACTIVE=true ;;
  esac
done

if [[ "${NONINTERACTIVE}" == "true" ]]; then
  yes | install_local
else
  install_local
fi
