# Install Scripts
Automates installation of commonly used programs, including...

## Postgres (install_postgres.sh)
* Installs postgres and dependencies via apt-get
* Prompts to create password for postgres user 
* Prompts to create password for current user
* Installs pg gem 
* Configures postgres to trust local connections (assumes this is your dev environment)
