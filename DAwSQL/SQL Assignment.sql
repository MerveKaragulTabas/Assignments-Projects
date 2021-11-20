 CREATE TABLE Actions (
      Visitor_ID int,
      Adv_Type varchar(10),
   	  Action  varchar(10)
    );

INSERT INTO Actions( Visitor_ID, Adv_Type, Action)
VALUES
       ('1','A','Left'),
       ('2','A','order'),
       ('3','B','Left'),
       ('4','A','order'),
       ('5','A','Review'),
       ('6','A','Left'),
	   ('7','B','Left'),
	   ('8','B','order'),
       ('9','B','Review'),
       ('10','A','Review');


-- 2. soru --


SELECT Adv_Type, Count(Action_m) As Num_Action, (SELECT Count(Action_m) FROM Actions WHERE Action_m = 'Order' AND Adv_Type = 'A' ) As Num_order
FROM Actions
WHERE Adv_Type = 'A'
GROUP BY Adv_Type

UNION

SELECT Adv_Type, Count(Action_m) As Num_Action, (SELECT Count(Action_m) FROM Actions WHERE Action_m = 'Order' AND Adv_Type = 'B' ) As Num_order
FROM Actions
WHERE Adv_Type = 'B'
GROUP BY Adv_Type



-- 3. soru --

SELECT Adv_Type, 100/(Num_Action/Num_order)*0.01 AS Conversion_Rate
FROM (SELECT Adv_Type, Count(Action_m) AS Num_Action, (SELECT Count(Action_m) FROM Actions WHERE Action_m = 'Order' AND Adv_Type
FROM Actions
WHERE Adv_Type = 'A'
GROUP BY Adv_Type

UNION

SELECT Adv_Type, 100/(Num_Action/Num_order)*0.01 AS Conversion_Rate
FROM (SELECT Adv_Type, Count(Action_m) AS Num_Action, (SELECT Count(Action_m) FROM Actions WHERE Action_m = 'Order' AND Adv_Type
FROM Actions
WHERE Adv_Type = 'B'
GROUP BY Adv_Type