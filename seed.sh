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
	cd wp-content; npm install
fi

# TO DO - check for presence of .sql,
# refine if necessary and then import
# into vagrant

# TO DO - new WP Engine script looks promising:
# https://github.com/cftp/vvv-init/blob/master/build-wpengine.sh