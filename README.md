# MusicAdminAPI

Private PHP/MySQL administration API for MusicAPI-v2.

## What was fixed

- Removed the accidentally bundled `.env` credentials from the distributable project.
- Added `.env.example`.
- Unified authentication around one JWT-style HMAC token implementation.
- Added proper CORS handling.
- Added `PATCH` support.
- Improved routing and 404/405 responses.
- Fixed CRUD validation so nullable fields are not incorrectly required.
- Improved soft-delete handling.
- Improved slug generation and duplicate handling.
- Added safer production error responses.
- Added transaction handling around song relationship updates.
- Fixed album track-count refresh when song albums change.
- Added genre relationship cleanup.
- Added pagination/search consistently.
- Kept the existing MusicAPI-v2 database schema; no public API changes are required.

## URL

Both styles work with Apache rewrite rules:

```text
http://localhost/MusicAdminAPI/public/songs
http://localhost/MusicAdminAPI/songs
```

For a production server, preferably point the virtual host/document root directly at `public/`.

## Setup

1. Copy `.env.example` to `.env`.
2. Put the same database credentials used by MusicAPI-v2 in `.env`.
3. Generate an admin password hash:

```bash
php -r "echo password_hash('YOUR_PASSWORD', PASSWORD_DEFAULT), PHP_EOL;"
```

4. Put the generated value in `ADMIN_PASSWORD_HASH`.
5. Set a long random `ADMIN_TOKEN_SECRET`.
6. Do not commit `.env`.

## Authentication

Login:

```http
POST /auth/login
Content-Type: application/json

{
  "username": "admin",
  "password": "YOUR_PASSWORD"
}
```

Use the returned token:

```http
Authorization: Bearer YOUR_TOKEN
```

All endpoints except `/auth/login` require authentication.

## Main endpoints

### Dashboard

```text
GET /dashboard
```

### Songs

```text
GET    /songs?page=1&limit=25&search=kesariya
POST   /songs
GET    /songs/{id}
PUT    /songs/{id}
PATCH  /songs/{id}
DELETE /songs/{id}
```

Example create body:

```json
{
  "title": "Kesariya",
  "audio_url": "https://example.com/song.mp3",
  "cover_url": "https://example.com/cover.jpg",
  "duration_seconds": 268,
  "language": "Hindi",
  "is_explicit": false,
  "is_active": true,
  "artists": [
    { "id": 1, "role": "Main" }
  ],
  "genres": [16, 46],
  "albums": [
    { "id": 1, "track_number": 6, "disc_number": 1 }
  ]
}
```

Relationship arrays are optional. If a relationship array is supplied during update, it replaces the existing relationship set for that type.

### Albums

```text
GET    /albums?page=1&limit=25&search=dhurandhar
POST   /albums
GET    /albums/{id}
PUT    /albums/{id}
PATCH  /albums/{id}
DELETE /albums/{id}
GET    /albums/{id}/tracks
```

### Artists

```text
GET    /artists?page=1&limit=25&search=arijit
POST   /artists
GET    /artists/{id}
PUT    /artists/{id}
PATCH  /artists/{id}
DELETE /artists/{id}
```

### Genres

```text
GET    /genres?page=1&limit=25&search=rock
POST   /genres
GET    /genres/{id}
PUT    /genres/{id}
PATCH  /genres/{id}
DELETE /genres/{id}
```

### Languages

Languages remain derived from `songs.language`, so there is no second language table.

```text
GET  /languages
POST /languages/rename
```

Rename body:

```json
{
  "from": "Hindi",
  "to": "Hindi / Bollywood"
}
```

## Response format

Success:

```json
{
  "success": true,
  "message": "Success",
  "data": {}
}
```

Error:

```json
{
  "success": false,
  "message": "Unauthorized."
}
```

## Deployment

For Apache, use `public/` as the document root where possible.

For local XAMPP/WAMP-style hosting, the included root `.htaccess` also allows:

```text
/MusicAdminAPI/public/...
/MusicAdminAPI/...
```

Never deploy the real `.env` file inside a public repository.


## Local URL forms

Both of these forms are supported:
- `http://localhost/MusicAdminAPI/`
- `http://localhost/MusicAdminAPI/public/`

Use a fresh login token after changing `ADMIN_TOKEN_SECRET` or replacing the API files.
