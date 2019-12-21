DROP DATABASE IF EXISTS videoclub;
CREATE DATABASE videoclub;
USE videoclub;

DROP TABLE IF EXISTS Socio;
DROP TABLE IF EXISTS Reserva;
DROP TABLE IF EXISTS Alquiler;
DROP TABLE IF EXISTS Pelicula;
DROP TABLE IF EXISTS DVD;
DROP TABLE IF EXISTS Empleado;
DROP TABLE IF EXISTS Turno;

create table Socio(
    DNI VARCHAR(9) PRIMARY KEY,
    nombre VARCHAR(60),
    telefono VARCHAR(9),
    domicilio VARCHAR(60),
    fechaNacimiento DATE
);

create table Pelicula(
    titulo VARCHAR(60),
    anio INT,
    descripcion VARCHAR(512),
    calificacionPorEdad INT,
    PRIMARY KEY (titulo, anio)
);

create table Reserva(
    DNI VARCHAR(9) REFERENCES Socio(DNI),
    titulo VARCHAR(60),
    anio INT,
    fechaReserva DATE NOT NULL check(fechaReserva <= SYSDATE()),
    PRIMARY KEY (DNI, titulo, anio),
    FOREIGN KEY (titulo, anio)  REFERENCES Pelicula(titulo, anio)
);

create table Alquiler(
    cod_DVD VARCHAR(9) REFERENCES DVD(codigo),
    fechaAlquiler DATE check(fechaReserva <= SYSDATE()),
    DNI VARCHAR(9) REFERENCES Socio(DNI),
    fechaDevolucion DATE check(fechaReserva <= SYSDATE()),
    PRIMARY KEY (cod_DVD, fechaAlquiler)
);

create table DVD(
    titulo VARCHAR(60),
    anio INT,
    codigo VARCHAR(9) PRIMARY KEY,
    FOREIGN KEY (titulo, anio)  REFERENCES Pelicula(titulo, anio) 
ON DELETE CASCADE
);


create table Empleado(
    DNI VARCHAR(9) PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    telefono VARCHAR(9),
    salario INT,
    fechaNacimiento DATE,
    puestoTrabajo VARCHAR(80) NOT NULL
);


create table Turno(
    DNI VARCHAR(9) REFERENCES Empleado(DNI) ON DELETE CASCADE,
    diaYHora DATE CHECK(diaYHora>=SYSDATE()),
    PRIMARY KEY (DNI, diaYHora)
);

