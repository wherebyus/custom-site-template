REPO_URL="https://github.com/wherebyus/son-of-frodo.git"

# go to public_html, it must exist
if [ ! -d public_html ]
then
	echo "Not in the web directory"
else
	echo "Attempting to populate content"
	cd public_html
	git init
	git remote add origin $REPO_URL
	git fetch
	git reset origin/master
	git checkout -- .
fi
