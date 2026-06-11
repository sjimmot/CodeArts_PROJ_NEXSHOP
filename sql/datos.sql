USE nexshop_db;

-- 1. SEDE
INSERT INTO Sede (nombre, tipo, ciudad) VALUES 
('Almacén Central', 'Central', 'Valencia'),
('NexShop Valencia', 'Tienda', 'Valencia'),
('NexShop Madrid', 'Tienda', 'Madrid'),
('NexShop Barcelona', 'Tienda', 'Barcelona');

-- 2. EMPLEADO
INSERT INTO Empleado (dni, nombre, email_corporativo, fecha_incorporacion, cargo, id_sede) VALUES 
('11111111A', 'Ana Ferrer', 'a.ferrer@nexshop.es', '2015-01-10', 'Logistica', 1),
('22222222B', 'David Cano', 'd.cano@nexshop.es', '2016-03-15', 'Logistica', 1),
('33333333C', 'Laura Pons', 'l.pons@nexshop.es', '2017-06-20', 'Atencion Cliente', 1),
('44444444D', 'Sergio Blanco', 's.blanco@nexshop.es', '2015-02-01', 'Logistica', 1),
('55555555E', 'Marta Ruiz', 'm.ruiz@nexshop.es', '2019-09-01', 'Encargado', 3),
('66666666F', 'Luis Vendedor', 'l.vendedor@nexshop.es', '2020-11-10', 'Vendedor', 3),
('77777777G', 'Carlos Almacen', 'c.almacen@nexshop.es', '2021-01-15', 'Responsable Almacen', 2);

-- 3. CLIENTE
INSERT INTO Cliente (nombre, apellidos, email, contrasena, fecha_nac) VALUES 
('Elena', 'Gómez', 'elena@email.com', 'hash_pass_123', '1985-11-22'),
('Javier', 'Martínez', 'javier@email.com', 'hash_pass_456', '1990-04-15'),
('Carmen', 'López', 'carmen@email.com', 'hash_pass_789', NULL);

-- 4. DIRECCION
INSERT INTO Direccion (id_cliente, tipo_direccion, calle, numero, bloque, planta, puerta, cp, ciudad, pais) VALUES 
(1, 'Domicilio', 'Calle Silos', '45', 'B', '2', 'A', '41500', 'Alcalá de Guadaíra', 'España'),
(2, 'Trabajo', 'Gran Vía', '10', NULL, 'Bajo', 'C', '28013', 'Madrid', 'España'),
(2, 'Domicilio', 'Calle Atocha', '120', '1', '5', 'Izda', '28012', 'Madrid', 'España');

-- 5. CATEGORIA
INSERT INTO Categoria (nombre) VALUES ('Informática'), ('Telefonía'), ('Accesorios');

-- 6. SUBCATEGORIA
INSERT INTO Subcategoria (id_categoria, nombre) VALUES 
(1, 'Portátiles'), 
(1, 'Monitores'), 
(2, 'Smartphones');

-- 7. PRODUCTO
INSERT INTO Producto (id_subcategoria, nombre) VALUES 
(1, 'Portátil Ultraligero X1'),
(1, 'Portátil Gaming Z'),
(3, 'Smartphone Pro 12');

-- 8. HISTORICO_PVP
INSERT INTO Historico_PVP (id_producto, pvp, fecha_inicio, fecha_fin) VALUES 
(1, 999.00, '2025-01-01', '2025-12-31'),
(1, 899.00, '2026-01-01', NULL),
(2, 1499.00, '2026-01-01', NULL),
(3, 650.00, '2026-01-01', NULL);

-- 9. PROMOCION
INSERT INTO Promocion (nombre, descuento_pct, fecha_inicio, fecha_fin) VALUES 
('Black Friday 2026', 15.00, '2026-11-20', '2026-11-30'),
('Días Sin IVA', 21.00, '2026-05-10', '2026-05-15'),
('Navidad 2025', 20.00, '2025-12-01', '2025-12-31'); -- [NUEVO] Promoción expirada

-- 10. PRODUCTO_PROMOCION
INSERT INTO Producto_Promocion (id_producto, id_promocion) VALUES 
(1, 1), (2, 1), (3, 2), (2, 3); -- [NUEVO] Producto 2 vinculado a la promo expirada

-- 11. PROVEEDOR
INSERT INTO Proveedor (nombre, id_empleado_rep) VALUES 
('TechSupply EU', 4), ('GlobalPhones', 4);

