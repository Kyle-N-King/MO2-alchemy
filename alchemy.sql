CREATE DATABASE health_potions;
USE health_potions;



#CREATING TABLES

CREATE TABLE ingredients(
ing_id INT(3) NOT NULL PRIMARY KEY AUTO_INCREMENT,
ing_name VARCHAR(255) UNIQUE KEY);

ALTER TABLE ingredients MODIFY ing_id int  NOT NULL AUTO_INCREMENT;

CREATE TABLE class(
ing_name VARCHAR(255) NOT NULL PRIMARY KEY,
ing_class VARCHAR(255));

CREATE TABLE base(
ing_name VARCHAR(255) NOT NULL PRIMARY KEY,
base_heal DECIMAL(2,2));

ALTER TABLE base MODIFY base_heal DECIMAL(10,2);

ALTER TABLE base
ADD base_prop DECIMAL(10,2);

CREATE TABLE multiplier(
multi_id VARCHAR(255) NOT NULL PRIMARY KEY,
multiplier_value DECIMAL(2,2) NOT NULL,
tier int(1) NOT NULL);

alter TABLE multiplier RENAME COLUMN  multi_id TO ing_name;
ALTER TABLE multiplier ADD COLUMN price decimal(10,2);

CREATE TABLE location(
ing_name VARCHAR(255) NOT NULL PRIMARY KEY,
ing_type ENUM('Base', 'Multiplier') NOT NULL, 
region VARCHAR(255));

ALTER TABLE location 
ADD COLUMN direction varchar(255);

CREATE TABLE optimal_amount(
combo_no INT(3) NOT NULL PRIMARY KEY AUTO_INCREMENT,
base_name varchar(255),
base_amount INT(10) NOT NULL,
multi_name VARCHAR(255),
multi_amount INT(10) NOT NULL,
base_to_multi_ratio DECIMAL(10,0));

ALTER TABLE optimal_amount MODIFY combo_no int(3) NOT NULL AUTO_INCREMENT;
ALTER TABLE optimal_amount RENAME COLUMN multi_amount TO ing_amount;
DROP TABLE optimal_amount;

CREATE TABLE potion_heal(
total_heal DECIMAL(2,2),
combo_no INT(3));



#FILLING IN TABLES

INSERT INTO ingredients(
ing_name)
VALUES
('sea dew'),
('salvia oil'),
('sponge'),
('skadite'),
('gold'),
('jadeite'),
('clothos spider queen carc'),
('great horn'),
('calx fish'),
('nitre spider queen carc'),
('prium juice'),
('electrum'),
('jambura juice'),
('gamun oil'),
('compact horn'),
('basileus'),
('mino'),
('kyanite'),
('pirium'),
('waterstone'),
('white bear carc');

SELECT * FROM ingredients
ORDER BY ing_id;

INSERT INTO class
VALUES
('sea dew', 'plant'),
('salvia oil', 'plant'),
('sponge', 'plant'),
('skadite', 'metal'),
('gold', 'metal'),
('jadeite', 'metal'),
('clothos spider queen carc', 'animal'),
('great horn', 'animal'),
('calx fish', 'animal'),
('nitre spider queen carc', 'animal'),
('prium juice', 'plant'),
('electrum', 'metal'),
('jambura juice', 'plant'),
('gamun oil', 'plant'),
('compact horn', 'animal'),
('basileus', 'plant'),
('mino', 'animal'),
('kyanite', 'metal'),
('pirium', 'plant'),
('waterstone', 'metal'),
('white bear carc', 'animal');

SELECT * FROM class;

INSERT INTO base
VALUES
('sea dew', 1.8),
('salvia oil', 4.2);

UPDATE base SET base_prop = 1.2 WHERE ing_name = 'sea dew';
UPDATE base SET base_prop = 2.1 WHERE ing_name = 'salvia oil';

SELECT * FROM base;

