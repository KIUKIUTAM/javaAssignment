DELIMITER //
CREATE EVENT IF NOT EXISTS update_reserve_state
ON SCHEDULE EVERY 1 MINUTE
STARTS CURRENT_TIMESTAMP
DO
BEGIN
    -- Update records where arrival time has passed and state is 2 (Rejected)
    UPDATE fruit_reserve_record 
    SET state = 3 
    WHERE arrival_date <= NOW() 
    AND state = 2;
END//
DELIMITER ;