-- ========================
-- Таблица: Менеджеры
-- ========================
CREATE TABLE managers (
    manager_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    manager_name VARCHAR(255) NOT NULL,
    is_deleted BOOLEAN DEFAULT FALSE
);

-- ========================
-- Таблица: Пользователи
-- ========================
CREATE TABLE users (
    user_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    manager_id INT,
    is_deleted BOOLEAN DEFAULT FALSE,
    
    FOREIGN KEY (manager_id) REFERENCES managers(manager_id) ON DELETE SET NULL
);

-- ========================
-- Таблица: Задачи
-- ========================
CREATE TABLE tasks (
    task_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    task_name VARCHAR(255) NOT NULL,
    author_id INT NOT NULL,
    assigned_id INT,
    is_deleted BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (author_id) REFERENCES users(user_id) ON DELETE SET NULL,
    FOREIGN KEY (assigned_id) REFERENCES users(user_id) ON DELETE SET NULL
);

-- ========================
-- Таблица: Группы
-- ========================
CREATE TABLE groups (
    group_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    group_name VARCHAR(255) UNIQUE NOT NULL,
    is_deleted BOOLEAN DEFAULT FALSE
);

-- ==============================
-- Таблица: Связь пользователей и групп
-- ==============================
CREATE TABLE user_group (
    user_id INT NOT NULL,
    group_id INT NOT NULL,
    PRIMARY KEY (user_id, group_id),
    
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (group_id) REFERENCES groups(group_id) ON DELETE CASCADE
);

-- ========================
-- Индексы (для производительности)
-- ========================
CREATE INDEX idx_users_manager_id ON users(manager_id);
CREATE INDEX idx_tasks_author_id ON tasks(author_id);
CREATE INDEX idx_tasks_assigned_id ON tasks(assigned_id);
CREATE INDEX idx_tasks_created_at ON tasks(created_at);

-- ==========================
-- В таблицы добавлены soft delete флаги для будущей масштабируемости
-- ==========================