INSERT INTO multiplier
VALUES
('sponge', 0.96,1),
('skadite', 0.96,1),
('gold', 0.69,2),
('jadeite', 0.69,2),
('clothos spider queen carc', 0.69,2),
('great horn', 0.69,2),
('calx fish', 0.69,2),
('nitre spider queen carc', 0.69,2),
('prium juice', 0.56,3),
('electrum', 0.56,3),
('jambura juice', 0.56,3),
('gamun oil', 0.44,4),
('compact horn', 0.44,4),
('basileus', 0.44,4),
('mino', 0.44,4),
('kyanite', 0.44,4),
('pirium', 0.44,4),
('waterstone', 0.44,4),
('white bear carc', 0.44,4);

ALTER TABLE multiplier MODIFY COLUMN price decimal(10,5);
UPDATE multiplier SET price = 0.95 WHERE ing_name = 'skadite';
UPDATE multiplier SET price = 0.03 WHERE ing_name = 'sponge';
UPDATE multiplier SET price = 0.05 WHERE ing_name = 'gold';
UPDATE multiplier SET price = 0.02 WHERE ing_name = 'jadeite';
UPDATE multiplier SET price = 0.0325 WHERE ing_name = 'clothos spider queen carc';
UPDATE multiplier SET price = 0.012 WHERE ing_name = 'great horn';
UPDATE multiplier SET price = 0.04 WHERE ing_name = 'calx fish';
UPDATE multiplier SET price = 0.0275 WHERE ing_name = 'nitre spider queen carc';
UPDATE multiplier SET price = 0.01875 WHERE ing_name = 'pirum juice';
UPDATE multiplier SET price = 0.012 WHERE ing_name = 'electrum';
UPDATE multiplier SET price = 0.0125 WHERE ing_name = 'jambura juice';
UPDATE multiplier SET price = 8.5 WHERE ing_name = 'gamun oil';
UPDATE multiplier SET price = 0.004 WHERE ing_name = 'compact horn';
UPDATE multiplier SET price = 0.02 WHERE ing_name = 'basileus';
UPDATE multiplier SET price = 0.012 WHERE ing_name = 'mino';
UPDATE multiplier SET price = 0.5 WHERE ing_name = 'kyanite';
UPDATE multiplier SET price = 0.01 WHERE ing_name = 'pirum';
UPDATE multiplier SET price = 0.0475 WHERE ing_name = 'waterstone';
UPDATE multiplier SET price = 0.0054 WHERE ing_name = 'white bear carc';

UPDATE multiplier
SET
	ing_name = 'pirum juice'
WHERE
	ing_name = 'prium juice';

UPDATE multiplier
SET
	ing_name = 'pirum'
WHERE
	ing_name = 'pirium';

SELECT * FROM multiplier;

INSERT INTO location
VALUES
('sea dew','base','meduli'),
('salvia oil','base','mk'),
('sponge','multiplier','sunken isles'),
('skadite','multiplier','gk'),
('gold','multiplier','gk'),
('jadeite','multiplier','meduli'),
('clothos spider queen carc','multiplier', 'north steppe'),
('great horn','multiplier', 'talus mountains'),
('calx fish','multiplier','meduli'),
('nitre spider queen carc','multiplier','east steppe'),
('prium juice','multiplier','mk'),
('electrum','multiplier','gk'),
('jambura juice','multiplier','jungle'),
('gamun oil','multiplier','meduli'),
('compact horn','multiplier','jungle'),
('basileus','multiplier','meduli'),
('mino', 'multiplier','talus mountains'),
('kyanite','multiplier','gk'),
('pirium','multiplier','mk'),
('waterstone','multiplier','gk'),
('white bear carc', 'multiplier','talus mountains');

UPDATE location
SET direction = 'North'
WHERE
region = 'gk' or
region ='talus mountains' or
region ='north steppe';

UPDATE location
SET direction = 'West'
WHERE
region = 'meduli' or
region = 'sunken isles';

UPDATE location
SET direction = 'South'
WHERE
region = 'jungle';

UPDATE location
SET direction = 'East'
WHERE
region = 'mk' or
region ='east steppe';

select * from location
order by region;

SELECT COUNT(multi_id) FROM multiplier;

