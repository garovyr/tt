CREATE TABLE IF NOT EXISTS users (

    id SERIAL PRIMARY KEY,

    email VARCHAR(100) UNIQUE NOT NULL,

    name VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL,

    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW()
);

---

CREATE OR REPLACE PROCEDURE add_new_user(__name VARCHAR, __email VARCHAR, __password VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM users WHERE email = __email) THEN
        RAISE EXCEPTION 'Already email & was added', __email;
    END IF;

    INSERT INTO users (email, name, password, created_at)
    VALUES (__email, __name, __password, NOW());
END;
$$;

---

CALL add_new_user('John Doe', 'john.doe@example.com', '1241414');

SELECT * FROM users;