USE nexshop_db;

INSERT INTO Sede (nombre, tipo, ciudad) VALUES 
('Almacén Central', 'Central', 'Valencia'),
('NexShop Valencia', 'Tienda', 'Valencia'),
('NexShop Madrid', 'Tienda', 'Madrid'),
('NexShop Barcelona', 'Tienda', 'Barcelona');

INSERT INTO Empleado (dni, nombre, email_corporativo, fecha_incorporacion, cargo, id_sede) VALUES 
('11111111A', 'Ana Ferrer', 'a.ferrer@nexshop.es', '2015-01-10', 'Logistica', 1),
('22222222B', 'David Cano', 'd.cano@nexshop.es', '2016-03-15', 'Logistica', 1),
('33333333C', 'Laura Pons', 'l.pons@nexshop.es', '2017-06-20', 'Atencion Cliente', 1),
('44444444D', 'Sergio Blanco', 's.blanco@nexshop.es', '2015-02-01', 'Logistica', 1),
('55555555E', 'Marta Ruiz', 'm.ruiz@nexshop.es', '2019-09-01', 'Encargado', 3),
('66666666F', 'Luis Vendedor', 'l.vendedor@nexshop.es', '2020-11-10', 'Vendedor', 3),
('77777777G', 'Carlos Almacen', 'c.almacen@nexshop.es', '2021-01-15', 'Responsable Almacen', 2);

INSERT INTO Cliente (nombre, apellidos, email, contrasena, fecha_nac) VALUES 
('Elena', 'Gómez', 'elena@email.com', 'hash_pass_123', '1985-11-22'),
('Javier', 'Martínez', 'javier@email.com', 'hash_pass_456', '1990-04-15'),
('Carmen', 'López', 'carmen@email.com', 'hash_pass_789', NULL);

INSERT INTO Direccion (id_cliente, tipo_direccion, calle, numero, bloque, planta, puerta, cp, ciudad, pais) VALUES 
(1, 'Domicilio', 'Calle Silos', '45', 'B', '2', 'A', '41500', 'Alcalá de Guadaíra', 'España'),
(2, 'Trabajo', 'Gran Vía', '10', NULL, 'Bajo', 'C', '28013', 'Madrid', 'España'),
(2, 'Domicilio', 'Calle Atocha', '120', '1', '5', 'Izda', '28012', 'Madrid', 'España');

INSERT INTO Categoria (nombre) VALUES ('Informática'), ('Telefonía'), ('Accesorios');

INSERT INTO Subcategoria (id_categoria, nombre) VALUES 
(1, 'Portátiles'), 
(1, 'Monitores'), 
(2, 'Smartphones');

INSERT INTO Producto (id_subcategoria, nombre) VALUES 
(1, 'MSI GS63VR-7RF'),
(1, 'Apple MacBook Neo (Azul)'),
(3, 'Apple iPhone 17 256GB (EE.UU con 5G mmWave, Sage Green)');

INSERT INTO Historico_PVP (id_producto, pvp, fecha_inicio, fecha_fin) VALUES 
(1, 1109.00, '2018-01-01', '2025-12-31'),
(1, 399.00, '2026-01-01', NULL),
(2, 700.00, '2026-01-01', NULL),
(3, 950.00, '2026-01-01', NULL);

INSERT INTO Promocion (nombre, descuento_pct, fecha_inicio, fecha_fin) VALUES 
('Black Friday 2026', 15.00, '2026-11-20', '2026-11-30'),
('Días Sin IVA', 21.00, '2026-05-10', '2026-05-15'),
('Navidad 2025', 20.00, '2025-12-01', '2025-12-31');

INSERT INTO Producto_Promocion (id_producto, id_promocion) VALUES 
(1, 1), (2, 1), (3, 2), (2, 3);

INSERT INTO Proveedor (nombre, id_empleado_rep) VALUES 
('TechSupply EU', 4), ('GlobalPhones', 4);

INSERT INTO Acuerdo_Proveedor (id_producto, id_proveedor, precio_coste, plazo_entrega_dias, fecha_inicio, fecha_fin) VALUES 
(1, 1, 800.00, 3, '2018-01-01', NULL),
(3, 2, 400.00, 5, '2025-01-01', NULL),
(3, 1, 810.00, 2, '2025-02-01', NULL);

INSERT INTO Stock (id_sede, id_producto, cantidad) VALUES 
(1, 1, 150), (1, 2, 50), (1, 3, 200),
(3, 1, 10), (3, 3, 25);

INSERT INTO Transferencia_Stock (fecha, id_sede_origen, id_sede_destino, id_producto, cantidad, id_empleado_autoriza) VALUES 
('2026-05-01 10:00:00', 1, 3, 1, 5, 2);

INSERT INTO Pedido_Online (id_cliente, id_direccion, fecha) VALUES 
(1, 1, '2026-05-12 14:30:00'),
(2, 2, '2026-06-01 09:15:00');

INSERT INTO Linea_Pedido_Online (id_pedido, id_producto, cantidad, precio_unitario) VALUES 
(1, 1, 1, 899.00),
(1, 3, 1, 650.00),
(2, 1, 1, 899.00),
(2, 2, 1, 1499.00); 

INSERT INTO Envio (id_pedido, id_sede_origen, num_seguimiento, transportista, fecha_estimada) VALUES 
(1, 1, 'TRK-987654321', 'Seur', '2026-05-15'),
(2, 1, 'TRK-111111111', 'Correos Express', '2026-06-03'),
(2, 3, 'TRK-222222222', 'Seur', '2026-06-04');

INSERT INTO Linea_Envio (id_envio, id_producto, cantidad) VALUES 
(1, 1, 1), (1, 3, 1),
(2, 2, 1),
(3, 1, 1);

INSERT INTO Ticket_Tienda (id_sede, id_empleado, id_cliente, fecha) VALUES 
(3, 6, NULL, '2026-05-20 18:45:00');

INSERT INTO Linea_Ticket_Tienda (id_ticket, id_producto, cantidad, precio_unitario) VALUES 
(1, 3, 1, 650.00);

INSERT INTO Devolucion (id_ticket, fecha) VALUES 
(1, '2026-05-22 10:15:00');

INSERT INTO Ticket_Incidencia (id_cliente, asunto, descripcion, fecha_apertura, estado, id_empleado, id_pedido, fecha_cierre, nota_resolucion) VALUES 
(1, 'Retraso en envío', 'El tracking no se actualiza', '2026-05-16 09:00:00', 'Resuelto', 3, 1, '2026-05-16 11:00:00', 'Se contactó con Seur, entregan hoy.'),
(2, 'Paquete incompleto', 'Me ha llegado un portátil pero pedí dos. ¿Dónde está el resto?', '2026-06-04 12:30:00', 'Abierto', 3, 2, NULL, NULL); -- [NUEVO] Ticket abierto por la confusión del envío fraccionado

INSERT INTO Valoracion (id_producto, id_cliente, puntuacion, comentario, compra_verificada) VALUES 
(1, 1, 5, 'El portátil vuela, excelente compra.', TRUE),
(3, 2, 2, 'Batería deficiente.', FALSE);

INSERT INTO Movimiento_Puntos (id_cliente, fecha, id_pedido, cantidad, tipo) VALUES 
(1, '2026-05-12 14:30:00', 1, 15490, 'Ganado'),
(1, '2026-05-25 10:00:00', NULL, -5000, 'Canjeado');