INSERT INTO optimal_amount (base_name,base_amount, ing_name, ing_amount,base_to_multi_ratio)
VALUES
('sea dew', 285, 'sponge', 26, 10.96),
('sea dew', 285, 'skadite', 26, 10.96),
('sea dew', 285, 'jadeite', 16, 17.81),
('sea dew', 285, 'clothos spider queen carc', 16, 17.81),
('sea dew', 285, 'great horn', 16, 17.81),
('sea dew', 285, 'calx fish', 16, 17.81),
('sea dew', 285, 'nitre spider queen carc', 16, 17.81),
('sea dew', 285, 'pirum juice', 11, 25.91),
('sea dew', 285, 'electrum', 11, 25.91),
('sea dew', 285, 'jambura juice', 11, 25.91),
('sea dew', 285, 'ganum juice', 7, 40.71),
('sea dew', 285, 'compact horn', 7, 40.71),
('sea dew', 285, 'basileus', 7, 40.71),
('sea dew', 285, 'mino', 7, 40.71),
('sea dew', 285, 'kyanite', 7, 40.71),
('sea dew', 285, 'pirum', 7, 40.71),
('sea dew', 285, 'waterstone', 7, 40.71),
('sea dew', 285, 'white bear carc', 7, 40.71);

SELECT * from optimal_amount;

INSERT INTO potion_heal
VALUES



#FUNCTIONS
-- optimal multiplier amount if amount of base is changed
DELIMITER $$
CREATE PROCEDURE different_base_amount(IN p_base_name varchar(255), IN p_base_amount int, IN p_ing_name varchar(255))
BEGIN
	SELECT 
		o.base_name,
        p_base_amount,
        o.ing_name,
        CASE
			WHEN m.tier = 1 THEN p_base_amount / 10.96
            WHEN m.tier = 2 THEN p_base_amount / 17.81
		END AS new_multi_amount
	FROM
		multiplier m
			JOIN
		optimal_amount o ON m.ing_name = o.ing_name
	WHERE
		o.base_name = p_base_name AND
        o.ing_name = p_ing_name;
	
END$$

DELIMITER ;

DROP PROCEDURE different_base_amount;
CALL different_base_amount('sea dew', 50, 'calx fish');
CALL different_base_amount('sea dew', 50, 'sponge');



-- broke down to smaller function to figure out how to make bigger function work
DELIMITER $$
CREATE PROCEDURE different_base_amount3(IN p_base_name varchar(255), IN p_base_amount int, IN p_ing_name varchar(255))
BEGIN
	SELECT 
		o.base_name,
        p_base_amount,
        o.ing_name,
        p_base_amount / 17.81 AS new_ing_amount
	FROM
		optimal_amount o
			JOIN
		multi_tier2 m ON o.ing_name = m.ing_name
	WHERE
		o.base_name = p_base_name AND 
        o.ing_name = p_ing_name;
	
END$$

DELIMITER ;

DROP PROCEDURE different_base_amount3;
CALL different_base_amount3('sea dew', 50, 'calx fish');

-- determining amount of heal for sea dew potions
DELIMITER $$
CREATE PROCEDURE sea_dew_potion (IN p_base_name VARCHAR(255), IN p_base_amount integer, IN p_ing_name VARCHAR(255), p_ing_amount integer, p_pot_units INTEGER(3)) 
BEGIN
DECLARE v_total_amount int(3);
SET v_total_amount = p_base_amount + p_ing_amount;
	select
		p_base_name,
		p_base_amount,
		p_ing_name,
		p_ing_amount,
	round(max(2*(1.2*(p_base_amount/v_total_amount))*1*(1+sqrt(p_ing_amount/v_total_amount)*(m.multiplier_value))*p_pot_units),3) AS heal,
    m.price * p_ing_amount AS cost
	FROM
		multiplier m
	WHERE
		m.ing_name = p_ing_name;
        
END$$

DELIMITER ;

DROP PROCEDURE sea_dew_potion;
CALL sea_dew_potion('sea dew', 200, 'gold', 10, 1);

