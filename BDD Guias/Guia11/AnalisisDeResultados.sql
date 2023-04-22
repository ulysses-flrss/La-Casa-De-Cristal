CREATE DATABASE Control_Pedidos
GO
USE Control_Pedidos
GO
CREATE TABLE producto(
	idproducto CHAR(8) NOT NULL,
	nombreproducto VARCHAR(25),
	existencia INT NOT NULL,
	precio DECIMAL(10,2) NOT NULL, --precio costo
	preciov DECIMAL(10,2) NOT NULL, --precio venta
	CONSTRAINT pk_idproducto PRIMARY KEY(idproducto)
)
GO

CREATE TABLE pedidos(
	idpedido INT IDENTITY,
	idproducto CHAR(8) NOT NULL,
	cantidad_pedido INT,
	CONSTRAINT fk_idbod FOREIGN KEY (idproducto) REFERENCES producto(idproducto)
)
GO

INSERT INTO producto VALUES('prod001', 'Filtros pantalla', 5, 10, 12.5)
INSERT INTO producto VALUES('prod002', 'Parlantes', 7, 10, 11.5)
INSERT INTO producto VALUES('prod003', 'Mouse', 8, 4.5, 6)
INSERT INTO producto VALUES('prod004', 'Monitor', 10, 60.2, 80.0)
INSERT INTO producto VALUES('prod005', 'Lapiz', 5, 1.2, 2.0)
INSERT INTO producto VALUES('prod007', 'Computador', 2, 100, 200)
INSERT INTO pedidos VALUES (2, 'prod007' ,1)

-- Ejercicio 1
-- Crear un desencadenador que se active cada vez que se inserte un registro en la tabla pedidos y otro para la tabla producto.
CREATE TRIGGER insercion_producto ON producto
FOR INSERT AS
PRINT 'Se ha insertado un nuevo registro en la tabla Producto'
GO
--DROP TRIGGER insercion_producto


CREATE TRIGGER insercion_pedidos ON pedidos
FOR INSERT AS
print 'Se ha insertado un nuevo registro en la tabla Pedidos'
GO
--DROP TRIGGER insercion_pedidos

-- Ejercicio 2
-- Crear un desencadenador para la tabla producto, que se active cada vez que se inserte un registro o se actualice la columna precio, la condición para aceptar al inserción o la actualización es que el precio costo no debe ser mayor que el precio venta.
CREATE TRIGGER insercion_actualizacion_producto ON producto
FOR INSERT, UPDATE AS
DECLARE @precio FLOAT,
		@precioV FLOAT
SELECT @precio = precio FROM inserted
SELECT @precioV = preciov FROM inserted
IF (@precio > @precioV)
BEGIN
	RAISERROR( 'El precio de costo no puede ser mayor al precio de venta', 16, 1)
	ROLLBACK TRAN
END
GO
--DROP TRIGGER insercion_actualizacion_producto

-- Ejercicio 3
-- Crear un desencadenador para la tabla pedidos que cada vez que se realice un pedido descuente la existencia de la tabla productos, en caso que la cantidad del pedido supere a la existencia debe deshacer la transacción y mostrar un mensaje de error.
CREATE TRIGGER insercion_pedido ON pedidos
FOR INSERT AS
DECLARE @existencias INT,
		@cantidad INT,
		@id INT
SELECT @cantidad = cantidad_pedido FROM inserted
SELECT @existencias = existencia FROM inserted INNER JOIN producto ON inserted.idproducto = producto.idproducto
SELECT @id = idproducto FROM inserted
IF (@cantidad > @existencias) 
BEGIN
	RAISERROR( 'No hay existencias suficientes', 16, 1)
	ROLLBACK TRAN
END
ELSE
	UPDATE producto SET existencia = @existencias - @cantidad WHERE idproducto = @id
	PRINT 'Pedido insertado correctamente'
GO