CREATE DATABASE IF NOT EXISTS nexshop_db;
USE nexshop_db;

CREATE TABLE Sede (
    id_sede INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    tipo ENUM('Central', 'Tienda') NOT NULL,
    ciudad VARCHAR(50) NOT NULL
);

CREATE TABLE Empleado (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    dni VARCHAR(15) UNIQUE NOT NULL,
    nombre VARCHAR(80) NOT NULL,
    email_corporativo VARCHAR(150) UNIQUE NOT NULL,
    fecha_incorporacion DATE NOT NULL,
    cargo ENUM(
        'Encargado',
        'Vendedor',
        'Responsable Almacen',
        'Logistica',
        'Compras',
        'Atencion Cliente'
    ) NOT NULL,
    id_sede INT NOT NULL,
    FOREIGN KEY (id_sede) REFERENCES Sede(id_sede)
);

CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(80) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    fecha_nac DATE NULL
);

CREATE TABLE Direccion (
    id_direccion INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    tipo_direccion ENUM('Domicilio', 'Trabajo', 'Otra') NOT NULL,
    calle VARCHAR(100) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    bloque VARCHAR(10) NULL,
    planta VARCHAR(10) NULL,
    puerta VARCHAR(10) NULL,
    cp VARCHAR(10) NOT NULL,
    ciudad VARCHAR(50) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

CREATE TABLE Categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Subcategoria (
    id_subcategoria INT AUTO_INCREMENT PRIMARY KEY,
    id_categoria INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
);

CREATE TABLE Producto (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    id_subcategoria INT NOT NULL,
    nombre VARCHAR(120) NOT NULL,
    FOREIGN KEY (id_subcategoria) REFERENCES Subcategoria(id_subcategoria)
);

CREATE TABLE Historico_PVP (
    id_historico INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    pvp DECIMAL(10,2) NOT NULL CHECK (pvp >= 0),
    fecha_inicio DATETIME NOT NULL,
    fecha_fin DATETIME NULL,
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

CREATE TABLE Promocion (
    id_promocion INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descuento_pct DECIMAL(5,2) NOT NULL CHECK (descuento_pct BETWEEN 0 AND 100),
    fecha_inicio DATETIME NOT NULL,
    fecha_fin DATETIME NOT NULL
);

CREATE TABLE Producto_Promocion (
    id_producto INT NOT NULL,
    id_promocion INT NOT NULL,
    PRIMARY KEY (id_producto, id_promocion),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto),
    FOREIGN KEY (id_promocion) REFERENCES Promocion(id_promocion)
);

CREATE TABLE Proveedor (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_empleado_rep INT NOT NULL,
    FOREIGN KEY (id_empleado_rep) REFERENCES Empleado(id_empleado)
);

CREATE TABLE Acuerdo_Proveedor (
    id_acuerdo INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    id_proveedor INT NOT NULL,
    precio_coste DECIMAL(10,2) NOT NULL CHECK (precio_coste >= 0),
    plazo_entrega_dias SMALLINT NOT NULL CHECK (plazo_entrega_dias >= 0),
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NULL,
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto),
    FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id_proveedor)
);

CREATE TABLE Stock (
    id_sede INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad MEDIUMINT NOT NULL CHECK (cantidad >= 0),
    PRIMARY KEY (id_sede, id_producto),
    FOREIGN KEY (id_sede) REFERENCES Sede(id_sede),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

CREATE TABLE Transferencia_Stock (
    id_transferencia INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATETIME NOT NULL,
    id_sede_origen INT NOT NULL,
    id_sede_destino INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad MEDIUMINT NOT NULL CHECK (cantidad > 0),
    id_empleado_autoriza INT NOT NULL,
    FOREIGN KEY (id_sede_origen) REFERENCES Sede(id_sede),
    FOREIGN KEY (id_sede_destino) REFERENCES Sede(id_sede),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto),
    FOREIGN KEY (id_empleado_autoriza) REFERENCES Empleado(id_empleado)
);

CREATE TABLE Pedido_Online (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_direccion INT NOT NULL,
    fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_direccion) REFERENCES Direccion(id_direccion)
);

CREATE TABLE Linea_Pedido_Online (
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad SMALLINT NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10,2) NOT NULL CHECK (precio_unitario >= 0),
    PRIMARY KEY (id_pedido, id_producto),
    FOREIGN KEY (id_pedido) REFERENCES Pedido_Online(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

CREATE TABLE Envio (
    id_envio INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_sede_origen INT NOT NULL,
    num_seguimiento VARCHAR(80) NOT NULL,
    transportista VARCHAR(50) NOT NULL,
    fecha_estimada DATE NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES Pedido_Online(id_pedido),
    FOREIGN KEY (id_sede_origen) REFERENCES Sede(id_sede)
);

CREATE TABLE Linea_Envio (
    id_envio INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad SMALLINT NOT NULL CHECK (cantidad > 0),
    PRIMARY KEY (id_envio, id_producto),
    FOREIGN KEY (id_envio) REFERENCES Envio(id_envio),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

CREATE TABLE Ticket_Tienda (
    id_ticket INT AUTO_INCREMENT PRIMARY KEY,
    id_sede INT NOT NULL,
    id_empleado INT NOT NULL,
    id_cliente INT NULL,
    fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_sede) REFERENCES Sede(id_sede),
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

CREATE TABLE Linea_Ticket_Tienda (
    id_ticket INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad SMALLINT NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10,2) NOT NULL CHECK (precio_unitario >= 0),
    PRIMARY KEY (id_ticket, id_producto),
    FOREIGN KEY (id_ticket) REFERENCES Ticket_Tienda(id_ticket),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

CREATE TABLE Devolucion (
    id_devolucion INT AUTO_INCREMENT PRIMARY KEY,
    id_ticket INT NOT NULL,
    fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_ticket) REFERENCES Ticket_Tienda(id_ticket)
);

CREATE TABLE Ticket_Incidencia (
    id_incidencia INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    asunto VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL,
    fecha_apertura DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado ENUM('Abierto', 'En gestion', 'Resuelto') NOT NULL,
    id_empleado INT NOT NULL,
    id_pedido INT NULL,
    fecha_cierre DATETIME NULL,
    nota_resolucion TEXT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado),
    FOREIGN KEY (id_pedido) REFERENCES Pedido_Online(id_pedido)
);

CREATE TABLE Valoracion (
    id_producto INT NOT NULL,
    id_cliente INT NOT NULL,
    puntuacion TINYINT NOT NULL CHECK (puntuacion BETWEEN 1 AND 5),
    comentario TEXT NULL,
    compra_verificada BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (id_producto, id_cliente),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

CREATE TABLE Movimiento_Puntos (
    id_movimiento INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_pedido INT NULL,
    cantidad MEDIUMINT NOT NULL,
    tipo ENUM('Ganado', 'Canjeado') NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_pedido) REFERENCES Pedido_Online(id_pedido)
);
