```markdown
# Proyecto de Base de Datos:
## Base de Datos para NexShop Group S.A.

# Realizado por:
## Samuel Jiménez Motos

# Descripción del proyecto:
Este proyecto consiste en el análisis, diseño e implementación desde cero de una base de datos relacional orientada a la gestión de una tienda que vende tanto por canal físico como online. La arquitectura desarrollada da soporte completo al control logístico descentralizado de stock, la diferenciación operativa entre los canales de ventas físicos y online, el seguimiento de variaciones en el catálogo de precios y promociones, la auditoría de acuerdos comerciales con proveedores, la trazabilidad de incidencias de soporte técnico y la contabilidad transparente de un programa de puntos de fidelización para clientes.

# Explicación de la empresa modelada:
NexShop Group S.A. es una empresa ficticia dedicada a la distribución y venta al por menor que fue fundada en el año 2015 con su sede principal ubicada en Valencia. La organización opera en el mercado mediante dos canales de venta bien diferenciados: una plataforma de venta online a través de internet (digamos nexshop.es) y una red logística presencial de tres tiendas físicas ubicadas estratégicamente en las ciudades de Valencia, Madrid y Barcelona.

# Diagrama Entidad-Relación (ER):
El siguiente diagrama describe la totalidad de las veinticuatro entidades del sistema con sus correspondientes claves primarias y foráneas, aplicando una notación limpia que explicita las cardinalidades relacionales requeridas.

```mermaid
erDiagram
    SEDE ||--o{ EMPLEADO : "(1:N)"
    SEDE ||--o{ STOCK : "(1:N)"
    SEDE ||--o{ TRANSFERENCIA_STOCK : "(1:N origen)"
    SEDE ||--o{ TRANSFERENCIA_STOCK : "(1:N destino)"
    SEDE ||--o{ ENVIO : "(1:N)"
    SEDE ||--o{ TICKET_TIENDA : "(1:N)"

    EMPLEADO ||--o{ PROVEEDOR : "(1:N)"
    EMPLEADO ||--o{ TRANSFERENCIA_STOCK : "(1:N)"
    EMPLEADO ||--o{ TICKET_TIENDA : "(1:N)"
    EMPLEADO ||--o{ TICKET_INCIDENCIA : "(1:N)"

    CLIENTE ||--o{ DIRECCION : "(1:N)"
    CLIENTE ||--o{ PEDIDO_ONLINE : "(1:N)"
    CLIENTE ||--o{ TICKET_TIENDA : "(1:N)"
    CLIENTE ||--o{ TICKET_INCIDENCIA : "(1:N)"
    CLIENTE ||--o{ VALORACION : "(1:N)"
    CLIENTE ||--o{ MOVIMIENTO_PUNTOS : "(1:N)"

    DIRECCION ||--o{ PEDIDO_ONLINE : "(1:N)"

    CATEGORIA ||--o{ SUBCATEGORIA : "(1:N)"
    SUBCATEGORIA ||--o{ PRODUCTO : "(1:N)"

    PRODUCTO ||--o{ HISTORICO_PVP : "(1:N)"
    PRODUCTO ||--o{ PRODUCTO_PROMOCION : "(1:N)"
    PRODUCTO ||--o{ ACUERDO_PROVEEDOR : "(1:N)"
    PRODUCTO ||--o{ STOCK : "(1:N)"
    PRODUCTO ||--o{ TRANSFERENCIA_STOCK : "(1:N)"
    PRODUCTO ||--o{ LINEA_PEDIDO_ONLINE : "(1:N)"
    PRODUCTO ||--o{ LINEA_ENVIO : "(1:N)"
    PRODUCTO ||--o{ LINEA_TICKET_TIENDA : "(1:N)"
    PRODUCTO ||--o{ VALORACION : "(1:N)"

    PROMOCION ||--o{ PRODUCTO_PROMOCION : "(1:N)"

    PROVEEDOR ||--o{ ACUERDO_PROVEEDOR : "(1:N)"

    PEDIDO_ONLINE ||--o{ LINEA_PEDIDO_ONLINE : "(1:N)"
    PEDIDO_ONLINE ||--o{ ENVIO : "(1:N)"
    PEDIDO_ONLINE ||--o{ TICKET_INCIDENCIA : "(1:N)"
    PEDIDO_ONLINE ||--o{ MOVIMIENTO_PUNTOS : "(1:N)"

    ENVIO ||--o{ LINEA_ENVIO : "(1:N)"

    TICKET_TIENDA ||--o{ LINEA_TICKET_TIENDA : "(1:N)"
    TICKET_TIENDA ||--o{ DEVOLUCION : "(1:N)"

    SEDE {
        INT id_sede PK
    }

    EMPLEADO {
        INT id_empleado PK
        INT id_sede FK
    }

    CLIENTE {
        INT id_cliente PK
    }

    DIRECCION {
        INT id_direccion PK
        INT id_cliente FK
    }

    CATEGORIA {
        INT id_categoria PK
    }

    SUBCATEGORIA {
        INT id_subcategoria PK
        INT id_categoria FK
    }

    PRODUCTO {
        INT id_producto PK
        INT id_subcategoria FK
    }

    HISTORICO_PVP {
        INT id_historico PK
        INT id_producto FK
    }

    PROMOCION {
        INT id_promocion PK
    }

    PRODUCTO_PROMOCION {
        INT id_producto FK
        INT id_promocion FK
    }

    PROVEEDOR {
        INT id_proveedor PK
        INT id_empleado_rep FK
    }

    ACUERDO_PROVEEDOR {
        INT id_acuerdo PK
        INT id_producto FK
        INT id_proveedor FK
    }

    STOCK {
        INT id_sede FK
        INT id_producto FK
    }

    TRANSFERENCIA_STOCK {
        INT id_transferencia PK
        INT id_sede_origen FK
        INT id_sede_destino FK
        INT id_producto FK
        INT id_empleado_autoriza FK
    }

    PEDIDO_ONLINE {
        INT id_pedido PK
        INT id_cliente FK
        INT id_direccion FK
    }

    LINEA_PEDIDO_ONLINE {
        INT id_pedido FK
        INT id_producto FK
    }

    ENVIO {
        INT id_envio PK
        INT id_pedido FK
        INT id_sede_origen FK
    }

    LINEA_ENVIO {
        INT id_envio FK
        INT id_producto FK
    }

    TICKET_TIENDA {
        INT id_ticket PK
        INT id_sede FK
        INT id_empleado FK
        INT id_cliente FK
    }

    LINEA_TICKET_TIENDA {
        INT id_ticket FK
        INT id_producto FK
    }

    DEVOLUCION {
        INT id_devolucion PK
        INT id_ticket FK
    }

    TICKET_INCIDENCIA {
        INT id_incidencia PK
        INT id_cliente FK
        INT id_empleado FK
        INT id_pedido FK
    }

    VALORACION {
        INT id_producto FK
        INT id_cliente FK
    }

    MOVIMIENTO_PUNTOS {
        INT id_movimiento PK
        INT id_cliente FK
        INT id_pedido FK
    }
```
