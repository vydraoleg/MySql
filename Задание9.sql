-- Задание 9

CREATE DATABASE `itacademia`; 
SHOW DATABASES; 
USE `itacademia`; 

DROP TABLE printer;
DROP TABLE laptop;
DROP TABLE pc;
DROP TABLE product;

CREATE TABLE product (
	maker VARCHAR(10), 
	model VARCHAR(50) PRIMARY KEY,
	`type` VARCHAR(50) CHECK (`type` IN ('PC','Laptop','Printer')))
;
INSERT INTO `itacademia`.`product` (`maker`, `model`, `type`) VALUES ('HP', 'HP-1', 'PC'); 
INSERT INTO `itacademia`.`product` (`maker`, `model`, `type`) VALUES ('HP', 'HP-2', 'PC'); 
INSERT INTO `itacademia`.`product` (`maker`, `model`, `type`) VALUES ('HP', 'HP-3', 'Laptop'); 
INSERT INTO `itacademia`.`product` (`maker`, `model`, `type`) VALUES ('HP', 'HP-4', 'Printer'); 
INSERT INTO `itacademia`.`product` (`maker`, `model`, `type`) VALUES ('Toshiba', 'T-1', 'Laptop'); 
INSERT INTO `itacademia`.`product` (`maker`, `model`, `type`) VALUES ('Apple', 'A-1', 'Laptop'); 
INSERT INTO `itacademia`.`product` (`maker`, `model`, `type`) VALUES ('OKI', 'O-1', 'Printer'); 
INSERT INTO `itacademia`.`product` (`maker`, `model`, `type`) VALUES ('CASIO', 'C-1', 'Printer'); 
INSERT INTO `itacademia`.`product` (`maker`, `model`, `type`) VALUES ('Brother', 'B-1', 'Printer'); 

CREATE TABLE pc (CODE INT PRIMARY KEY AUTO_INCREMENT, 
	model VARCHAR(50), 
	speed SMALLINT, 
	ram SMALLINT, 
	hd REAL, 
	cd VARCHAR(10), 
	price DECIMAL(15,2) CHECK (`price` > 0 ),
	FOREIGN KEY (model)  REFERENCES product (model));
INSERT INTO `itacademia`.`pc` (`model`, `speed`, `ram`, `hd`, `cd`, `price`) VALUES ('HP-1', '2700', '64', '1024', '8x', 400);
INSERT INTO `itacademia`.`pc` (`model`, `speed`, `ram`, `hd`, `cd`, `price`) VALUES ('HP-2', '2700', '32', '512', '8x', 300);
	
CREATE TABLE laptop (CODE INT PRIMARY KEY AUTO_INCREMENT, 
	model VARCHAR(50), 
	speed SMALLINT, 
	ram SMALLINT, 
	hd REAL, 
	screen TINYINT, 
	price DECIMAL(15,2),
	FOREIGN KEY (model)  REFERENCES product (model));
INSERT INTO `itacademia`.`laptop` (`model`, `speed`, `ram`, `hd`, `screen`, `price`) VALUES ('A-1', '3200', '128', '1024', '14', '1000'); 
INSERT INTO `itacademia`.`laptop` (`model`, `speed`, `ram`, `hd`, `screen`, `price`) VALUES ('A-1', '3200', '256', '2048', '14', '1200'); 
	

CREATE TABLE printer (CODE INT PRIMARY KEY AUTO_INCREMENT, 
	model VARCHAR(50), 
	color CHAR(1),
	`type` VARCHAR(10) CHECK (`type` IN ('Laser','Jet','Matrix') ), 
	price DECIMAL(15,2)  CHECK (`price` > 0 ),
	FOREIGN KEY (model)  REFERENCES product (model));
 INSERT INTO `itacademia`.`printer` (`model`, `color`, `type`, `price`) VALUES ('B-1', 'Y', 'Jet', '100'); 
 INSERT INTO `itacademia`.`printer` (`model`, `color`, `type`, `price`) VALUES ('O-1', 'N', 'Laser', '200'); 
 INSERT INTO `itacademia`.`printer` (`model`, `color`, `type`, `price`) VALUES ('C-1', 'N', 'Matrix', '100'); 
 INSERT INTO `itacademia`.`printer` (`model`, `color`, `type`, `price`) VALUES ('HP-4', 'Y', 'Laser', '500'); 	
 
-- Задание 2


