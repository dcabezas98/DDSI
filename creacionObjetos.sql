USE videoclub;

INSERT INTO Socio VALUES ("12345678A", "Socio1", "192356498", "Calle Esperanza s/n", DATE('2003-08-15'));
INSERT INTO Socio VALUES ("12345678X", "Socio2", "192356497", "Calle Margarita 2", DATE('1990-09-15'));
INSERT INTO Socio VALUES ("12345678Z", "Socio3", "192356496", "Calle Esperanza 34", DATE('2001-11-25'));

INSERT INTO Pelicula VALUES ("La novia cadaver", 2007, "Una novia vuelve de la muerte", 3);
INSERT INTO Pelicula VALUES ("La novia cadaver", 2009, "Una novia vuelve de la muerte", 3);
INSERT INTO Pelicula VALUES ("Rain Man", 1995, "Tiene un hermano con asperger", 16);
INSERT INTO Pelicula VALUES ("The irishman", 2019, "Mafia", 18);

INSERT INTO DVD VALUES ("La novia cadaver", 2007, "987654321");
INSERT INTO DVD VALUES ("La novia cadaver", 2007, "987654324");
INSERT INTO DVD VALUES ("La novia cadaver", 2009, "987654325");
INSERT INTO DVD VALUES ("Rain Man", 1995, "987654322");
INSERT INTO DVD VALUES ("The irishman", 2019, "987654323");

INSERT INTO Reserva VALUES ("12345678A", "Rain Man", 1995, DATE('2019-11-25'));
INSERT INTO Reserva VALUES ("12345678X", "The irishman", 2019, DATE('2019-11-8'));
INSERT INTO Reserva VALUES ("12345678A", "La novia cadaver", 2007, DATE('2019-10-10'));

INSERT INTO Alquiler VALUES ("987654321", DATE('2019-08-25'), "12345678Z", DATE('2019-11-25'));
INSERT INTO Alquiler VALUES ("987654322", DATE('2019-11-25'), "12345678X", null);
INSERT INTO Alquiler VALUES ("987654323", DATE('2019-08-13'), "12345678X", null);

INSERT INTO Empleado VALUES ("11111111A", "Empleado1", "611111111", 1100, DATE('1991-1-1'), "Limpieza");
INSERT INTO Empleado VALUES ("22222222B", "Empleado2", "622222222", 800, DATE('1992-2-2'), "Dependiente");
INSERT INTO Empleado VALUES ("33333333C", "Empleado3", "633333333", 500, DATE('1993-3-3'), "Dependiente");
INSERT INTO Empleado VALUES ("44444444D", "Empleado4", "644444444", 1400, DATE('1994-4-4'), "Mantenimiento");

INSERT INTO Turno VALUES ("11111111A", DATE('2020-11-25'));
INSERT INTO Turno VALUES ("11111111A", DATE('2020-01-25'));
INSERT INTO Turno VALUES ("22222222B", DATE('2019-11-24'));
INSERT INTO Turno VALUES ("33333333C", DATE('2019-11-26'));
