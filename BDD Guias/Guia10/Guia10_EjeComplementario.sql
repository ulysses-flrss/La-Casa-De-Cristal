
-- Ejercicio 1
-- Vista 1. Mostrar el código del producto, el nombre del producto y el precio por unidad de todos los productos de la empresa

CREATE VIEW vista_uno AS
SELECT ProductID AS 'Código del Producto', ProductName AS 'Nombre del Producto', UnitPrice AS 'Precio por Unidad'
FROM Products;

SELECT * FROM vista_uno;

-- Vista 2. Mostrar todos los productos cuya categoría sea Beverages.

CREATE VIEW vista_dos AS
SELECT ProductID AS 'Código del Producto', ProductName AS 'Nombre del Producto', UnitPrice AS 'Precio por Unidad'
FROM Products
WHERE CategoryID = 1;

SELECT * FROM vista_dos;

-- Vista 3. Mostrar los datos del cliente y las fechas de las ordenes que estos han realizado

CREATE VIEW vista_tres AS
SELECT Customers.CustomerID, Customers.ContactName, Orders.OrderDate
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

SELECT * FROM vista_tres;

-- Vista 4. Cuantos productos existen por cada categoría

CREATE VIEW vista_cuatro AS
SELECT Categories.CategoryName, COUNT(Products.ProductID) AS 'Número de Productos'
FROM Categories
INNER JOIN Products ON Categories.CategoryID = Products.CategoryID
GROUP BY Categories.CategoryName;

SELECT * FROM vista_cuatro;

-- Vista 5. Mostrar el promedio de los precios unitarios de las categorías: Produce y Confections

CREATE VIEW vista_cinco AS
SELECT Categories.CategoryName, AVG(Products.UnitPrice) AS 'Promedio de Precios'
FROM Categories
INNER JOIN Products ON Categories.CategoryID = Products.CategoryID
WHERE Categories.CategoryName IN ('Produce', 'Confections')
GROUP BY Categories.CategoryName;


SELECT * FROM vista_cinco;

-- Ejercicio 2
-- Crear un procedimiento almacenado que calcule y muestre la edad de un empleado
USE Northwind
CREATE PROCEDURE sp_EdadEmpleado
        @idEmpleado int
AS
	DECLARE @edad AS int
	DECLARE @total AS int
	SELECT @total = COUNT(*) FROM Employees WHERE EmployeeID = @idEmpleado
	IF(@total >= 1)
		BEGIN
			--BEGIN
			SELECT (CAST(DATEDIFF(dd, BirthDate,GETDATE())/365.25 as int)) AS [Edad del Empleado] FROM Employees WHERE EmployeeID = @idEmpleado
			--END
			SELECT @edad = (CAST(DATEDIFF(dd, BirthDate,GETDATE())/365.25 as int)) FROM Employees WHERE EmployeeID = @idEmpleado
			SELECT 
				CASE
				WHEN @edad > 60 AND @edad <= 70
					THEN 'Está por retirarse.'
				WHEN @edad > 70
					THEN 'Ya está jubilado.'
				ELSE
					'Le faltan otros años para trabajar.'
			
			END AS [Estado]
		END
	ELSE
		PRINT 'Error, No se encontró al Empleado'
GO
--DROP PROCEDURE sp_EdadEmpleado

EXEC sp_EdadEmpleado 2;
EXEC sp_EdadEmpleado 8;
EXEC sp_EdadEmpleado 10;

-- Error
EXEC sp_EdadEmpleado 45;

--SELECT * FROM Employees
