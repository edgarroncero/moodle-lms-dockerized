#!/bin/sh

set -e

VOLUMES_DIR="$(pwd)/volumes"

# Ensure a directory exists; chmod 777 only if created
ensure_dir() {
  path="$1"
  rel=$(basename "$path")  # simpler relative name for logging

  if [ ! -d "$path" ]; then
    mkdir -p "$path"
    chmod 777 "$path"
    echo "Created $rel and set permissions to 777"
  else
    echo "$rel already exists — leaving permissions unchanged"
  fi
}

# Create all necessary volume directories
create_dirs() {
  echo "Ensuring volume directories..."
  ensure_dir "$VOLUMES_DIR/mariadb"
  ensure_dir "$VOLUMES_DIR/moodle"
  ensure_dir "$VOLUMES_DIR/moodledata"
  ensure_dir "$VOLUMES_DIR/php-fpm"
  ensure_dir "$VOLUMES_DIR/nginx"
}

# Check for existing .env
if [ -f .env ]; then
  echo ".env file already exists — skipping env generation"
  create_dirs
  exit 0
fi

# Create .env from template and generate passwords
echo "Creating .env from env.template..."
cp env.template .env

# Generate short, safe hex passwords
MYSQL_PASSWORD="$(openssl rand -hex 16)"
MYSQL_ROOT_PASSWORD="$(openssl rand -hex 16)"

# Replace passwords in .env
sed -i.bak \
  -e "s|^MYSQL_PASSWORD=.*|MYSQL_PASSWORD=${MYSQL_PASSWORD}|" \
  -e "s|^MYSQL_ROOT_PASSWORD=.*|MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}|" \
  .env

rm .env.bak

echo ".env created and MySQL passwords generated!"

# Ensure volume directories exist (chmod only for newly created ones)
create_dirs

echo "Environment initialized!"

