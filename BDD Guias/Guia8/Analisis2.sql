CREATE DATABASE Control_de_libros
GO
USE Control_de_libros

CREATE TABLE Autor(
CodigoAutor char(5) PRIMARY KEY NOT NULL,
PrimerNombre varchar(50) NOT NULL,
PrimerApellido varchar(50) NOT NULL,
FechaNacimiento date NOT NULL,
Nacionalidad varchar(50) NOT NULL,
Edad int NOT NULL
);

CREATE TABLE Editorial(
CodigoEditorial char(5) PRIMARY KEY NOT NULL,
Nombre varchar (50) NOT NULL,
Pais varchar(30) NOT NULL);

CREATE TABLE Libro(
CodigoLibro char(10) PRIMARY KEY NOT NULL,
Titulo varchar(50) NOT NULL,
ISBN char(20) NOT NULL,
AñoEdicion int NOT NULL,
CodigoEditorial char(5) NOT NULL,
CONSTRAINT FKEditorial FOREIGN KEY (CodigoEditorial) REFERENCES Editorial(CodigoEditorial)
);

CREATE TABLE Detalle_AutorLibro(
CodigoAutor char(5) NOT NULL,
CodigoLibro char(10) NOT NULL,
CONSTRAINT FKAutor FOREIGN KEY (CodigoAutor) REFERENCES Autor(CodigoAutor),
CONSTRAINT FKLibro FOREIGN KEY (CodigoLibro) REFERENCES Libro(CodigoLibro));

USE Control_de_libros
GO



INSERT INTO Autor VALUES
('PL001', 'Pablo', 'López', '19/08/1960', 'Colombiana',54),
('CM002', 'Claudia', 'Martínez', '10/06/1970', 'Salvadorenia', 45),
('PM003', 'Patricio', 'Murry', '12/12/1967', 'Espaniola', 47),
('NH004', 'Nuria',' Hernández', '03/09/1980', 'Colombiana', 34),
('HM005', 'Helen', 'Martínez', '22/11/1980', 'Espaniola', 34),
('JR006', 'José', 'Roldan', '13/09/1967', 'Colombiana', 54);

INSERT INTO Editorial VALUES
('ED001', 'Omega 2000', 'Colombia'),
('ED002', 'Anaya Multimedia', 'España'),
('ED003', 'McGrawHill', 'Inglaterra'),
('ED004', 'Reyes', 'México'),
('ED005', 'Prentice Hall', 'Inglaterra');

INSERT INTO Libro VALUES
('BDCOL00001', 'Fundamentos de Base de datos', '12333-8999988', 2004, 'ED001'),
('BDESP00002', 'La Biblia de SQL Server', '3444-99888-88', 2008, 'ED002'),
('PRCOL00002', 'Programación orientada a objetos', '8999-9999444', 2011, 'ED001'),('DWING00003', 'Diseño Web y Hojas de estilo', '300096-99999', 2010, 'ED003'),
('PRING00004', 'Programación en C/C++', '45667-87878', 2009, 'ED005'),
('HJMEX00005', 'Uso de hojas de estilo con JavaScript', '0990-87878787', 2008, 'ED004'),
('ABESP00006', 'Administración de Base de datos', '585885-88484848', 2010 ,'ED002');

INSERT INTO Detalle_AutorLibro VALUES
('PL001', 'BDCOL00001'),
('NH004', 'BDCOL00001'),
('CM002', 'PRCOL00002'),
('PM003', 'BDESP00002'),
('PM003', 'DWING00003'),
('HM005', 'PRING00004'),
('CM002', 'ABESP00006'),
('NH004', 'HJMEX00005'),
('JR006', 'DWING00003');


--1 Mostrar el primer nombre, primer apellido de los autores junto con el título de libro que estos han escrito
SELECT a.PrimerNombre, a.PrimerApellido, l.Titulo
FROM AUTOR a
INNER JOIN DETALLE_AUTORLIBRO dal ON a.CodigoAutor = dal.CodigoAutor
INNER JOIN LIBRO l ON dal.CodigoLibro = l.CodigoLibro;


-- 2. Mostrar el nombre de la editorial y el título del libro

SELECT e.Nombre AS 'Nombre de la editorial', l.Titulo AS 'Título del libro'
FROM LIBRO l
INNER JOIN Editorial e ON l.CodigoEditorial = e.CodigoEditorial;

-- 3. Mostrar los títulos de los libros y el nombre de la editorial, donde esta sea del país de Inglaterra

SELECT l.Titulo AS 'Título del libro', e.Nombre AS 'Nombre de la editorial'
FROM LIBRO l
INNER JOIN EDITORIAL e ON l.CodigoEditorial = e.CodigoEditorial
WHERE e.Pais = 'Inglaterra';

-- 4 Mostrar los nombres de los autores y el título del libro donde el año de edición sea el más actual
SELECT CONCAT(a.PrimerNombre, ' ', a.PrimerApellido) AS 'Nombre de Autor', l.Titulo
FROM Autor a
INNER JOIN Detalle_AutorLibro dal ON a.CodigoAutor = dal.CodigoAutor
INNER JOIN Libro l ON dal.CodigoLibro = l.CodigoLibro
WHERE l.AñoEdicion = (SELECT MAX(AñoEdicion) FROM Libro)

-- 5 Mostrar los nombres de los autores y el título del libro donde el año de edición sea el menos actual

SELECT CONCAT(a.PrimerNombre, ' ', a.PrimerApellido) AS 'Nombre de Autor', l.Titulo
FROM Autor a
INNER JOIN Detalle_AutorLibro dal ON a.CodigoAutor = dal.CodigoAutor
INNER JOIN Libro l ON dal.CodigoLibro = l.CodigoLibro
WHERE l.AñoEdicion = (SELECT MIN(AñoEdicion) FROM Libro)

-- 6 Agregue los datos necesarios a lastablas, para luego implementar lasinstrucciones LEFT JOIN, RIGHT JOIN Y FULL JOIN, como por ejemplo autores que no han escrito un libro todavía etc.

-- Autores qeu no han escrito un libro

SELECT Autor.PrimerNombre, Autor.PrimerApellido
FROM Autor
LEFT JOIN Detalle_AutorLibro ON Autor.CodigoAutor = Detalle_AutorLibro.CodigoAutor
WHERE Detalle_AutorLibro.CodigoAutor IS NULL


--Editoriales que no han publicado ningun libro
SELECT Editorial.Nombre
FROM Editorial
LEFT JOIN Libro
ON Editorial.CodigoEditorial = Libro.CodigoEditorial
WHERE Libro.CodigoEditorial IS NULL;