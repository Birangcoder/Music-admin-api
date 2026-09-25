-- Optional performance migration for MusicAdminAPI.
-- Safe: each index is created only when it does not already exist.
-- Run once against the SAME database used by MusicAPI-v2.

DELIMITER $$

CREATE PROCEDURE add_index_if_missing(
    IN p_table VARCHAR(64),
    IN p_index VARCHAR(64),
    IN p_sql TEXT
)
BEGIN
    DECLARE n INT DEFAULT 0;
    SELECT COUNT(*) INTO n
      FROM information_schema.statistics
     WHERE table_schema = DATABASE()
       AND table_name = p_table
       AND index_name = p_index;

    IF n = 0 THEN
        SET @sql = p_sql;
        PREPARE stmt FROM @sql;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END IF;
END$$

CALL add_index_if_missing('songs','idx_songs_deleted_id',
    'ALTER TABLE songs ADD INDEX idx_songs_deleted_id (deleted_at, id)');
CALL add_index_if_missing('songs','idx_songs_language',
    'ALTER TABLE songs ADD INDEX idx_songs_language (language)');
CALL add_index_if_missing('songs','idx_songs_active',
    'ALTER TABLE songs ADD INDEX idx_songs_active (is_active, deleted_at)');

CALL add_index_if_missing('albums','idx_albums_deleted_id',
    'ALTER TABLE albums ADD INDEX idx_albums_deleted_id (deleted_at, id)');
CALL add_index_if_missing('albums','idx_albums_title',
    'ALTER TABLE albums ADD INDEX idx_albums_title (title)');

CALL add_index_if_missing('artists','idx_artists_deleted_id',
    'ALTER TABLE artists ADD INDEX idx_artists_deleted_id (deleted_at, id)');
CALL add_index_if_missing('artists','idx_artists_name',
    'ALTER TABLE artists ADD INDEX idx_artists_name (name)');

CALL add_index_if_missing('genres','idx_genres_name',
    'ALTER TABLE genres ADD INDEX idx_genres_name (name)');

CALL add_index_if_missing('song_artists','idx_song_artists_song',
    'ALTER TABLE song_artists ADD INDEX idx_song_artists_song (song_id)');
CALL add_index_if_missing('song_artists','idx_song_artists_artist',
    'ALTER TABLE song_artists ADD INDEX idx_song_artists_artist (artist_id)');

CALL add_index_if_missing('song_genres','idx_song_genres_song',
    'ALTER TABLE song_genres ADD INDEX idx_song_genres_song (song_id)');
CALL add_index_if_missing('song_genres','idx_song_genres_genre',
    'ALTER TABLE song_genres ADD INDEX idx_song_genres_genre (genre_id)');

CALL add_index_if_missing('song_albums','idx_song_albums_song',
    'ALTER TABLE song_albums ADD INDEX idx_song_albums_song (song_id)');
CALL add_index_if_missing('song_albums','idx_song_albums_album',
    'ALTER TABLE song_albums ADD INDEX idx_song_albums_album (album_id)');

DROP PROCEDURE add_index_if_missing$$
DELIMITER ;
