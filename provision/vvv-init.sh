#!/usr/bin/env bash
# Provision WordPress Stable

DOMAIN=`get_primary_host "${VVV_SITE_NAME}".test`
DOMAINS=`get_hosts "${DOMAIN}"`
SITE_TITLE=`get_config_value 'site_title' "${DOMAIN}"`
WP_VERSION=`get_config_value 'wp_version' 'latest'`
WP_TYPE=`get_config_value 'wp_type' "single"`
DB_NAME=`get_config_value 'db_name' "${VVV_SITE_NAME}"`
DB_NAME=${DB_NAME//[\\\/\.\<\>\:\"\'\|\?\!\*-]/}

FRODO_URL="https://github.com/wherebyus/frodo.git"
NEWS_NAME="wbu-newsletters"
NEWS_URL="https://github.com/wherebyus/wbu-newsletters.git"
REFER_NAME="wbu-referrals"
REFER_URL="https://github.com/wherebyus/wbu-referrals.git"


# Make a database, if we don't already have one
echo -e "\nCreating database '${DB_NAME}' (if it's not already there)"
mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME}"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO wp@localhost IDENTIFIED BY 'wp';"
echo -e "\n DB operations done.\n\n"

# Nginx Logs
mkdir -p ${VVV_PATH_TO_SITE}/log
touch ${VVV_PATH_TO_SITE}/log/error.log
touch ${VVV_PATH_TO_SITE}/log/access.log

# Install and configure the latest stable version of WordPress
if [[ ! -f "${VVV_PATH_TO_SITE}/public_html/wp-load.php" ]]; then
  echo "Downloading WordPress..."
  noroot wp core download --version="${WP_VERSION}"
fi

if [[ ! -f "${VVV_PATH_TO_SITE}/public_html/wp-config.php" ]]; then
  echo "Configuring WordPress Stable..."
  noroot wp core config --dbname="${DB_NAME}" --dbuser=wp --dbpass=wp --quiet --extra-php <<PHP
define( 'WP_DEBUG', true );
PHP
fi

if ! $(noroot wp core is-installed); then
  echo "Installing WordPress Stable..."

  if [ "${WP_TYPE}" = "subdomain" ]; then
    INSTALL_COMMAND="multisite-install --subdomains"
  elif [ "${WP_TYPE}" = "subdirectory" ]; then
    INSTALL_COMMAND="multisite-install"
  else
    INSTALL_COMMAND="install"
  fi

  noroot wp core ${INSTALL_COMMAND} --url="${DOMAIN}" --quiet --title="${SITE_TITLE}" --admin_name=admin --admin_email="admin@local.test" --admin_password="password"
else
  echo "Updating WordPress Stable..."
  cd ${VVV_PATH_TO_SITE}/public_html
  noroot wp core update --version="${WP_VERSION}"
fi

cd ${VVV_PATH_TO_SITE}
# go to public_html, it must exist
if [ ! -d public_html ]
then
  echo "Didn't find a public_html directory, so I'm exiting early."
  exit 1
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
  if [[ 0 != $? ]]; then
    echo -e "Failed to clone the Newsletters repository."
  else
    cd ${NEWS_NAME}
    git init
    git remote add origin ${NEWS_URL}
    git fetch
    git reset origin/master
    git checkout -- .
    npm install
    composer install
  fi

  cd ${VVV_PATH_TO_SITE}
  cd public_html/wp-content/plugins
  git clone ${REFER_URL}
  if [[ 0 != $? ]]; then
    echo -e "Failed to clone the Referrals repository."
  else
    cd ${REFER_NAME}
    git init
    git remote add origin ${REFER_URL}
    git fetch
    git reset origin/master
    git checkout -- .
    npm install
    composer install
  fi
fi

# TO DO - check for presence of .sql,
# replace live strings with dev strings, and then import
# into vagrant. We get the .sql from my.wpengine.com
# /installs/SITE-NAME/backup_points#production ->
# partial backup -> Entire database.
