# MusicAdminAPI

Private PHP/MySQL administration API for **MusicAPI-v2**.

This project is intentionally kept lightweight and follows the same deployment model as MusicAPI-v2:

- PHP 8.3 CLI Docker image
- No Composer dependencies
- No bundled `vendor/` directory
- MySQL/MariaDB through PHP `mysqli` / `pdo_mysql`
- Database credentials supplied through environment variables
- Works locally with WAMP/XAMPP and on Render using Docker
- Uses the existing MusicAPI-v2 database; it does not create a second music database

## Project structure

```text
MusicAdminAPI/
├── app/
│   ├── Controllers/
│   ├── Core/
│   ├── Helpers/
│   ├── Middleware/
│   └── Services/
├── config/
│   ├── config.php
│   └── secrets.php.example
├── routes/
│   └── api.php
├── .dockerignore
├── .env.example
├── .gitignore
├── .htaccess
├── Dockerfile
└── index.php
```

There is deliberately no `vendor/`, `composer.json`, `composer.lock`, duplicate database dump, or second public front-controller directory.

## Environment variables

The application reads values with `getenv()`, so Render Environment Variables work directly.

### Database

Use the **same variable names as MusicAPI-v2**:

```env
DB_HOST=your-db-host
DB_PORT=3306
DB_NAME=music_app_v2
DB_USER=your-db-user
DB_PASS=your-db-password
```

Changing these variables in Render changes the database used by the Admin API. No code change or rebuild of the PHP source is required.

### Admin authentication

```env
ADMIN_USERNAME=admin
ADMIN_PASSWORD_HASH=your-password-hash
ADMIN_TOKEN_SECRET=your-long-random-secret-at-least-32-characters
TOKEN_TTL=86400
```

Generate a password hash locally:

```bash
php -r "echo password_hash('YOUR_PASSWORD', PASSWORD_DEFAULT), PHP_EOL;"
```

For local-only testing, `ADMIN_PASSWORD` is also supported as a fallback, but `ADMIN_PASSWORD_HASH` should be used for deployment.

### Application

```env
APP_ENV=production
APP_URL=https://your-admin-api.onrender.com
CORS_ORIGIN=https://your-admin-panel.example.com
```

If the admin panel is only used locally, `CORS_ORIGIN=http://localhost` can be used.

## Local WAMP

Copy `.env.example` to `.env` and set your database/admin values.

Then:

```text
http://localhost/MusicAdminAPI/
```

or, if Apache rewrite is not being used:

```text
http://localhost/MusicAdminAPI/index.php
```

## Render deployment

Create a **Web Service** from this repository and use Docker.

The included Dockerfile starts:

```bash
php -S 0.0.0.0:${PORT:-10000} -t /var/www
```

Render supplies the `PORT` environment variable automatically.

### Render Environment Variables

Set:

```text
APP_ENV=production
APP_URL=https://YOUR-SERVICE.onrender.com

DB_HOST=...
DB_PORT=...
DB_NAME=...
DB_USER=...
DB_PASS=...

ADMIN_USERNAME=admin
ADMIN_PASSWORD_HASH=...
ADMIN_TOKEN_SECRET=...
TOKEN_TTL=86400

CORS_ORIGIN=...
```

Do **not** upload `.env` to GitHub. `.dockerignore` also excludes it from the Docker build context.

## API

Public:

```text
GET  /
GET  /health
POST /auth/login
```

Authenticated:

```text
GET    /dashboard

GET    /songs
POST   /songs
GET    /songs/{id}
PUT    /songs/{id}
PATCH  /songs/{id}
DELETE /songs/{id}

GET    /albums
POST   /albums
GET    /albums/{id}
PUT    /albums/{id}
PATCH  /albums/{id}
DELETE /albums/{id}
GET    /albums/{id}/tracks

GET    /artists
POST   /artists
GET    /artists/{id}
PUT    /artists/{id}
PATCH  /artists/{id}
DELETE /artists/{id}

GET    /genres
POST   /genres
GET    /genres/{id}
PUT    /genres/{id}
PATCH  /genres/{id}
DELETE /genres/{id}

GET    /languages
POST   /languages/rename
```

After login, send:

```http
Authorization: Bearer YOUR_TOKEN
```

## Database

The Admin API uses the same tables as MusicAPI-v2, including:

```text
songs
albums
artists
genres
song_artists
song_genres
song_albums
```

It does not maintain a separate music database or duplicate the MusicAPI-v2 schema.
