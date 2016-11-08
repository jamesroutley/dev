DEV_HOME="${DEV_ENVS_HOME:-$HOME/.devfiles}"


function _dev_usage() {
  echo "Usage: dev [-h] [-v] environment"
  echo ""
  if [ "$1" = "long" ]; then
    echo "Positional arguments:"
    echo "  environment   The environment to set up. The environment <env>"
    echo "                should have a corresponding file located at"
    echo "                $DEV_HOME/<env>".
    echo ""
    echo "Optional arguments:"
    echo "  -h            Help. Display this message and quit."
    echo "  -v            Version. Print version number and quit."
  fi
}


function dev() {
  local _env _envs _environment_path _is_environment_invalid
  local _environment_i _environment_j
  local _version=0.1.0

  # Parse arguments
  local optspec=":hv"
  while getopts "$optspec" optchar; do
    case "${optchar}" in
      h)
        _dev_usage long
        return 0
        ;;
      v)
        echo "dev v$_version"
        return 0
        ;;
      *)
        _dev_usage
        echo "Error. Invalid option: -${OPTARG}."
        return 1
        ;;
    esac
  done
  shift $(($OPTIND - 1))
  if [ -z "$1" ]; then
    _dev_usage long
    echo "Error. No environment supplied."
    return 1
  fi
  if ! [ -z "$2" ]; then
    _dev_usage long
    echo "Error. More than one argument supplied."
    return 1
  fi
  _env="$1"

  # Get environments
  _envs=();
  for _environment_path in $DEV_HOME/*; do
    _envs=(${_envs[@]} ${_environment_path##*/})
  done

  # Check environment is valid
  _is_environment_invalid=true
  for _environment_i in "${_envs[@]}"; do
    if [[ $_environment_i == "$_env" ]]; then
      _is_environment_invalid=false
      break
    fi
  done
  if $_is_environment_invalid; then
    echo "Error. Environment" \'$_env\' "not found. Please choose from:"
    for _environment_j in "${_envs[@]}"; do
      echo "  -" $_environment_j
    done
    return 1
  fi

  source $DEV_HOME/$_env
}
