function normalizeBranchName {
    # take the base name and change dots to underscores
    echo $(basename "$1" | sed 's/\./_/g' | tr '[:upper:]' '[:lower:]')
}
