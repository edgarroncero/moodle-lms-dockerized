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
  ensure_dir "$VOLUMES_DIR/db"
  ensure_dir "$VOLUMES_DIR/moodle"
  ensure_dir "$VOLUMES_DIR/moodledata"
}

# Check for existing .env
if [ -f .env ]; then
  echo ".env file already exists — skipping env generation"
  create_dirs
  exit 0
fi

# Check if openssl is available
if ! command -v openssl >/dev/null 2>&1; then
  echo "ERROR: openssl is not installed or not in PATH"
  echo "Please install openssl:"
  echo "  - Ubuntu/Debian: sudo apt-get install openssl"
  echo "  - CentOS/RHEL: sudo yum install openssl"
  echo "  - macOS: brew install openssl"
  echo "  - Alpine: apk add openssl"
  exit 1
fi

# Create .env from .env.template and generate passwords
echo "Creating .env from .env.template..."
cp .env.template .env

# Generate short, safe hex passwords
MYSQL_PASSWORD="$(openssl rand -hex 16 2>/dev/null)" || {
  echo "ERROR: Failed to generate MYSQL_PASSWORD"
  exit 1
}

MYSQL_ROOT_PASSWORD="$(openssl rand -hex 16 2>/dev/null)" || {
  echo "ERROR: Failed to generate MYSQL_ROOT_PASSWORD"
  exit 1
}

# Verify passwords were generated (non-empty)
if [ -z "$MYSQL_PASSWORD" ] || [ -z "$MYSQL_ROOT_PASSWORD" ]; then
  echo "ERROR: Failed to generate valid passwords"
  exit 1
fi

# Replace passwords in .env
sed -i.bak \
  -e "s|^MYSQL_PASSWORD=.*|MYSQL_PASSWORD=${MYSQL_PASSWORD}|" \
  -e "s|^MYSQL_ROOT_PASSWORD=.*|MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}|" \
  -e "s|^MOODLE_DB_PASS=.*|MOODLE_DB_PASS=${MYSQL_PASSWORD}|" \
  .env

rm .env.bak

echo ".env created and MySQL passwords generated!"
echo "  - MYSQL_PASSWORD and MOODLE_DB_PASS are now in sync"

# Ensure volume directories exist (chmod only for newly created ones)
create_dirs

echo "Environment initialized!"
