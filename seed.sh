FRODO_URL="https://github.com/wherebyus/frodo.git"
NEWS_NAME="wbu-newsletters"
NEWS_URL="https://github.com/wherebyus/wbu-newsletters.git"
REFER_NAME="wbu-referrals"
REFER_URL="https://github.com/wherebyus/wbu-referrals.git"

cd ${VVV_PATH_TO_SITE}
# go to public_html, it must exist
if [ ! -d public_html ]
then
	echo "Not in the web directory"
else
	echo "Attempting to populate content"
	cd public_html
	git init
	git remote add origin ${FRODO_URL}
	git fetch
	git reset origin/master
	git checkout -- .
	npm install
	composer install

	cd ${VVV_PATH_TO_SITE}
	cd public_html/wp-content/plugins
	git clone ${NEWS_URL}
	cd ${NEWS_NAME}
	git init
	git remote add origin ${NEWS_URL}
	git fetch
	git reset origin/master
	git checkout -- .
	npm install
	composer install	

	cd ${VVV_PATH_TO_SITE}
	cd public_html/wp-content/plugins
	git clone ${REFER_URL}
	cd ${REFER_NAME}
	git init
	git remote add origin ${REFER_URL}
	git fetch
	git reset origin/master
	git checkout -- .
	npm install
	composer install
fi

# TO DO - check for presence of .sql,
# replace live strings with dev strings, and then import
# into vagrant. We get the .sql from my.wpengine.com
# /installs/SITE-NAME/backup_points#production -> 
# partial backup -> Entire database.