VENV=$(basename `dirname "$(readlink -f "$BASH_SOURCE")"`)
VENVPATH=${HOME}/.virtualenvs/${VENV}
source ${VENVPATH}/bin/activate
