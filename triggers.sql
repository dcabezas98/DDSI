USE videoclub;

DROP TRIGGER IF EXISTS bajaSocio;
DROP TRIGGER IF EXISTS dvd_alquilado;
DROP TRIGGER IF EXISTS salario_minimo_insert;
DROP TRIGGER IF EXISTS salario_minimo_update;
DROP TRIGGER IF EXISTS menor_edad;
DROP TRIGGER IF EXISTS dvd_ya_alquilado;

delimiter //
CREATE TRIGGER bajaSocio 
BEFORE DELETE ON Socio 
FOR EACH ROW

BEGIN
    
IF EXISTS (SELECT * FROM Alquiler as a WHERE a.DNI = OLD.DNI AND a.fechaDevolucion IS NULL) 
THEN
    signal sqlstate '45000' set message_text='Error: El socio tiene alquileres abiertos.';
END IF;
     
END;//
delimiter ;

delimiter //
CREATE TRIGGER dvd_alquilado
BEFORE DELETE ON DVD
FOR EACH ROW

BEGIN
  IF EXISTS (SELECT * FROM Alquiler AS a
           WHERE a.cod_DVD = OLD.codigo and a.fechaDevolucion IS NULL)

  THEN
      signal sqlstate '45000' set message_text='Error: El DVD está alquilado.';
  END IF;

END;//
delimiter ;

delimiter //
CREATE TRIGGER salario_minimo_update
BEFORE UPDATE ON Empleado 
FOR EACH ROW
       BEGIN
           IF NEW.salario < 600 THEN
               SET NEW.salario = 600;
           END IF;
       END;//
delimiter ;

delimiter //
CREATE TRIGGER salario_minimo_insert 
BEFORE INSERT ON Empleado
FOR EACH ROW
       BEGIN
           IF NEW.salario < 600 THEN
               SET NEW.salario = 600;
           END IF;
       END;//
delimiter ;

delimiter //
CREATE TRIGGER menor_edad
BEFORE INSERT ON Alquiler
FOR EACH ROW

BEGIN
    IF (SELECT fechaNacimiento FROM Socio AS S WHERE S.DNI=NEW.DNI) > (SELECT DATE_ADD(SYSDATE(), INTERVAL -18 YEAR))
        AND (SELECT calificacionPorEdad FROM Pelicula AS P NATURAL JOIN DVD AS D WHERE D.codigo =             NEW.cod_DVD) = 18
    THEN SIGNAL SQLSTATE "45000" SET message_text = 'Error: No se pueden alquilar películas para adultos a menores de edad';
    END IF;

END;
//
delimiter ;

delimiter //
CREATE TRIGGER dvd_ya_alquilado
BEFORE INSERT ON Alquiler
FOR EACH ROW

BEGIN
  IF EXISTS (SELECT * FROM Alquiler AS a
           WHERE a.cod_DVD = NEW.cod_DVD and a.fechaDevolucion IS NULL)

  THEN
      signal sqlstate '45000' set message_text='Error: El DVD ya está alquilado.';
  END IF;

END;//
delimiter ;