-- determing amount of heal for salvia potions
DELIMITER $$
CREATE PROCEDURE salvia_oil_potion (IN p_base_name VARCHAR(255), IN p_base_amount integer, IN p_ing_name VARCHAR(255), p_ing_amount integer, p_pot_units INTEGER(3)) 
BEGIN
DECLARE v_total_amount int(3);
SET v_total_amount = p_base_amount + p_ing_amount;
	select
		p_base_name,
		p_base_amount,
		p_ing_name,
		p_ing_amount,
	round(max((2*(2.1*(p_base_amount/v_total_amount))*1*(1+sqrt(p_ing_amount/v_total_amount)*m.multiplier_value)*p_pot_units)),3) AS heal,
    m.price * p_ing_amount AS cost
	FROM
		multiplier m
	WHERE
		m.ing_name = p_ing_name;
        
END$$

DELIMITER ;

DROP PROCEDURE salvia_oil_potion;
CALL salvia_oil_potion('salvia oil', 100, 'sponge', 9, 10);











#QUERIES FOR CHARTS
-- which location has most ingredients?

SELECT
	count(i.ing_id) as number_of_ingredients,
    l.region
FROM
	ingredients i
		JOIN
	location l ON i.ing_name = l.ing_name
GROUP BY
	l.region
ORDER BY
	number_of_ingredients;

-- which class has the most ingredients?
SELECT
	count(i.ing_id) as number_of_ingredients,
    c.ing_class,
    l.region,
    l.direction
FROM
	ingredients i
		JOIN
	class c ON i.ing_name = c.ing_name
		JOIN
	location l ON c.ing_name = l.ing_name
GROUP BY c.ing_class, l.region
ORDER BY number_of_ingredients; 

-- how many of each tier is in each class?
SELECT
	c.ing_class,
    m.tier,
    count(m.tier) as number_in_tier
FROM
	multiplier m 
		JOIN
	class c ON m.ing_name = c.ing_name
GROUP by c.ing_class, m.tier
ORDER BY 
	c.ing_class;
    
-- Health vs cost: case study
DELIMITER $$
CREATE PROCEDURE allloopseadew(IN p_base_name VARCHAR(255), IN p_base_amount integer, IN p_ing_name VARCHAR(255), p_ing_amount integer, p_pot_units INTEGER(3))
BEGIN
	DECLARE x decimal(10,3);
    DECLARE v_heal decimal(10,3);
    DECLARE v_cost decimal(10,3);
    DECLaRE v_total_amount int(3);
    CREATE TEMPORARY TABLE allresults (p_base_name varchar(255), p_base_amount int(3), p_ing_name VARCHAR(255), p_ing_amount int(3), heal decimal(10,2), cost decimal(10,2));
    
    SET x = 0;
   
    loop1: LOOP
		SET x = x + 1;
        SET v_total_amount = 
			(SELECT p_base_amount + x);
		SET v_heal = 
			(SELECT 
				round(max((2*(2.1*(p_base_amount/v_total_amount))*1*(1+sqrt(x/v_total_amount)*m.multiplier_value)*p_pot_units)),3)
			FROM
				multiplier m
			WHERE
				m.ing_name = p_ing_name);
		SET v_cost = 
			(SELECT 
				m.price * x
			FROM
				multiplier m
			WHERE
				m.ing_name = p_ing_name);
        CALL sea_dew_potion('sea dew', 100, 'skadite', x, 10);
        IF x = 18 THEN
			LEAVE loop1;
		END IF;
		
        INSERT INTO allresults
        VALUES(p_base_name, p_base_amount, p_ing_name, x, v_heal, v_cost);
        
         INSERT INTO allresults
    VALUES ('sea dew', 100, 'skadite', 0, 24, 0);
    
	END LOOP loop1;
    SELECT p_base_name, p_base_amount, p_ing_name, p_ing_amount,
		m.price * p_ing_amount AS cost
	FROM
		multiplier m
	WHERE
		m.ing_name = p_ing_name;
    SELECT DISTINCT * FROM allresults;
END$$
DELIMITER ;

DROP TABLE IF EXISTS allresults;
DROP PROCEDURE allloopseadew;
CALL allloopseadew('sea dew', 100, 'skadite', 0, 10);
