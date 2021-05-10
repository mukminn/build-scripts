function oops() {
    echo "$@" >&2
    exit 1
}

function normalizeBranchName {
    # normalizations
    # 1. change dots to underscores
    # 2. to lower case
    # 3. cut to maximum 80 characters
    echo $(basename "$1" | sed 's/\./_/g' | tr '[:upper:]' '[:lower:]' | cut -c -80)
}
