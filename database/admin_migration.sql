-- MusicAPI-v2 public API is not modified by this migration.
-- Languages are currently stored as songs.language (VARCHAR), so the Admin API exposes
-- distinct languages rather than inventing a second source of truth.

-- Optional future admin audit table:
CREATE TABLE IF NOT EXISTS admin_audit_logs (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  action VARCHAR(50) NOT NULL,
  resource VARCHAR(50) NOT NULL,
  resource_id INT UNSIGNED NULL,
  admin_email VARCHAR(255) NOT NULL,
  payload JSON NULL,
  created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_admin_audit_resource (resource, resource_id),
  KEY idx_admin_audit_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