-- 12. ACUERDO_PROVEEDOR
INSERT INTO Acuerdo_Proveedor (id_producto, id_proveedor, precio_coste, plazo_entrega_dias, fecha_inicio, fecha_fin) VALUES 
(1, 1, 600.00, 3, '2025-01-01', NULL),
(3, 2, 400.00, 5, '2025-01-01', NULL),
(3, 1, 410.00, 2, '2025-02-01', NULL); -- [NUEVO] El Smartphone Pro 12 (id 3) lo suministran dos proveedores distintos con diferentes costes y plazos

-- 13. STOCK
INSERT INTO Stock (id_sede, id_producto, cantidad) VALUES 
(1, 1, 150), (1, 2, 50), (1, 3, 200),
(3, 1, 10), (3, 3, 25);

-- 14. TRANSFERENCIA_STOCK
INSERT INTO Transferencia_Stock (fecha, id_sede_origen, id_sede_destino, id_producto, cantidad, id_empleado_autoriza) VALUES 
('2026-05-01 10:00:00', 1, 3, 1, 5, 2);

-- 15. PEDIDO_ONLINE
INSERT INTO Pedido_Online (id_cliente, id_direccion, fecha) VALUES 
(1, 1, '2026-05-12 14:30:00'),
(2, 2, '2026-06-01 09:15:00'); -- [NUEVO] Pedido 2, que será fraccionado

-- 16. LINEA_PEDIDO_ONLINE
INSERT INTO Linea_Pedido_Online (id_pedido, id_producto, cantidad, precio_unitario) VALUES 
(1, 1, 1, 899.00),
(1, 3, 1, 650.00),
(2, 1, 1, 899.00), -- [NUEVO] Líneas del pedido 2
(2, 2, 1, 1499.00); 

-- 17. ENVIO
INSERT INTO Envio (id_pedido, id_sede_origen, num_seguimiento, transportista, fecha_estimada) VALUES 
(1, 1, 'TRK-987654321', 'Seur', '2026-05-15'),
(2, 1, 'TRK-111111111', 'Correos Express', '2026-06-03'), -- [NUEVO] Envío 1 del pedido 2 (Sale de Almacén Central)
(2, 3, 'TRK-222222222', 'Seur', '2026-06-04');          -- [NUEVO] Envío 2 del pedido 2 (Sale de Tienda Madrid por falta de stock en el central)

-- 18. LINEA_ENVIO
INSERT INTO Linea_Envio (id_envio, id_producto, cantidad) VALUES 
(1, 1, 1), (1, 3, 1),
(2, 2, 1), -- [NUEVO] El portátil Gaming se envía en el paquete 1
(3, 1, 1); -- [NUEVO] El portátil ultraligero se envía en el paquete 2

-- 19. TICKET_TIENDA
INSERT INTO Ticket_Tienda (id_sede, id_empleado, id_cliente, fecha) VALUES 
(3, 6, NULL, '2026-05-20 18:45:00');

-- 20. LINEA_TICKET_TIENDA
INSERT INTO Linea_Ticket_Tienda (id_ticket, id_producto, cantidad, precio_unitario) VALUES 
(1, 3, 1, 650.00);

-- 21. DEVOLUCION
INSERT INTO Devolucion (id_ticket, fecha) VALUES 
(1, '2026-05-22 10:15:00');

-- 22. TICKET_INCIDENCIA
INSERT INTO Ticket_Incidencia (id_cliente, asunto, descripcion, fecha_apertura, estado, id_empleado, id_pedido, fecha_cierre, nota_resolucion) VALUES 
(1, 'Retraso en envío', 'El tracking no se actualiza', '2026-05-16 09:00:00', 'Resuelto', 3, 1, '2026-05-16 11:00:00', 'Se contactó con Seur, entregan hoy.'),
(2, 'Paquete incompleto', 'Me ha llegado un portátil pero pedí dos. ¿Dónde está el resto?', '2026-06-04 12:30:00', 'Abierto', 3, 2, NULL, NULL); -- [NUEVO] Ticket abierto por la confusión del envío fraccionado

-- 23. VALORACION
INSERT INTO Valoracion (id_producto, id_cliente, puntuacion, comentario, compra_verificada) VALUES 
(1, 1, 5, 'El portátil vuela, excelente compra.', TRUE),
(3, 2, 2, 'Batería deficiente.', FALSE);

-- 24. MOVIMIENTO_PUNTOS
INSERT INTO Movimiento_Puntos (id_cliente, fecha, id_pedido, cantidad, tipo) VALUES 
(1, '2026-05-12 14:30:00', 1, 15490, 'Ganado'),
(1, '2026-05-25 10:00:00', NULL, -5000, 'Canjeado'); -- [NUEVO] Canje de puntos. Usar números negativos blinda matemáticamente el cálculo de saldo usando SUM(cantidad)