-- V1: начальная схема
CREATE TABLE roles (
    id          uuid PRIMARY KEY,
    code        text UNIQUE NOT NULL,
    name        text NOT NULL
);

CREATE TABLE users (
    id             uuid PRIMARY KEY,
    email          text UNIQUE NOT NULL,
    password_hash  text NOT NULL,
    role_id        uuid REFERENCES roles(id),
    created_at     timestamptz DEFAULT now(),
    updated_at     timestamptz DEFAULT now()
);

CREATE TABLE tests (
    id          uuid PRIMARY KEY,
    title       text NOT NULL,
    description text,
    created_by  uuid REFERENCES users(id),
    created_at  timestamptz DEFAULT now()
);

CREATE TABLE test_results (
    id          uuid PRIMARY KEY,
    user_id     uuid REFERENCES users(id),
    test_id     uuid REFERENCES tests(id),
    score_json  jsonb NOT NULL,
    taken_at    timestamptz DEFAULT now()
);

CREATE TABLE skills (
    id        uuid PRIMARY KEY,
    code      text UNIQUE NOT NULL,
    name      text NOT NULL,
    category  text
);

CREATE TABLE user_skill_levels (
    user_id   uuid REFERENCES users(id),
    skill_id  uuid REFERENCES skills(id),
    level     int CHECK (level BETWEEN 0 AND 100),
    updated_at timestamptz DEFAULT now(),
    PRIMARY KEY (user_id, skill_id)
);

CREATE TABLE contents (
    id            uuid PRIMARY KEY,
    type          text,
    title         text NOT NULL,
    url           text,
    duration_min  int
);

CREATE TABLE learning_tasks (
    id         uuid PRIMARY KEY,
    user_id    uuid REFERENCES users(id),
    skill_id   uuid REFERENCES skills(id),
    content_id uuid REFERENCES contents(id),
    status     text CHECK (status IN ('planned','in_progress','done')),
    due_at     date
);

CREATE TABLE gamification_events (
    id         uuid PRIMARY KEY,
    user_id    uuid REFERENCES users(id),
    event      text,
    points     int,
    created_at timestamptz DEFAULT now()
);