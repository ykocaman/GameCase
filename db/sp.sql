/* Hediyeleri (gift tablosu) kendi süresine göre - 7 gün vb. - 10 dakikada bir pasife çeken SQL sorgusu */

DROP PROCEDURE IF EXISTS expire_gifts;
DELIMITER ;;

CREATE PROCEDURE gamecase.expire_gifts ()
BEGIN
DECLARE n INT DEFAULT 0;
DECLARE i INT DEFAULT 0;

SELECT COUNT(*) FROM gifts INTO n;
SET i=0;
WHILE i<n DO 
	SELECT id,expire_day  INTO @id, @expire_day FROM gifts LIMIT i,1;
	UPDATE gifts_sent SET status = 'expired' WHERE gift_id = @id and date < NOW() - INTERVAL @expire_day DAY;
	SET i = i + 1;	
END WHILE;

End
;;


CREATE EVENT `expire_gifts` ON SCHEDULE EVERY 10 MINUTE STARTS '2016-05-01 00:00:00' ON COMPLETION NOT PRESERVE ENABLE DO call expire_gifts();
