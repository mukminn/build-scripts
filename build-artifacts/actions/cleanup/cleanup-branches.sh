BUILDS_DIR=$1
[ -d "$BUILDS_DIR"/branches ] && [ -d "$BUILDS_DIR"/revs ] || oops "Invalild builds directory: $BUILDS_DIR"
REPO=$2
[ ! -z "$REPO" ] || oops "Repository is missing"

echo "Cleaning builds branches: $BUILDS_DIR..."

# list all branches
tmpfile=$(mktemp /tmp/cleanup-builds.XXXXXX)
{
    git ls-remote --quiet --heads $REPO | awk '{print $2}' | while read i;do
        b=$(normalizeBranchName $i)
        echo $b
    done
} > $tmpfile

# sanity check the branch list file
[ $(cat $tmpfile | wc -l) -gt 0 ] || oops "Sanity check failed: zero remote branch found."
grep -q master $tmpfile || oops "Sanity check failed: master branch not found."

# delete stray branches
mkdir -p $BUILDS_DIR/archives
ls $BUILDS_DIR/branches | while read i;do
    if ! grep --quiet --line-regexp $i $tmpfile;then
        echo "Deleting branch $i..."
        mv $BUILDS_DIR/branches/$i $BUILDS_DIR/archives/
    fi
done

# cleanup
rm -f $tmpfile

echo "Done."
