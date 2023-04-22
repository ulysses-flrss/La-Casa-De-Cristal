USE master
GO

CREATE DATABASE Bodega
GO 

USE Bodega
GO

CREATE TABLE PRODUCTO(
	idprod CHAR(7) PRIMARY KEY,
	descripcion VARCHAR(25),
	existencias INT, --cantidad de producto existentes
	precio DECIMAL(10,2) NOT NULL, --precio costo
	preciov DECIMAL(10,2) NOT NULL, --precio venta
	ganancia AS preciov - precio, --campo para calcular ganancia
	CHECK(preciov > precio) --precio venta tiene que ser mayor al precio de compra
)
GO
CREATE TABLE PEDIDO(
	idpedido CHAR(7),
	idprod CHAR(7),
	cantidad INT -- cantidad de unidades vendidas del producto en el pedido
	FOREIGN KEY(idprod) REFERENCES PRODUCTO(idprod)
);

-- Ejercicio 1
-- Crear un procedimiento almacenado que ingrese los valores en la tabla PRODUCTOS
CREATE PROCEDURE sp_ingreso_producto
	@idprod CHAR(7),
	@descripcion VARCHAR(25),
	@existencias INT,
	@precio DECIMAL(10,2),
	@preciov DECIMAL(10,2)
AS	
	
	IF(SELECT COUNT(*) FROM PRODUCTO
        WHERE idprod = @idprod OR descripcion = @descripcion) = 0
		BEGIN
			INSERT INTO 
				PRODUCTO(idprod, descripcion, existencias, precio, preciov)
			VALUES
				(@idprod, @descripcion, @existencias, @precio, @preciov)
		END
	ELSE
		PRINT 'ESTE PRODUCTO YA HA SIDO INGRESADO'
GO

EXEC sp_ingreso_producto 'PROD001', 'Dulces de sabores', 20, 9.50, 10;
EXEC sp_ingreso_producto 'PROD002', 'Café colombiano', 15, 14.25, 16;
EXEC sp_ingreso_producto 'PROD003', 'Trompos de colección', 5, 7, 9;

--Demostración de error
EXEC sp_ingreso_producto 'PROD001', 'Dulces de sabores', 20, 9.50, 10;

-- Ejercicio 2
-- Crear un procedimiento almacenado que permita realizar un pedido EN LA TABLA PEDIDO
CREATE PROCEDURE sp_ingreso_pedido
	@idpedido CHAR(7),
	@idprod CHAR(7),
	@cantidad int
AS
	DECLARE @existencias AS int
	IF(SELECT COUNT(*) FROM PRODUCTO WHERE idprod = @idprod) > 0
		BEGIN
			SELECT @existencias = existencias FROM PRODUCTO
				WHERE idprod = @idprod
			IF(@existencias) >= @cantidad
				BEGIN
				--Insertando el producto
					INSERT INTO 
						PEDIDO(idpedido, idprod, cantidad)
					VALUES
						(@idpedido, @idprod, @cantidad);
				--Actualizando las existencias
					UPDATE 
						PRODUCTO 
						SET 
							existencias = (@existencias-@cantidad)
					WHERE 
						idprod = @idprod
				END
			ELSE
				PRINT 'EXISTENCIAS DEL PRODUCTO INSUFICIENTES'
		END
	ELSE
		PRINT 'ESTE PRODUCTO NO EXISTE'
GO

EXEC sp_ingreso_pedido 'PD00001', 'PROD001', 5;
EXEC sp_ingreso_pedido 'PD00002', 'PROD001', 15;
EXEC sp_ingreso_pedido 'PD00003', 'PROD002', 7;
EXEC sp_ingreso_pedido 'PD00004', 'PROD003', 2;

--Error de id(Producto)
EXEC sp_ingreso_pedido 'PD00001', 'PROD441', 5;

--Error de existencias
EXEC sp_ingreso_pedido 'PD00001', 'PROD001', 55;

--SELECT * FROM PRODUCTO;
--SELECT * FROM PEDIDO;