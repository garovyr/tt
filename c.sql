CREATE TABLE IF NOT EXISTS orders (

    id SERIAL PRIMARY KEY,

    status VARCHAR(50) NOT NULL,

    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITHOUT TIME ZONE
);

INSERT INTO orders (status) VALUES

	('Paused');

---

CREATE OR REPLACE PROCEDURE update_order_status(__id INTEGER, __new_status VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM orders WHERE id = __id) THEN
        RAISE EXCEPTION 'El pedido con ID % no existe', __id;
    END IF;

    UPDATE orders
    SET status = __new_status, updated_at = NOW()
    WHERE id = __id;
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END;
$$;

---

CALL update_order_status(1, 'Ready');

SELECT * FROM orders;