-- Задание: 1
-- Найдите номер модели, скорость и размер жесткого диска для всех ПК стоимостью менее 500 дол.
-- Вывести: model, speed и hd
SELECT `model`, `speed`, `hd`
	FROM  pc
	WHERE price < 500;

-- Задание: 2
-- Найдите производителей принтеров. Вывести: maker
SELECT `maker` 
	FROM product 
	WHERE `type` = 'Printer'
	GROUP BY maker;

-- Задание: 3
-- Найдите номер модели, объем памяти и размеры экранов ПК-блокнотов, цена которых превышает 1000 дол.
SELECT `model`, `ram`, `screen`
	FROM `laptop`
	WHERE `price` > 1000;

-- Задание: 4
-- Найдите все записи таблицы Printer для цветных принтеров.
SELECT * 
	FROM `printer` 
	WHERE `color`='Y';

-- Задание: 5
-- Найдите номер модели, скорость и размер жесткого диска ПК, имеющих 12x или 24x CD и цену менее 600 дол.
SELECT `model`, `speed`, `hd`
	FROM  pc
	WHERE `cd` IN ('12x','24x') AND price < 600;
	
-- Задание: 6
-- Укажите производителя и скорость для тех ПК-блокнотов, которые имеют жесткий диск объемом не менее 10 Гбайт.
SELECT p.`maker`, l.`speed`
	FROM `laptop` l INNER JOIN `product` p ON l.`model` = p.`model`
	WHERE l.`hd` > 10;

-- Задание: 7
-- Найдите номера моделей и цены всех продуктов (любого типа), выпущенных производителем B (латинская буква).
SELECT l.`model` , l.`price`
	FROM `product` p INNER JOIN `laptop` l  ON l.`model` = p.`model`
	WHERE p.`maker`='B'
UNION SELECT l.`model` , l.`price`	
	FROM `product` p INNER JOIN `pc` l  ON l.`model` = p.`model`
	WHERE p.`maker`='B'
UNION SELECT l.`model` , l.`price`	
	FROM `product` p INNER JOIN `printer` l  ON l.`model` = p.`model`
	WHERE p.`maker`='B';
-- Задание: 8
-- Найдите производителя, выпускающего ПК, но не ПК-блокноты.
SELECT p.`maker`
	FROM `product` p INNER JOIN `pc` l  ON l.`model` = p.`model`
	WHERE NOT p.`model` IN (SELECT l.`model` FROM `laptop` l);
-- Задание: 9
-- Найдите производителей ПК с процессором не менее 450 Мгц. Вывести: Maker
SELECT p.`maker`
	FROM `product` p INNER JOIN `pc` l  ON l.`model` = p.`model`
	WHERE l.`speed` < 450;
-- Задание: 10
-- Найдите принтеры, имеющие самую высокую цену. Вывести: model, price
SELECT p.`model`, p.`price` 
	FROM `printer` p
	WHERE p.`price`= (SELECT MAX(`price`) FROM `printer` );

-- Задание: 11
-- Найдите среднюю скорость ПК.
SELECT AVG(p.`speed`) AS avgspeed
	FROM `pc` p;

-- Задание: 12
-- Найдите среднюю скорость ПК-блокнотов, цена которых превышает 1000 дол.
SELECT AVG(p.`speed`) AS avgspeed
	FROM `laptop` p
	WHERE p.`price` > 1000;

-- Задание: 13
-- Найдите среднюю скорость ПК, выпущенных производителем A.

SELECT AVG(l.`speed`) avgspeed
	FROM `product` p INNER JOIN `pc` l  ON l.`model` = p.`model`
	WHERE p.`maker`='A';

-- Задание: 14
-- Для каждого значения скорости найдите среднюю стоимость ПК с такой же скоростью процессора.
-- Вывести: скорость, средняя цена
SELECT l.`speed`, AVG(l.`price`) avgprice
	FROM `pc` l 
	GROUP BY l.`speed`;

-- Задание: 15
-- Найдите размеры жестких дисков, совпадающих у двух и более PC. Вывести: HD
SELECT l.`hd` AS hd
	FROM `pc` l 
	GROUP BY l.`hd`
	HAVING COUNT(1) > 1;

-- Задание: 16
-- Найдите пары моделей PC, имеющих одинаковые скорость и RAM. В результате каждая пара
-- указывается только один раз, т.е. (i,j), но не (j,i), Порядок вывода: модель с большим номером,
-- модель с меньшим номером, скорость и RAM
SELECT p1.`model` , p2.`model`
	FROM `pc` p1 INNER JOIN `pc` p2
		ON p1.speed = p2.`speed` 
		AND p1.`ram`=p2.`ram`
	WHERE p1.`model`> p2.`model`;
		

