USE nexshop_db;

-- Con esto se extrae todo el historial de precios base para comprobar que la empresa no ha manipulado los importes antes de, por ejemplo, una rebaja.
SELECT * FROM Historico_PVP;

-- Con esto se muestra el directorio de empleados actuales.
SELECT nombre, cargo, email_corporativo, dni, fecha_incorporacion, id_sede FROM Empleado;

-- Con esto se identifica de forma exacta los tickets de soporte pendientes.
SELECT * FROM Ticket_Incidencia WHERE estado = 'Abierto';

-- Aquí se busca cualquier producto de tipo portátil en el catálogo, independientemente de su modelo.
SELECT * FROM Producto WHERE id_subcategoria LIKE '1';

-- Aquí se filtra las direcciones de entrega que pertenecen a la provincia de Madrid (cuyo código postal empieza por 28).
SELECT * FROM Direccion WHERE cp LIKE '28%';

-- Con esto se audita las campañas promocionales que fueron lanzadas y estuvieron activas durante el año 2026.
SELECT * FROM Promocion WHERE fecha_inicio BETWEEN '2026-01-01' AND '2026-12-31';

-- Con esto se localiza las valoraciones negativas o regulares (entre 1 y 3).
SELECT * FROM Valoracion WHERE puntuacion BETWEEN 1 AND 3;

-- Aquí se registra todos los canjes de puntos (valores matemáticamente menores a 0) para auditar el gasto del saldo.
SELECT * FROM Movimiento_Puntos WHERE cantidad < 0;

-- Se ordenan los acuerdos de proveedores desde el más barato al más caro para priorizar o replantear compras.
SELECT * FROM Acuerdo_Proveedor ORDER BY precio_coste ASC;

-- Aquí se muestra las líneas de venta presencial ordenadas por el volumen de artículos comprados, de mayor a menor.
SELECT * FROM Linea_Ticket_Tienda ORDER BY cantidad DESC;

-- Con esto generamos un listado alfabético de clientes registrados ordenado por apellidos y luego por nombre.
SELECT * FROM Cliente ORDER BY apellidos ASC, nombre ASC;

-- Aquí acctualizamos el estado de un ticket de una incidencia concreto para reflejar que un trabajador ya está trabajando en solucionar el problema.
UPDATE Ticket_Incidencia SET estado = 'En gestion' WHERE id_incidencia = 2;

-- Aquí se valida una reseña de producto tras comprobar manualmente que el cliente anónimo sí lo adquirió de forma física en la tienda.
UPDATE Valoracion SET compra_verificada = TRUE WHERE id_producto = 3 AND id_cliente = 2;

-- Cruzamos el catálogo con el historial de precios para auditar cómo ha variado el precio de cada producto.
SELECT p.nombre AS Producto, hp.pvp AS Precio_Oficial, hp.fecha_inicio
FROM Producto p
JOIN Historico_PVP hp ON p.id_producto = hp.id_producto
ORDER BY p.nombre ASC, hp.fecha_inicio DESC;
