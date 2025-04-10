CREATE OR REPLACE FUNCTION calculate_user_age(__birth_date DATE)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
DECLARE
    __age INTEGER;
BEGIN
    __age := DATE_PART('year', AGE(CURRENT_DATE, __birth_date));
    RETURN __age;
END;
$$;

---

SELECT calculate_user_age('2001-11-02');