-- Задание: 17
-- Найдите модели ПК-блокнотов, скорость которых меньше скорости любого из ПК.
-- Вывести: type, model, speed

SELECT p.`type`, l.`model`, l.`speed`
	FROM `laptop` l INNER JOIN `product` p ON(l.`model` = p.`model`)
	WHERE l.`speed` < (SELECT MIN(speed) FROM pc);

-- Задание: 18
-- Найдите производителей самых дешевых цветных принтеров. Вывести: maker, price

SELECT p.`maker`, r.`price`
	FROM `printer` r INNER JOIN `product` p ON(r.`model` = p.`model`)
	WHERE r.`color`='Y' AND r.`price` = (SELECT MIN(price) FROM printer WHERE r.`color`='Y');

-- Задание: 19
-- Для каждого производителя найдите средний размер экрана выпускаемых им ПК-блокнотов.
-- Вывести: maker, средний размер экрана.

SELECT p.`maker`, AVG(r.`screen`) AS avgscreen
	FROM `laptop` r INNER JOIN `product` p ON(r.`model` = p.`model`)
	GROUP BY p.`maker`;

-- Задание: 20
-- Найдите производителей, выпускающих по меньшей мере три различных модели ПК. Вывести:
-- Maker, число моделей

SELECT p.`maker`, COUNT(1) quantity
	FROM `product` p 
	WHERE p.`type`='PC'
	GROUP BY p.`maker`
	HAVING COUNT(1) > 2;
	
-- Задание: 21
-- Найдите максимальную цену ПК, выпускаемых каждым производителем. Вывести: maker,
-- максимальная цена.

SELECT p.`maker`, MAX(r.`price`) AS maxprice
	FROM `pc` r INNER JOIN `product` p ON(r.`model` = p.`model`)
	GROUP BY p.`maker`;

-- Задание: 22
-- Для каждого значения скорости ПК, превышающего 600 МГц, определите среднюю цену ПК с такой
-- же скоростью. Вывести: speed, средняя цена.

SELECT p.`maker`, MAX(r.`price`) AS maxprice
	FROM `pc` r INNER JOIN `product` p ON(r.`model` = p.`model`)
	GROUP BY p.`maker`;

-- Задание: 23
-- Найдите производителей, которые производили бы как ПК со скоростью не менее 750 МГц, так и
-- ПК-блокноты со скоростью не менее 750 МГц. Вывести: Maker

SELECT maker FROM (
	SELECT p.`maker` AS maker
		FROM `pc` r INNER JOIN `product` p ON (r.`model` = p.`model`)
		WHERE r.`speed` >=750
	UNION SELECT p.`maker` AS maker
		FROM `laptop` r INNER JOIN `product` p ON (r.`model` = p.`model`)
		WHERE r.`speed` >=750 ) res
	GROUP BY maker;

-- Задание: 24
-- Перечислите номера моделей любых типов, имеющих самую высокую цену по всей имеющейся в
-- базе данных продукции.

WITH 
c1 AS (SELECT l.`model` , p.`type`, l.`price` AS price
	FROM `product` p INNER JOIN `laptop` l  ON l.`model` = p.`model`
	WHERE l.`price`= (SELECT MAX(`price`) FROM `laptop` )
	GROUP BY l.`model`, p.`type`
UNION SELECT l.`model` , p.`type`, l.`price`
	FROM `product` p INNER JOIN `pc` l  ON l.`model` = p.`model`
	WHERE l.`price`= (SELECT MAX(`price`) FROM `pc` )
	GROUP BY l.`model`, p.`type`
UNION SELECT l.`model` , p.`type`, l.`price`
	FROM `product` p INNER JOIN `printer` l  ON l.`model` = p.`model` 
	WHERE l.`price`= (SELECT MAX(`price`) FROM `printer` ) )
SELECT * FROM c1 WHERE c1.price = (SELECT MAX(`price`) FROM c1 ) 	
;

-- Задание: 25
-- Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM и с
-- самым быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker	

SELECT p.`maker` FROM product p INNER JOIN pc ON (p.`model`=pc.`model`) 
			INNER JOIN product p1 ON (p1.maker = p.`maker`)
 WHERE p1.`type`= 'Printer' AND pc.speed = (SELECT MAX(speed) FROM pc 
                   WHERE pc.`ram`= (SELECT MIN(ram) FROM pc))
