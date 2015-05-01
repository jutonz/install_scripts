sudo apt-get update
sudo apt-get install postgresql postgresql-contrib libpq-dev

echo "Setting password for user postgres"
echo "\password postgres; \q" | sudo -u postgres psql

PG_USER="$(whoami)"
echo "Setting password for pg user ${PG_USER}"
echo "create user ${PG_USER}; \password ${PG_USER}; \q" | sudo -u postgres psql

echo "Installing gem pg. This might take a second..."
gem install pg

echo "Configuring postgres to trust local connections..."
PG_VERSION="$(psql --version | grep -oh ".\..")"
PG_DIR="/etc/postgresql/${PG_VERSION}/main"
PG_HBA_BACKUP="pg_hba.conf.backup$(date '+%s')"
echo "Backing up pg_hba.conf to ${PG_HBA_BACKUP}"
sudo mv "${PG_DIR}/pg_hba.conf" "${PG_DIR}/${PG_HBA_BACKUP}"
sudo cp "./pgdata/pg_hba.conf" "${PG_DIR}/"

echo -e "\nInstall complete! To create a database for your app, type the following commands:"
echo -e "\tsudo su postgres"
echo -e "\tcreate role myapp with createdb login password 'password'"
