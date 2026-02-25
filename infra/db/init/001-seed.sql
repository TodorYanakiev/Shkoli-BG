-- Seed scripts in this folder are executed automatically by MySQL
-- only when /var/lib/mysql is initialized for the first time.
--
-- This block keeps 4 manually created test users in sync with live data:
-- ivan@example.com, petrov@example.com, gergana@example.com, petya@example.com
-- Plain password for all of them is: pass1234
-- (stored in DB as bcrypt hashes below).

INSERT INTO _users (
  firstname,
  lastname,
  email,
  username,
  password,
  role,
  enabled,
  created_at,
  last_modified_at,
  deleted_at,
  administrated_lyceum_id,
  description
)
VALUES
  (
    'Ivan',
    'Ivanov',
    'ivan@example.com',
    'Ivan',
    '$2a$10$8eQdngRID.anRbaSQIpjn.vkZ4OrtCe/SBueXbLQG1KhCWJXAePWi',
    'USER',
    1,
    '2026-02-25 10:10:52',
    '2026-02-25 10:10:52',
    NULL,
    NULL,
    NULL
  ),
  (
    'Gergana',
    'Todorova',
    'gergana@example.com',
    'GeriT',
    '$2a$10$ARTJ0HBgqgf8gfNVVc2uOumSyg42mmv36ZYOfo.9mXUvg80ilTryC',
    'ADMIN',
    1,
    '2026-02-25 10:11:39',
    '2026-02-25 10:14:46',
    NULL,
    NULL,
    NULL
  ),
  (
    'Todor',
    'Petrov',
    'petrov@example.com',
    'PetrovTodor',
    '$2a$10$Yk.Ua71F6U.jer.P9FyL1.GMLpAlw.P/b7OkWZZ.3qnaDANPHtUte',
    'USER',
    1,
    '2026-02-25 10:12:13',
    '2026-02-25 10:15:23',
    NULL,
    742,
    NULL
  ),
  (
    'Petya',
    'Pavlova',
    'petya@example.com',
    'Petya',
    '$2a$10$nwcRUQBOnKgQ0T4a93bS7.gihsP89X4cadk14bM6lu/WQ9h1YF.T2',
    'USER',
    1,
    '2026-02-25 10:14:11',
    '2026-02-25 10:14:11',
    NULL,
    NULL,
    NULL
  )
ON DUPLICATE KEY UPDATE
  firstname = VALUES(firstname),
  lastname = VALUES(lastname),
  username = VALUES(username),
  password = VALUES(password),
  role = VALUES(role),
  enabled = VALUES(enabled),
  last_modified_at = VALUES(last_modified_at),
  deleted_at = VALUES(deleted_at),
  administrated_lyceum_id = VALUES(administrated_lyceum_id),
  description = VALUES(description);

-- Lecturer linkage for ivan@example.com (lyceum_id = 742)
INSERT INTO lyceum_lecturers (lyceum_id, user_id)
SELECT 742, u.id
FROM _users u
WHERE u.email = 'ivan@example.com'
ON DUPLICATE KEY UPDATE
  lyceum_id = VALUES(lyceum_id),
  user_id = VALUES(user_id);
