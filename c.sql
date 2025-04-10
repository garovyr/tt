CREATE TABLE IF NOT EXISTS orders (

    id SERIAL PRIMARY KEY,
	
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),

	---

    status VARCHAR(50) NOT NULL,

    updated_at TIMESTAMP WITHOUT TIME ZONE
);

---

CREATE OR REPLACE PROCEDURE update_order_status(__id INTEGER, __new_status VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM orders WHERE id = __id) THEN
        RAISE EXCEPTION 'Order (id %) does not exist', __id;
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

INSERT INTO orders (status) VALUES

	('Paused');

---

CALL update_order_status(1, 'Ready');

SELECT * FROM orders;