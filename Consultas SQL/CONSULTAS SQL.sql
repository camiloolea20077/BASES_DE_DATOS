CREATE DATABASE jardineria;
USE jardineria;

CREATE TABLE oficina (
  ID_oficina int identity(1,1), 
  Descripcion VARCHAR(10) NOT NULL,
  ciudad VARCHAR(30) NOT NULL,
  pais VARCHAR(50) NOT NULL,
  region VARCHAR(50) DEFAULT NULL,
  codigo_postal VARCHAR(10) NOT NULL,
  telefono VARCHAR(20) NOT NULL,
  linea_direccion1 VARCHAR(50) NOT NULL,
  linea_direccion2 VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (ID_oficina)
);

CREATE TABLE empleado (
  ID_empleado INT identity(1,1) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  apellido1 VARCHAR(50) NOT NULL,
  apellido2 VARCHAR(50) DEFAULT NULL,
  extension VARCHAR(10) NOT NULL,
  email VARCHAR(100) NOT NULL,
  ID_oficina int NOT NULL,
  ID_jefe INTEGER DEFAULT NULL,
  puesto VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (ID_empleado),
  FOREIGN KEY (ID_oficina) REFERENCES oficina (ID_oficina),
  FOREIGN KEY (ID_jefe) REFERENCES empleado (ID_empleado)
);

CREATE TABLE Categoria_producto (
  Id_Categoria int identity(1,1),
  Desc_Categoria VARCHAR(50) NOT NULL,
  descripcion_texto TEXT,
  descripcion_html TEXT,
  imagen VARCHAR(256),
  PRIMARY KEY (Id_Categoria)
);

CREATE TABLE cliente (
  ID_cliente INTEGER identity(1,1) NOT NULL,
  nombre_cliente VARCHAR(50) NOT NULL,
  nombre_contacto VARCHAR(30) DEFAULT NULL,
  apellido_contacto VARCHAR(30) DEFAULT NULL,
  telefono VARCHAR(15) NOT NULL,
  fax VARCHAR(15) NOT NULL,
  linea_direccion1 VARCHAR(50) NOT NULL,
  linea_direccion2 VARCHAR(50) DEFAULT NULL,
  ciudad VARCHAR(50) NOT NULL,
  region VARCHAR(50) DEFAULT NULL,
  pais VARCHAR(50) DEFAULT NULL,
  codigo_postal VARCHAR(10) DEFAULT NULL,
  ID_empleado_rep_ventas INTEGER DEFAULT NULL,
  limite_credito NUMERIC(15,2) DEFAULT NULL,
  PRIMARY KEY (ID_cliente),
  FOREIGN KEY (ID_empleado_rep_ventas) REFERENCES empleado (ID_empleado)
);

CREATE TABLE pedido (
  ID_pedido INTEGER identity(1,1) NOT NULL,
  fecha_pedido date NOT NULL,
  fecha_esperada date NOT NULL,
  fecha_entrega date DEFAULT NULL,
  estado VARCHAR(15) NOT NULL,
  comentarios TEXT,
  ID_cliente INTEGER NOT NULL,
  PRIMARY KEY (ID_pedido),
  FOREIGN KEY (ID_cliente) REFERENCES cliente (ID_cliente)
);

CREATE TABLE producto (
  ID_producto INTEGER identity(1,1) NOT NULL,
  CodigoProducto VARCHAR(15) NOT NULL,
  nombre VARCHAR(70) NOT NULL,
  Categoria int NOT NULL,
  dimensiones VARCHAR(25) NULL,
  proveedor VARCHAR(50) DEFAULT NULL,
  descripcion text NULL,
  cantidad_en_stock SMALLINT NOT NULL,
  precio_venta NUMERIC(15,2) NOT NULL,
  precio_proveedor NUMERIC(15,2) DEFAULT NULL,
  PRIMARY KEY (ID_producto),
  FOREIGN KEY (Categoria) REFERENCES Categoria_producto (Id_Categoria)
);

CREATE TABLE detalle_pedido (
  ID_detalle_pedido INTEGER identity(1,1) NOT NULL,
  ID_pedido INTEGER NOT NULL,
  ID_producto INTEGER NOT NULL,
  cantidad INTEGER NOT NULL,
  precio_unidad NUMERIC(15,2) NOT NULL,
  numero_linea SMALLINT NOT NULL,
  PRIMARY KEY (ID_detalle_pedido),
  FOREIGN KEY (ID_pedido) REFERENCES pedido (ID_pedido),
  FOREIGN KEY (ID_producto) REFERENCES producto (ID_producto)
);

CREATE TABLE pago (
  ID_pago INTEGER identity(1,1) NOT NULL,
  ID_cliente INTEGER NOT NULL,
  forma_pago VARCHAR(40) NOT NULL,
  id_transaccion VARCHAR(50) NOT NULL,
  fecha_pago date NOT NULL,
  total NUMERIC(15,2) NOT NULL,
  PRIMARY KEY (ID_pago),
  FOREIGN KEY (ID_cliente) REFERENCES cliente (ID_cliente)
);

-- Datos
INSERT INTO oficina VALUES ('BCN-ES','Barcelona','Espa�a','Barcelona','08019','+34 93 3561182','Avenida Diagonal, 38','3A escalera Derecha');
INSERT INTO oficina VALUES ('BOS-USA','Boston','EEUU','MA','02108','+1 215 837 0825','1550 Court Place','Suite 102');
INSERT INTO oficina VALUES ('LON-UK','Londres','Inglaterra','EMEA','EC2N 1HN','+44 20 78772041','52 Old Broad Street','Ground Floor');
INSERT INTO oficina VALUES ('MAD-ES','Madrid','Espa�a','Madrid','28032','+34 91 7514487','Bulevar Indalecio Prieto, 32','');
INSERT INTO oficina VALUES ('PAR-FR','Paris','Francia','EMEA','75017','+33 14 723 4404','29 Rue Jouffroy d''abbans','');
INSERT INTO oficina VALUES ('SFC-USA','San Francisco','EEUU','CA','94080','+1 650 219 4782','100 Market Street','Suite 300');
INSERT INTO oficina VALUES ('SYD-AU','Sydney','Australia','APAC','NSW 2010','+61 2 9264 2451','5-11 Wentworth Avenue','Floor #2');
INSERT INTO oficina VALUES ('TAL-ES','Talavera de la Reina','Espa�a','Castilla-LaMancha','45632','+34 925 867231','Francisco Aguirre, 32','5� piso (exterior)');
INSERT INTO oficina VALUES ('TOK-JP','Tokyo','Jap�n','Chiyoda-Ku','102-8578','+81 33 224 5000','4-1 Kioicho','');

INSERT INTO empleado VALUES ('Marcos','Maga�a','Perez','3897','marcos@jardineria.es',8,NULL,'Director General');
INSERT INTO empleado VALUES ('Ruben','L�pez','Martinez','2899','rlopez@jardineria.es',8,1,'Subdirector Marketing');
INSERT INTO empleado VALUES ('Alberto','Soria','Carrasco','2837','asoria@jardineria.es',8,2,'Subdirector Ventas');
INSERT INTO empleado VALUES ('Maria','Sol�s','Jerez','2847','msolis@jardineria.es',8,2,'Secretaria');
INSERT INTO empleado VALUES ('Felipe','Rosas','Marquez','2844','frosas@jardineria.es',8,3,'Representante Ventas');
INSERT INTO empleado VALUES ('Juan Carlos','Ortiz','Serrano','2845','cortiz@jardineria.es',8,3,'Representante Ventas');
INSERT INTO empleado VALUES ('Carlos','Soria','Jimenez','2444','csoria@jardineria.es',4,3,'Director Oficina');
INSERT INTO empleado VALUES ('Mariano','L�pez','Murcia','2442','mlopez@jardineria.es',4,7,'Representante Ventas');
INSERT INTO empleado VALUES ('Lucio','Campoamor','Mart�n','2442','lcampoamor@jardineria.es',4,7,'Representante Ventas');
INSERT INTO empleado VALUES ('Hilario','Rodriguez','Huertas','2444','hrodriguez@jardineria.es',4,7,'Representante Ventas');
INSERT INTO empleado VALUES ('Emmanuel','Maga�a','Perez','2518','manu@jardineria.es',1,3,'Director Oficina');
INSERT INTO empleado VALUES ('Jos� Manuel','Martinez','De la Osa','2519','jmmart@hotmail.es',1,11,'Representante Ventas');
INSERT INTO empleado VALUES ('David','Palma','Aceituno','2519','dpalma@jardineria.es',1,11,'Representante Ventas');
INSERT INTO empleado VALUES ('Oscar','Palma','Aceituno','2519','opalma@jardineria.es',1,11,'Representante Ventas');
INSERT INTO empleado VALUES ('Francois','Fignon','','9981','ffignon@gardening.com',5,3,'Director Oficina');
INSERT INTO empleado VALUES ('Lionel','Narvaez','','9982','lnarvaez@gardening.com',5,15,'Representante Ventas');
INSERT INTO empleado VALUES ('Laurent','Serra','','9982','lserra@gardening.com',5,15,'Representante Ventas');
INSERT INTO empleado VALUES ('Michael','Bolton','','7454','mbolton@gardening.com',6,3,'Director Oficina');
INSERT INTO empleado VALUES ('Walter Santiago','Sanchez','Lopez','7454','wssanchez@gardening.com',6,18,'Representante Ventas');
INSERT INTO empleado VALUES ('Hilary','Washington','','7565','hwashington@gardening.com',2,3,'Director Oficina');
INSERT INTO empleado VALUES ('Marcus','Paxton','','7565','mpaxton@gardening.com',2,20,'Representante Ventas');
INSERT INTO empleado VALUES ('Lorena','Paxton','','7665','lpaxton@gardening.com',2,20,'Representante Ventas');
INSERT INTO empleado VALUES ('Nei','Nishikori','','8734','nnishikori@gardening.com',9,3,'Director Oficina');
INSERT INTO empleado VALUES ('Narumi','Riko','','8734','nriko@gardening.com',9,23,'Representante Ventas');
INSERT INTO empleado VALUES ('Takuma','Nomura','','8735','tnomura@gardening.com',9,23,'Representante Ventas');
INSERT INTO empleado VALUES ('Amy','Johnson','','3321','ajohnson@gardening.com',3,3,'Director Oficina');
INSERT INTO empleado VALUES ('Larry','Westfalls','','3322','lwestfalls@gardening.com',3,26,'Representante Ventas');
INSERT INTO empleado VALUES ('John','Walton','','3322','jwalton@gardening.com',3,26,'Representante Ventas');
INSERT INTO empleado VALUES ('Kevin','Fallmer','','3210','kfalmer@gardening.com',7,3,'Director Oficina');
INSERT INTO empleado VALUES ('Julian','Bellinelli','','3211','jbellinelli@gardening.com',7,29,'Representante Ventas');
INSERT INTO empleado VALUES ('Mariko','Kishi','','3211','mkishi@gardening.com',7,29,'Representante Ventas');

INSERT INTO Categoria_producto VALUES ('Herbaceas','Plantas para jardin decorativas',NULL,NULL);
INSERT INTO Categoria_producto VALUES ('Herramientas','2 para todo tipo de acci�n',NULL,NULL);
INSERT INTO Categoria_producto VALUES ('Aromaticas','Plantas arom�ticas',NULL,NULL);
INSERT INTO Categoria_producto VALUES ('Frutales','�rboles peque�os de producci�n frutal',NULL,NULL);
INSERT INTO Categoria_producto VALUES ('Ornamentales','Plantas vistosas para la decoraci�n del jard�n',NULL,NULL);

INSERT INTO cliente VALUES ('GoldFish Garden','Daniel G','GoldFish','5556901745','5556901746','False Street 52 2 A',NULL,'San Francisco',NULL,'USA','24006',19,3000);
INSERT INTO cliente VALUES ('Gardening Associates','Anne','Wright','5557410345','5557410346','Wall-e Avenue',NULL,'Miami','Miami','USA','24010',19,6000);
INSERT INTO cliente VALUES ('Gerudo Valley','Link','Flaute','5552323129','5552323128','Oaks Avenue n�22',NULL,'New York',NULL,'USA','85495',22,12000);
INSERT INTO cliente VALUES ('Tendo Garden','Akane','Tendo','55591233210','55591233211','Null Street n�69',NULL,'Miami',NULL,'USA','696969',22,600000);
INSERT INTO cliente VALUES ('Lasas S.A.','Antonio','Lasas','34916540145','34914851312','C/Leganes 15',NULL,'Fuenlabrada','Madrid','Spain','28945',8,154310);
INSERT INTO cliente VALUES ('Beragua','Jose','Bermejo','654987321','916549872','C/pintor segundo','Getafe','Madrid','Madrid','Spain','28942',11,20000);
INSERT INTO cliente VALUES ('Club Golf Puerta del hierro','Paco','Lopez','62456810','919535678','C/sinesio delgado','Madrid','Madrid','Madrid','Spain','28930',11,40000);
INSERT INTO cliente VALUES ('Naturagua','Guillermo','Rengifo','689234750','916428956','C/majadahonda','Boadilla','Madrid','Madrid','Spain','28947',11,32000);
INSERT INTO cliente VALUES ('DaraDistribuciones','David','Serrano','675598001','916421756','C/azores','Fuenlabrada','Madrid','Madrid','Spain','28946',11,50000);
INSERT INTO cliente VALUES ('Madrile�a de riegos','Jose','Taca�o','655983045','916689215','C/Laga�as','Fuenlabrada','Madrid','Madrid','Spain','28943',11,20000);
INSERT INTO cliente VALUES ('Lasas S.A.','Antonio','Lasas','34916540145','34914851312','C/Leganes 15',NULL,'Fuenlabrada','Madrid','Spain','28945',8,154310);
INSERT INTO cliente VALUES ('Camunas Jardines S.L.','Pedro','Camunas','34914873241','34914871541','C/Virgenes 45','C/Princesas 2 1�B','San Lorenzo del Escorial','Madrid','Spain','28145',8,16481);
INSERT INTO cliente VALUES ('Dardena S.A.','Juan','Rodriguez','34912453217','34912484764','C/Nueva York 74',NULL,'Madrid','Madrid','Spain','28003',8,321000);
INSERT INTO cliente VALUES ('Jardin de Flores','Javier','Villar','654865643','914538776','C/ O�a 34',NULL,'Madrid','Madrid','Spain','28950',30,40000);
INSERT INTO cliente VALUES ('Flores Marivi','Maria','Rodriguez','666555444','912458657','C/Leganes24',NULL,'Fuenlabrada','Madrid','Spain','28945',5,1500);
INSERT INTO cliente VALUES ('Flowers, S.A','Beatriz','Fernandez','698754159','978453216','C/Luis Salquillo4',NULL,'Montornes del valles','Barcelona','Spain','24586',5,3500);
INSERT INTO cliente VALUES ('Naturajardin','Victoria','Cruz','612343529','916548735','Plaza Magall�n 15',NULL,'Madrid','Madrid','Spain','28011',30,5050);
INSERT INTO cliente VALUES ('Golf S.A.','Luis','Martinez','916458762','912354475','C/Estancado',NULL,'Santa cruz de Tenerife','Islas Canarias','Spain','38297',12,30000);
INSERT INTO cliente VALUES ('Americh Golf Management SL','Mario','Suarez','964493072','964493063','C/Letardo',NULL,'Barcelona','Catalu�a','Spain','12320',12,20000);
INSERT INTO cliente VALUES ('Aloha','Cristian','Rodrigez','916485852','914489898','C/Roman 3',NULL,'Canarias','Canarias','Spain','35488',12,50000);
INSERT INTO cliente VALUES ('El Prat','Francisco','Camacho','916882323','916493211','Avenida Tibidabo',NULL,'Barcelona','Catalu�a','Spain','12320',12,30000);
INSERT INTO cliente VALUES ('Sotogrande','Maria','Santillana','915576622','914825645','C/Paseo del Parque',NULL,'Sotogrande','Cadiz','Spain','11310',12,60000);
INSERT INTO cliente VALUES ('Vivero Humanes','Federico','Gomez','654987690','916040875','C/Miguel Echegaray 54',NULL,'Humanes','Madrid','Spain','28970',30,7430);
INSERT INTO cliente VALUES ('Fuenla City','Tony','Mu�oz Mena','675842139','915483754','C/Callo 52',NULL,'Fuenlabrada','Madrid','Spain','28574',5,4500);
INSERT INTO cliente VALUES ('Jardines y Mansiones Cactus SL','Eva Mar�a','S�nchez','916877445','914477777','Pol�gono Industrial Maspalomas, N�52','M�stoles','Madrid','Madrid','Spain','29874',9,76000);
INSERT INTO cliente VALUES ('Jardiner�as Mat�as SL','Mat�as','San Mart�n','916544147','917897474','C/Francisco Arce, N�44','Bustarviejo','Madrid','Madrid','Spain','37845',9,100500);
INSERT INTO cliente VALUES ('Agrojardin','Benito','Lopez','675432926','916549264','C/Mar Caspio 43',NULL,'Getafe','Madrid','Spain','28904',30,8040);
INSERT INTO cliente VALUES ('Top Campo','Joseluis','Sanchez','685746512','974315924','C/Ibiza 32',NULL,'Humanes','Madrid','Spain','28574',5,5500);
INSERT INTO cliente VALUES ('Jardineria Sara','Sara','Marquez','675124537','912475843','C/Lima 1',NULL,'Fuenlabrada','Madrid','Spain','27584',5,7500);
INSERT INTO cliente VALUES ('Campohermoso','Luis','Jimenez','645925376','916159116','C/Peru 78',NULL,'Fuenlabrada','Madrid','Spain','28945',30,3250);
INSERT INTO cliente VALUES ('france telecom','Fraçois','Toulou','(33)5120578961','(33)5120578961','6 place d Alleray 15ème',NULL,'Paris',NULL,'France','75010',16,10000);
INSERT INTO cliente VALUES ('Mus�e du Louvre','Pierre','Delacroux','(33)0140205050','(33)0140205442','Quai du Louvre',NULL,'Paris',NULL,'France','75058',16,30000);
INSERT INTO cliente VALUES ('Tutifruti S.A','Jacob','Jones','2 9261-2433','2 9283-1695','level 24, St. Martins Tower.-31 Market St.',NULL,'Sydney','Nueva Gales del Sur','Australia','2000',31,10000);
INSERT INTO cliente VALUES ('Flores S.L.','Antonio','Romero','654352981','685249700','Avenida Espa�a',NULL,'Madrid','Fuenlabrada','Spain','29643',18,6000);
INSERT INTO cliente VALUES ('The Magic Garden','Richard','Mcain','926523468','9364875882','Lihgting Park',NULL,'London','London','United Kingdom','65930',18,10000);
INSERT INTO cliente VALUES ('El Jardin Viviente S.L','Justin','Smith','2 8005-7161','2 8005-7162','176 Cumberland Street The rocks',NULL,'Sydney','Nueva Gales del Sur','Australia','2003',31,8000);

INSERT INTO pedido VALUES ('2006-01-17','2006-01-19','2006-01-19','Entregado','Pagado a plazos',5);
INSERT INTO pedido VALUES ('2007-10-23','2007-10-28','2007-10-26','Entregado','La entrega llego antes de lo esperado',5);
INSERT INTO pedido VALUES ('2008-06-20','2008-06-25',NULL,'Rechazado','Limite de credito superado',5);
INSERT INTO pedido VALUES ('2009-01-20','2009-01-26',NULL,'Pendiente',NULL,5);
INSERT INTO pedido VALUES ('2008-11-09','2008-11-14','2008-11-14','Entregado','El cliente paga la mitad con tarjeta y la otra mitad con efectivo, se le realizan dos facturas',1);
INSERT INTO pedido VALUES ('2008-12-22','2008-12-27','2008-12-28','Entregado','El cliente comprueba la integridad del paquete, todo correcto',1);
INSERT INTO pedido VALUES ('2009-01-15','2009-01-20',NULL,'Pendiente','El cliente llama para confirmar la fecha - Esperando al proveedor',3);
INSERT INTO pedido VALUES ('2009-01-20','2009-01-27',NULL,'Pendiente','El cliente requiere que el pedido se le entregue de 16:00h a 22:00h',1);
INSERT INTO pedido VALUES ('2009-01-22','2009-01-27',NULL,'Pendiente','El cliente requiere que el pedido se le entregue de 9:00h a 13:00h',1);
INSERT INTO pedido VALUES ('2009-01-12','2009-01-14','2009-01-15','Entregado',NULL,7);
INSERT INTO pedido VALUES ('2009-01-02','2009-01-02',null,'Rechazado','mal pago',7);
INSERT INTO pedido VALUES ('2009-01-09','2009-01-12','2009-01-11','Entregado',NULL,7);
INSERT INTO pedido VALUES ('2009-01-06','2009-01-07','2009-01-15','Entregado',NULL,7);
INSERT INTO pedido VALUES ('2009-01-08','2009-01-09','2009-01-11','Entregado','mal estado',7);
INSERT INTO pedido VALUES ('2009-01-05','2009-01-06','2009-01-07','Entregado',NULL,9);
INSERT INTO pedido VALUES ('2009-01-18','2009-02-12',NULL,'Pendiente','entregar en murcia',9);
INSERT INTO pedido VALUES ('2009-01-20','2009-02-15',NULL,'Pendiente',NULL,9);
INSERT INTO pedido VALUES ('2009-01-09','2009-01-09','2009-01-09','Rechazado','mal pago',9);
INSERT INTO pedido VALUES ('2009-01-11','2009-01-11','2009-01-13','Entregado',NULL,9);
INSERT INTO pedido VALUES ('2008-12-30','2009-01-10',NULL,'Rechazado','El pedido fue anulado por el cliente',5);
INSERT INTO pedido VALUES ('2008-07-14','2008-07-31','2008-07-25','Entregado',NULL,14);
INSERT INTO pedido VALUES ('2009-02-02','2009-02-08',NULL,'Rechazado','El cliente carece de saldo en la cuenta asociada',1);
INSERT INTO pedido VALUES ('2009-02-06','2009-02-12',NULL,'Rechazado','El cliente anula la operacion para adquirir mas producto',3);
INSERT INTO pedido VALUES ('2009-02-07','2009-02-13',NULL,'Entregado','El pedido aparece como entregado pero no sabemos en que fecha',3);
INSERT INTO pedido VALUES ('2009-02-10','2009-02-17','2009-02-20','Entregado','El cliente se queja bastante de la espera asociada al producto',3);
INSERT INTO pedido VALUES ('2008-08-01','2008-09-01','2008-09-01','Rechazado','El cliente no est� conforme con el pedido',14);
INSERT INTO pedido VALUES ('2008-08-03','2008-09-03','2008-08-31','Entregado',NULL,13);
INSERT INTO pedido VALUES ('2008-09-04','2008-09-30','2008-10-04','Rechazado','El cliente ha rechazado por llegar 5 dias tarde',13);
INSERT INTO pedido VALUES ('2007-01-07','2007-01-19','2007-01-27','Entregado','Entrega tardia, el cliente puso reclamacion',4);
INSERT INTO pedido VALUES ('2007-05-20','2007-05-28',NULL,'Rechazado','El pedido fue anulado por el cliente',4);
INSERT INTO pedido VALUES ('2007-06-20','2008-06-28','2008-06-28','Entregado','Pagado a plazos',4);
INSERT INTO pedido VALUES ('2008-03-10','2009-03-20',NULL,'Rechazado','Limite de credito superado',4);
INSERT INTO pedido VALUES ('2008-10-15','2008-12-15','2008-12-10','Entregado',NULL,14);
INSERT INTO pedido VALUES ('2008-11-03','2009-11-13',NULL,'Pendiente','El pedido nunca llego a su destino',4);
INSERT INTO pedido VALUES ('2009-03-05','2009-03-06','2009-03-07','Entregado',NULL,19);
INSERT INTO pedido VALUES ('2009-03-06','2009-03-07','2009-03-09','Pendiente',NULL,19);
INSERT INTO pedido VALUES ('2009-03-09','2009-03-10','2009-03-13','Rechazado',NULL,19);
INSERT INTO pedido VALUES ('2009-03-12','2009-03-13','2009-03-13','Entregado',NULL,19);
INSERT INTO pedido VALUES ('2009-03-22','2009-03-23','2009-03-27','Entregado',NULL,19);
INSERT INTO pedido VALUES ('2009-03-25','2009-03-26','2009-03-28','Pendiente',NULL,23);
INSERT INTO pedido VALUES ('2009-03-26','2009-03-27','2009-03-30','Pendiente',NULL,23);
INSERT INTO pedido VALUES ('2009-04-01','2009-03-04','2009-03-07','Entregado',NULL,23);
INSERT INTO pedido VALUES ('2009-04-03','2009-03-04','2009-03-05','Rechazado',NULL,23);
INSERT INTO pedido VALUES ('2009-04-15','2009-03-17','2009-03-17','Entregado',NULL,23);
INSERT INTO pedido VALUES ('2008-03-17','2008-03-30','2008-03-29','Entregado','Seg�n el Cliente, el pedido lleg� defectuoso',26);
INSERT INTO pedido VALUES ('2008-07-12','2008-07-22','2008-07-30','Entregado','El pedido lleg� 1 d�a tarde, pero no hubo queja por parte de la empresa compradora',26);
INSERT INTO pedido VALUES ('2008-03-17','2008-08-09',NULL,'Pendiente','Al parecer, el pedido se ha extraviado a la altura de Sotalbo (�vila)',26);
INSERT INTO pedido VALUES ('2008-10-01','2008-10-14','2008-10-14','Entregado','Todo se entreg� a tiempo y en perfecto estado, a pesar del p�simo estado de las carreteras.',26);
INSERT INTO pedido VALUES ('2008-12-07','2008-12-21',NULL,'Pendiente','El transportista ha llamado a Eva Mar�a para indicarle que el pedido llegar� m�s tarde de lo esperado.',26);
INSERT INTO pedido VALUES ('2008-10-15','2008-11-15','2008-11-09','Entregado','El pedido llega 6 dias antes',13);
INSERT INTO pedido VALUES ('2009-01-11','2009-02-11',NULL,'Pendiente',NULL,14);
INSERT INTO pedido VALUES ('2008-12-10','2009-01-10','2009-01-11','Entregado','Retrasado 1 dia por problemas de transporte',14);
INSERT INTO pedido VALUES ('2008-12-19','2009-01-20',NULL,'Rechazado','El cliente a anulado el pedido el dia 2009-01-10',13);
INSERT INTO pedido VALUES ('2009-01-05','2009-02-05',NULL,'Pendiente',NULL,13);
INSERT INTO pedido VALUES ('2009-01-24','2009-01-31','2009-01-30','Entregado','Todo correcto',3);
INSERT INTO pedido VALUES ('2008-11-09','2008-11-14','2008-11-14','Entregado','El cliente paga la mitad con tarjeta y la otra mitad con efectivo, se le realizan dos facturas',1);
INSERT INTO pedido VALUES ('2008-12-22','2008-12-27','2008-12-28','Entregado','El cliente comprueba la integridad del paquete, todo correcto',1);
INSERT INTO pedido VALUES ('2009-01-15','2009-01-20',NULL,'Pendiente','El cliente llama para confirmar la fecha - Esperando al proveedor',3);
INSERT INTO pedido VALUES ('2009-01-20','2009-01-27',NULL,'Pendiente','El cliente requiere que el pedido se le entregue de 16:00h a 22:00h',1);
INSERT INTO pedido VALUES ('2009-01-22','2009-01-27',NULL,'Pendiente','El cliente requiere que el pedido se le entregue de 9:00h a 13:00h',1);
INSERT INTO pedido VALUES ('2009-01-24','2009-01-31','2009-01-30','Entregado','Todo correcto',1);
INSERT INTO pedido VALUES ('2009-02-02','2009-02-08',NULL,'Rechazado','El cliente carece de saldo en la cuenta asociada',1);
INSERT INTO pedido VALUES ('2009-02-06','2009-02-12',NULL,'Rechazado','El cliente anula la operacion para adquirir mas producto',3);
INSERT INTO pedido VALUES ('2009-02-07','2009-02-13',NULL,'Entregado','El pedido aparece como entregado pero no sabemos en que fecha',3);
INSERT INTO pedido VALUES ('2009-02-10','2009-02-17','2009-02-20','Entregado','El cliente se queja bastante de la espera asociada al producto',3);
INSERT INTO pedido VALUES ('2009-01-14','2009-01-22',NULL,'Rechazado','El pedido no llego el dia que queria el cliente por fallo del transporte',15);
INSERT INTO pedido VALUES ('2009-01-11','2009-01-13','2009-01-13','Entregado','El pedido llego perfectamente',15);
INSERT INTO pedido VALUES ('2008-11-15','2008-11-23','2008-11-23','Entregado',NULL,15);
INSERT INTO pedido VALUES ('2009-01-03','2009-01-08',NULL,'Pendiente','El pedido no pudo ser entregado por problemas meteorologicos',15);
INSERT INTO pedido VALUES ('2008-12-15','2008-12-17','2008-12-17','Entregado','Fue entregado, pero faltaba mercancia que sera entregada otro dia',15);
INSERT INTO pedido VALUES ('2009-01-12','2009-01-13','2009-01-13','Entregado',NULL,28);
INSERT INTO pedido VALUES ('2009-01-25','2009-01-26',NULL,'Pendiente','No termin� el pago',28);
INSERT INTO pedido VALUES ('2009-01-18','2009-01-24',NULL,'Rechazado','Los producto estaban en mal estado',28);
INSERT INTO pedido VALUES ('2009-01-20','2009-01-29','2009-01-29','Entregado','El pedido llego un poco mas tarde de la hora fijada',28);
INSERT INTO pedido VALUES ('2009-01-24','2009-01-28',NULL,'Entregado',NULL,28);
INSERT INTO pedido VALUES ('2007-10-05','2007-12-13','2007-12-10','Entregado','La entrega se realizo dias antes de la fecha esperada por lo que el cliente quedo satisfecho',35);
INSERT INTO pedido VALUES ('2009-02-07','2008-02-17',NULL,'Pendiente','Debido a la nevada ca�da en la sierra, el pedido no podr� llegar hasta el d�a ',27);
INSERT INTO pedido VALUES ('2009-03-18','2009-03-29','2009-03-27','Entregado','Todo se entreg� a su debido tiempo, incluso con un d�a de antelaci�n',27);
INSERT INTO pedido VALUES ('2009-04-19','2009-04-30','2009-05-03','Entregado','El pedido se entreg� tarde debido a la festividad celebrada en Espa�a durante esas fechas',27);
INSERT INTO pedido VALUES ('2009-05-03','2009-05-30','2009-05-17','Entregado','El pedido se entreg� antes de lo esperado.',27);
INSERT INTO pedido VALUES ('2009-10-18','2009-11-01',NULL,'Pendiente','El pedido est� en camino.',27);
INSERT INTO pedido VALUES ('2008-01-04','2008-01-19','2008-01-19','Entregado',NULL,35);
INSERT INTO pedido VALUES ('2008-03-20','2008-04-12','2008-04-13','Entregado','La entrega se retraso un dia',35);
INSERT INTO pedido VALUES ('2008-10-08','2008-11-25','2008-11-25','Entregado',NULL,35);
INSERT INTO pedido VALUES ('2009-01-08','2009-02-13',NULL,'Pendiente',NULL,35);
INSERT INTO pedido VALUES ('2009-02-15','2009-02-27',NULL,'Pendiente',NULL,16);
INSERT INTO pedido VALUES ('2009-01-10','2009-01-15','2009-01-15','Entregado','El pedido llego perfectamente',16);
INSERT INTO pedido VALUES ('2009-03-07','2009-03-27',NULL,'Rechazado','El pedido fue rechazado por el cliente',16);
INSERT INTO pedido VALUES ('2008-12-28','2009-01-08','2009-01-08','Entregado','Pago pendiente',16);
INSERT INTO pedido VALUES ('2009-01-15','2009-01-20','2009-01-24','Pendiente',NULL,30);
INSERT INTO pedido VALUES ('2009-03-02','2009-03-06','2009-03-06','Entregado',NULL,30);
INSERT INTO pedido VALUES ('2009-02-14','2009-02-20',NULL,'Rechazado','el producto ha sido rechazado por la pesima calidad',30);
INSERT INTO pedido VALUES ('2009-05-13','2009-05-15','2009-05-20','Pendiente',NULL,30);
INSERT INTO pedido VALUES ('2009-04-06','2009-04-10','2009-04-10','Entregado',NULL,30);
INSERT INTO pedido VALUES ('2009-04-09','2009-04-15','2009-04-15','Entregado',NULL,16);
INSERT INTO pedido VALUES ('2006-05-25','2006-07-28','2006-07-28','Entregado',NULL,36);
INSERT INTO pedido VALUES ('2007-03-19','2007-04-24','2007-04-24','Entregado',NULL,36);
INSERT INTO pedido VALUES ('2008-03-05','2008-03-30','2008-03-30','Entregado',NULL,36);
INSERT INTO pedido VALUES ('2009-03-05','2009-04-06','2009-05-07','Pendiente',NULL,36);
INSERT INTO pedido VALUES ('2008-10-28','2008-11-09','2009-01-09','Rechazado','El producto ha sido rechazado por la tardanza de el envio',36);
INSERT INTO pedido VALUES ('2009-01-15','2009-01-29','2009-01-31','Entregado','El envio llego dos dias m�s tarde debido al mal tiempo',36);
INSERT INTO pedido VALUES ('2008-11-29','2009-01-26','2009-02-27','Pendiente',NULL,36);
INSERT INTO pedido VALUES ('2008-06-28','2008-08-01','2008-08-01','Entregado',NULL,35);
INSERT INTO pedido VALUES ('2008-08-25','2008-10-01',NULL,'Rechazado','El pedido ha sido rechazado por la acumulacion de pago pendientes del cliente',32);
INSERT INTO pedido VALUES ('2009-02-15','2009-02-27',NULL,'Pendiente',NULL,16);
INSERT INTO pedido VALUES ('2009-01-10','2009-01-15','2009-01-15','Entregado','El pedido llego perfectamente',16);
INSERT INTO pedido VALUES ('2009-03-07','2009-03-27',NULL,'Rechazado','El pedido fue rechazado por el cliente',16);
INSERT INTO pedido VALUES ('2008-12-28','2009-01-08','2009-01-08','Entregado','Pago pendiente',16);
INSERT INTO pedido VALUES ('2009-04-09','2009-04-15','2009-04-15','Entregado',NULL,16);
INSERT INTO pedido VALUES ('2009-01-15','2009-01-20','2009-01-24','Pendiente',NULL,30);
INSERT INTO pedido VALUES ('2009-03-02','2009-03-06','2009-03-06','Entregado',NULL,30);
INSERT INTO pedido VALUES ('2009-02-14','2009-02-20',NULL,'Rechazado','el producto ha sido rechazado por la pesima calidad',30);
INSERT INTO pedido VALUES ('2009-05-13','2009-05-15','2009-05-20','Pendiente',NULL,30);
INSERT INTO pedido VALUES ('2009-04-06','2009-04-10','2009-04-10','Entregado',NULL,30);
INSERT INTO pedido VALUES ('2008-11-10','2008-12-10','2008-12-29','Rechazado','El pedido ha sido rechazado por el cliente por el retraso en la entrega',36);

INSERT INTO producto VALUES ('11679','Sierra de Poda 400MM',2,'0,258','HiperGarden Tools','Gracias a la poda se consigue manipular un poco la naturaleza, d�ndole la forma que m�s nos guste. Este trabajo b�sico de jardiner�a tambi�n facilita que las plantas crezcan de un modo m�s equilibrado, y que las flores y los frutos vuelvan cada a�o con regularidad. Lo mejor es dar forma cuando los ejemplares son j�venes, de modo que exijan pocos cuidados cuando sean adultos. Adem�s de saber cu�ndo y c�mo hay que podar, tener unas 2 adecuadas para esta labor es tambi�n de vital importancia.',15,14,11);
INSERT INTO producto VALUES ('21636','Pala',2,'0,156','HiperGarden Tools','Palas de acero con cresta de corte en la punta para cortar bien el terreno. Buena penetraci�n en tierras muy compactas.',15,14,13);
INSERT INTO producto VALUES ('22225','Rastrillo de Jard�n',2,'1,064','HiperGarden Tools','Fabuloso rastillo que le ayudar� a eliminar piedras, hojas, ramas y otros elementos inc�modos en su jard�n.',15,12,11);
INSERT INTO producto VALUES ('30310','Azad�n',2,'0,168','HiperGarden Tools','Longitud:24cm. Herramienta fabricada en acero y pintura epoxi,alargando su durabilidad y preveniendo la corrosi�n.Dise�o pensado para el ahorro de trabajo.',15,12,11);
INSERT INTO producto VALUES ('AR-001','Ajedrea',3,'15-20','Murcia Seasons','Planta arom�tica que fresca se utiliza para condimentar carnes y ensaladas, y seca, para pastas, sopas y guisantes',140,1,0);
INSERT INTO producto VALUES ('AR-002','Lav�ndula Dentata',3,'15-20','Murcia Seasons','Espliego de jard�n, Alhucema rizada, Alhucema dentada, Cantueso rizado. Familia: Lamiaceae.Origen: Espa�a y Portugal. Mata de unos 60 cm de alto. Las hojas son arom�ticas, dentadas y de color verde gris�ceas.  Produce compactas espigas de flores peque�as, ligeramente arom�ticas, tubulares,de color azulado y con br�cteas p�rpuras.  Frutos: nuececillas alargadas encerradas en el tubo del c�liz.  Se utiliza en jardineria y no en perfumeria como otros cantuesos, espliegos y lavandas.  Tiene propiedades aromatizantes y calmantes. Adecuadas para la formaci�n de setos bajos. Se dice que su aroma ahuyenta pulgones y otros insectos perjudiciales para las plantas vecinas.',140,1,0);
INSERT INTO producto VALUES ('AR-003','Mejorana',3,'15-20','Murcia Seasons','Origanum majorana. No hay que confundirlo con el or�gano. Su sabor se parece m�s al tomillo, pero es m�s dulce y arom�tico.Se usan las hojas frescas o secas, picadas, machacadas o en polvo, en sopas, rellenos, quiches y tartas, tortillas, platos con papas y, como aderezo, en ramilletes de hierbas.El sabor delicado de la mejorana se elimina durante la cocci�n, de manera que es mejor agregarla cuando el plato est� en su punto o en aqu�llos que apenas necesitan cocci�n.',140,1,0);
INSERT INTO producto VALUES ('AR-004','Melissa ',3,'15-20','Murcia Seasons','Es una planta perenne (dura varios a�os) conocida por el agradable y caracter�stico olor a lim�n que desprenden en verano. Nunca debe faltar en la huerta o jard�n por su agradable aroma y por los variados usos que tiene: planta olorosa, condimentaria y medicinal. Su cultivo es muy f�cil. Le va bien un suelo ligero, con buen drenaje y riego sin exceso. A pleno sol o por lo menos 5 horas de sol por d�a. Cada a�o, su abonado mineral correspondiente.En oto�o, la melisa pierde el agradable olor a lim�n que desprende en verano sus flores azules y blancas. En este momento se debe cortar a unos 20 cm. del suelo. Brotar� de forma densa en primavera.',140,1,0);
INSERT INTO producto VALUES ('AR-005','Mentha Sativa',3,'15-20','Murcia Seasons','�Qui�n no conoce la Hierbabuena? Se trata de una plantita muy arom�tica, agradable y cultivada extensamente por toda Espa�a. Es hierba perenne (por tanto vive varios a�os, no es anual). Puedes cultivarla en maceta o plantarla en la tierra del jard�n o en un rinc�n del huerto. Lo m�s importante es que cuente con bastante agua. En primavera debes aportar fertilizantes minerales. Vive mejor en semisombra que a pleno sol.Si ves orugas o los agujeros en hojas consecuencia de su ataque, ret�ralas una a una a mano; no uses insecticidas qu�micos.',140,1,0);
INSERT INTO producto VALUES ('AR-006','Petrosilium Hortense (Peregil)',3,'15-20','Murcia Seasons','Nombre cient�fico o latino: Petroselinum hortense, Petroselinum crispum. Nombre com�n o vulgar: Perejil, Perejil rizado Familia: Umbelliferae (Umbel�feras). Origen: el origen del perejil se encuentra en el Mediterraneo. Esta naturalizada en casi toda Europa. Se utiliza como condimento y para adorno, pero tambi�n en ensaladas. Se suele regalar en las fruter�as y verduler�as.El perejil lo hay de 2 tipos: de hojas planas y de hojas rizadas.',140,1,0);
INSERT INTO producto VALUES ('AR-007','Salvia Mix',3,'15-20','Murcia Seasons','La Salvia es un peque�o arbusto que llega hasta el metro de alto.Tiene una vida breve, de unos pocos a�os.En el jard�n, como otras arom�ticas, queda muy bien en una rocalla o para hacer una bordura perfumada a cada lado de un camino de Salvia. Abona despu�s de cada corte y recorta el arbusto una vez pase la floraci�n.',140,1,0);
INSERT INTO producto VALUES ('AR-008','Thymus Citriodra (Tomillo lim�n)',3,'15-20','Murcia Seasons','Nombre com�n o vulgar: Tomillo, Tremoncillo Familia: Labiatae (Labiadas).Origen: Regi�n mediterr�nea.Arbustillo bajo, de 15 a 40 cm de altura. Las hojas son muy peque�as, de unos 6 mm de longitud; seg�n la variedad pueden ser verdes, verdes gris�ceas, amarillas, o jaspeadas. Las flores aparecen de mediados de primavera hasta bien entrada la �poca estival y se presentan en racimos terminales que habitualmente son de color violeta o p�rpura aunque tambi�n pueden ser blancas. Esta planta despide un intenso y t�pico aroma, que se incrementa con el roce. El tomillo resulta de gran belleza cuando est� en flor. El tomillo atrae a avispas y abejas. En jardiner�a se usa como manchas, para hacer borduras, para aromatizar el ambiente, llenar huecos, cubrir rocas, para jardines en miniatura, etc. Arranque las flores y hojas secas del tallo y a�ad�los a un popurri, introd�zcalos en saquitos de hierbas o en la almohada.Tambi�n puede usar las ramas secas con flores para a�adir aroma y textura a cestos abiertos.',140,1,0);
INSERT INTO producto VALUES ('AR-009','Thymus Vulgaris',3,'15-20','Murcia Seasons','Nombre com�n o vulgar: Tomillo, Tremoncillo Familia: Labiatae (Labiadas). Origen: Regi�n mediterr�nea. Arbustillo bajo, de 15 a 40 cm de altura. Las hojas son muy peque�as, de unos 6 mm de longitud; seg�n la variedad pueden ser verdes, verdes gris�ceas, amarillas, o jaspeadas. Las flores aparecen de mediados de primavera hasta bien entrada la �poca estival y se presentan en racimos terminales que habitualmente son de color violeta o p�rpura aunque tambi�n pueden ser blancas. Esta planta despide un intenso y t�pico aroma, que se incrementa con el roce. El tomillo resulta de gran belleza cuando est� en flor. El tomillo atrae a avispas y abejas.\r\n En jardiner�a se usa como manchas, para hacer borduras, para aromatizar el ambiente, llenar huecos, cubrir rocas, para jardines en miniatura, etc. Arranque las flores y hojas secas del tallo y a�ad�los a un popurri, introd�zcalos en saquitos de hierbas o en la almohada. Tambi�n puede usar las ramas secas con flores para a�adir aroma y textura a cestos abiertos.',140,1,0);
INSERT INTO producto VALUES ('AR-010','Santolina Chamaecyparys',3,'15-20','Murcia Seasons','',140,1,0);
INSERT INTO producto VALUES ('FR-1','Expositor C�tricos Mix',4,'100-120','Frutales Talavera S.A','',15,7,5);
INSERT INTO producto VALUES ('FR-10','Limonero 2 a�os injerto',4,'','NaranjasValencianas.com','El limonero, pertenece al grupo de los c�tricos, teniendo su origen hace unos 20 millones de a�os en el sudeste asi�tico. Fue introducido por los �rabes en el �rea mediterr�nea entre los a�os 1.000 a 1.200, habiendo experimentando numerosas modificaciones debidas tanto a la selecci�n natural mediante hibridaciones espont�neas como a las producidas por el hombre, en este caso buscando las necesidades del mercado.',15,7,5);
INSERT INTO producto VALUES ('FR-100','Nectarina',4,'8/10','Frutales Talavera S.A','Se trata de un �rbol derivado por mutaci�n de los melocotoneros comunes, y los �nicos caracteres diferenciales son la ausencia de tomentosidad en la piel del fruto. La planta, si se deja crecer libremente, adopta un porte globoso con unas dimensiones medias de 4-6 metros',50,11,8);
INSERT INTO producto VALUES ('FR-101','Nogal',4,'8/10','Frutales Talavera S.A','',50,13,10);
INSERT INTO producto VALUES ('FR-102','Olea-Olivos',4,'8/10','Frutales Talavera S.A','Existen dos hip�tesis sobre el origen del olivo, una que postula que proviene de las costas de Siria, L�bano e Israel y otra que considera que lo considera originario de Asia menor. La llegada a Europa probablemente tuvo lugar de mano de los Fenicios, en transito por Chipre, Creta, e Islas del Mar Egeo, pasando a Grecia y m�s tarde a Italia. Los primeros indicios de la presencia del olivo en las costas mediterr�neas espa�olas coinciden con el dominio romano, aunque fueron posteriormente los �rabes los que impulsaron su cultivo en Andaluc�a, convirtiendo a Espa�a en el primer pa�s productor de aceite de oliva a nivel mundial.',50,18,14);
INSERT INTO producto VALUES ('FR-103','Olea-Olivos',4,'10/12','Frutales Talavera S.A','Existen dos hip�tesis sobre el origen del olivo, una que postula que proviene de las costas de Siria, L�bano e Israel y otra que considera que lo considera originario de Asia menor. La llegada a Europa probablemente tuvo lugar de mano de los Fenicios, en transito por Chipre, Creta, e Islas del Mar Egeo, pasando a Grecia y m�s tarde a Italia. Los primeros indicios de la presencia del olivo en las costas mediterr�neas espa�olas coinciden con el dominio romano, aunque fueron posteriormente los �rabes los que impulsaron su cultivo en Andaluc�a, convirtiendo a Espa�a en el primer pa�s productor de aceite de oliva a nivel mundial.',50,25,20);
INSERT INTO producto VALUES ('FR-104','Olea-Olivos',4,'12/4','Frutales Talavera S.A','Existen dos hip�tesis sobre el origen del olivo, una que postula que proviene de las costas de Siria, L�bano e Israel y otra que considera que lo considera originario de Asia menor. La llegada a Europa probablemente tuvo lugar de mano de los Fenicios, en transito por Chipre, Creta, e Islas del Mar Egeo, pasando a Grecia y m�s tarde a Italia. Los primeros indicios de la presencia del olivo en las costas mediterr�neas espa�olas coinciden con el dominio romano, aunque fueron posteriormente los �rabes los que impulsaron su cultivo en Andaluc�a, convirtiendo a Espa�a en el primer pa�s productor de aceite de oliva a nivel mundial.',50,49,39);
INSERT INTO producto VALUES ('FR-105','Olea-Olivos',4,'14/16','Frutales Talavera S.A','Existen dos hip�tesis sobre el origen del olivo, una que postula que proviene de las costas de Siria, L�bano e Israel y otra que considera que lo considera originario de Asia menor. La llegada a Europa probablemente tuvo lugar de mano de los Fenicios, en transito por Chipre, Creta, e Islas del Mar Egeo, pasando a Grecia y m�s tarde a Italia. Los primeros indicios de la presencia del olivo en las costas mediterr�neas espa�olas coinciden con el dominio romano, aunque fueron posteriormente los �rabes los que impulsaron su cultivo en Andaluc�a, convirtiendo a Espa�a en el primer pa�s productor de aceite de oliva a nivel mundial.',50,70,56);
INSERT INTO producto VALUES ('FR-106','Peral',4,'8/10','Frutales Talavera S.A','�rbol piramidal, redondeado en su juventud, luego oval, que llega hasta 20 metros de altura y por t�rmino medio vive 65 a�os.Tronco alto, grueso, de corteza agrietada, gris, de la cual se destacan con frecuencia placas lenticulares.Las ramas se insertan formando �ngulo agudo con el tronco (45�), de corteza lisa, primero verde y luego gris-viol�cea, con numerosas lenticelas.',50,11,8);
INSERT INTO producto VALUES ('FR-107','Peral',4,'10/12','Frutales Talavera S.A','�rbol piramidal, redondeado en su juventud, luego oval, que llega hasta 20 metros de altura y por t�rmino medio vive 65 a�os.Tronco alto, grueso, de corteza agrietada, gris, de la cual se destacan con frecuencia placas lenticulares.Las ramas se insertan formando �ngulo agudo con el tronco (45�), de corteza lisa, primero verde y luego gris-viol�cea, con numerosas lenticelas.',50,22,17);
INSERT INTO producto VALUES ('FR-108','Peral',4,'12/14','Frutales Talavera S.A','�rbol piramidal, redondeado en su juventud, luego oval, que llega hasta 20 metros de altura y por t�rmino medio vive 65 a�os.Tronco alto, grueso, de corteza agrietada, gris, de la cual se destacan con frecuencia placas lenticulares.Las ramas se insertan formando �ngulo agudo con el tronco (45�), de corteza lisa, primero verde y luego gris-viol�cea, con numerosas lenticelas.',50,32,25);
INSERT INTO producto VALUES ('FR-11','Limonero 30/40',4,'','NaranjasValencianas.com','El limonero, pertenece al grupo de los c�tricos, teniendo su origen hace unos 20 millones de a�os en el sudeste asi�tico. Fue introducido por los �rabes en el �rea mediterr�nea entre los a�os 1.000 a 1.200, habiendo experimentando numerosas modificaciones debidas tanto a la selecci�n natural mediante hibridaciones espont�neas como a las producidas por el',15,100,80);
INSERT INTO producto VALUES ('FR-12','Kunquat ',4,'','NaranjasValencianas.com','su nombre cient�fico se origina en honor a un hoticultor escoc�s que recolect� espec�menes en China, (\"Fortunella\"), Robert Fortune (1812-1880), y \"margarita\", del lat�n margaritus-a-um = perla, en alusi�n a sus peque�os y brillantes frutos. Se trata de un arbusto o �rbol peque�o de 2-3 m de altura, inerme o con escasas espinas.Hojas lanceoladas de 4-8 (-15) cm de longitud, con el �pice redondeado y la base cuneada.Tienen el margen crenulado en su mitad superior, el haz verde brillante y el env�s m�s p�lido.Pec�olo ligeramente marginado.Flores perfumadas solitarias o agrupadas en inflorescencias axilares, blancas.El fruto es lo m�s caracter�stico, es el m�s peque�o de todos los c�tricos y el �nico cuya c�scara se puede comer.Frutos peque�os, con semillas, de corteza fina, dulce, arom�tica y comestible, y de pulpa naranja amarillenta y ligeramente �cida.Sus frutos son muy peque�os y tienen un car�cter principalmente ornamental.',15,21,16);
INSERT INTO producto VALUES ('FR-13','Kunquat  EXTRA con FRUTA',4,'150-170','NaranjasValencianas.com','su nombre cient�fico se origina en honor a un hoticultor escoc�s que recolect� espec�menes en China, (\"Fortunella\"), Robert Fortune (1812-1880), y \"margarita\", del lat�n margaritus-a-um = perla, en alusi�n a sus peque�os y brillantes frutos. Se trata de un arbusto o �rbol peque�o de 2-3 m de altura, inerme o con escasas espinas.Hojas lanceoladas de 4-8 (-15) cm de longitud, con el �pice redondeado y la base cuneada.Tienen el margen crenulado en su mitad superior, el haz verde brillante y el env�s m�s p�lido.Pec�olo ligeramente marginado.Flores perfumadas solitarias o agrupadas en inflorescencias axilares, blancas.El fruto es lo m�s caracter�stico, es el m�s peque�o de todos los c�tricos y el �nico cuya c�scara se puede comer.Frutos peque�os, con semillas, de corteza fina, dulce, arom�tica y comestible, y de pulpa naranja amarillenta y ligeramente �cida.Sus frutos son muy peque�os y tienen un car�cter principalmente ornamental.',15,57,45);
INSERT INTO producto VALUES ('FR-14','Calamondin Mini',4,'','Frutales Talavera S.A','Se trata de un peque�o arbolito de copa densa, con tendencia a la verticalidad, inerme o con cortas espinas. Sus hojas son peque�as, el�pticas de 5-10 cm de longitud, con los pec�olos estrechamente alados.Posee 1 o 2 flores en situaci�n axilar, al final de las ramillas.Sus frutos son muy peque�os (3-3,5 cm de di�metro), con pocas semillas, esf�ricos u ovales, con la zona apical aplanada; corteza de color naranja-rojizo, muy fina y f�cilmente separable de la pulpa, que es dulce, �cida y comestible..',15,10,8);
INSERT INTO producto VALUES ('FR-15','Calamondin Copa ',4,'','Frutales Talavera S.A','Se trata de un peque�o arbolito de copa densa, con tendencia a la verticalidad, inerme o con cortas espinas. Sus hojas son peque�as, el�pticas de 5-10 cm de longitud, con los pec�olos estrechamente alados.Posee 1 o 2 flores en situaci�n axilar, al final de las ramillas.Sus frutos son muy peque�os (3-3,5 cm de di�metro), con pocas semillas, esf�ricos u ovales, con la zona apical aplanada; corteza de color naranja-rojizo, muy fina y f�cilmente separable de la pulpa, que es dulce, �cida y comestible..',15,25,20);
INSERT INTO producto VALUES ('FR-16','Calamondin Copa EXTRA Con FRUTA',4,'100-120','Frutales Talavera S.A','Se trata de un peque�o arbolito de copa densa, con tendencia a la verticalidad, inerme o con cortas espinas. Sus hojas son peque�as, el�pticas de 5-10 cm de longitud, con los pec�olos estrechamente alados.Posee 1 o 2 flores en situaci�n axilar, al final de las ramillas.Sus frutos son muy peque�os (3-3,5 cm de di�metro), con pocas semillas, esf�ricos u ovales, con la zona apical aplanada; corteza de color naranja-rojizo, muy fina y f�cilmente separable de la pulpa, que es dulce, �cida y comestible..',15,45,36);
INSERT INTO producto VALUES ('FR-17','Rosal bajo 1ª -En maceta-inicio brotaci�n',4,'','Frutales Talavera S.A','',15,2,1);
INSERT INTO producto VALUES ('FR-18','ROSAL TREPADOR',4,'','Frutales Talavera S.A','',350,4,3);
INSERT INTO producto VALUES ('FR-19','Camelia Blanco, Chrysler Rojo, Soraya Naranja, ',4,'','NaranjasValencianas.com','',350,4,3);
INSERT INTO producto VALUES ('FR-2','Naranjo -Plant�n joven 1 a�o injerto',4,'','NaranjasValencianas.com','El naranjo es un �rbol peque�o, que no supera los 3-5 metros de altura, con una copa compacta, c�nica, transformada en es�rica gracias a la poda. Su tronco es de color gris y liso, y las hojas son perennes, cori�ceas, de un verde intenso y brillante, con forma oval o el�ptico-lanceolada. Poseen, en el caso del naranjo amargo, un t�pico peciolo alado en forma de coraz�n, que en el naranjo dulce es m�s estrecho y menos patente.',15,6,4);
INSERT INTO producto VALUES ('FR-20','Landora Amarillo, Rose Gaujard bicolor blanco-rojo',4,'','Frutales Talavera S.A','',350,4,3);
INSERT INTO producto VALUES ('FR-21','Kordes Perfect bicolor rojo-amarillo, Roundelay rojo fuerte',4,'','Frutales Talavera S.A','',350,4,3);
INSERT INTO producto VALUES ('FR-22','Pitimini rojo',4,'','Frutales Talavera S.A','',350,4,3);
INSERT INTO producto VALUES ('FR-23','Rosal copa ',4,'','Frutales Talavera S.A','',400,8,6);
INSERT INTO producto VALUES ('FR-24','Albaricoquero Corbato',4,'','Melocotones de Cieza S.A.','�rbol que puede pasar de los 6 m de altura, en la regi�n mediterr�nea con ramas formando una copa redondeada. La corteza del tronco es pardo-viol�cea, agrietada; las ramas son rojizas y extendidas cuando j�venes y las ramas secundarias son cortas, divergentes y escasas. Las yemas latentes son frecuentes especialmente sobre las ramas viejas.',400,8,6);
INSERT INTO producto VALUES ('FR-25','Albaricoquero Moniqui',4,'','Melocotones de Cieza S.A.','�rbol que puede pasar de los 6 m de altura, en la regi�n mediterr�nea con ramas formando una copa redondeada. La corteza del tronco es pardo-viol�cea, agrietada; las ramas son rojizas y extendidas cuando j�venes y las ramas secundarias son cortas, divergentes y escasas. Las yemas latentes son frecuentes especialmente sobre las ramas viejas.',400,8,6);
INSERT INTO producto VALUES ('FR-26','Albaricoquero Kurrot',4,'','Melocotones de Cieza S.A.','�rbol que puede pasar de los 6 m de altura, en la regi�n mediterr�nea con ramas formando una copa redondeada. La corteza del tronco es pardo-viol�cea, agrietada; las ramas son rojizas y extendidas cuando j�venes y las ramas secundarias son cortas, divergentes y escasas. Las yemas latentes son frecuentes especialmente sobre las ramas viejas.',400,8,6);
INSERT INTO producto VALUES ('FR-27','Cerezo Burlat',4,'','Jerte Distribuciones S.L.','Las principales especies de cerezo cultivadas en el mundo son el cerezo dulce (Prunus avium), el guindo (P. cerasus) y el cerezo \"Duke\", h�brido de los anteriores. Ambas especies son naturales del sureste de Europa y oeste de Asia. El cerezo dulce tuvo su origen probablemente en el mar Negro y en el mar Caspio, difundi�ndose despu�s hacia Europa y Asia, llevado por los p�jaros y las migraciones humanas. Fue uno de los frutales m�s apreciados por los griegos y con el Imperio Romano se extendi� a regiones muy diversas. En la actualidad, el cerezo se encuentra difundido por numerosas regiones y pa�ses del mundo con clima templado',400,8,6);
INSERT INTO producto VALUES ('FR-28','Cerezo Picota',4,'','Jerte Distribuciones S.L.','Las principales especies de cerezo cultivadas en el mundo son el cerezo dulce (Prunus avium), el guindo (P. cerasus) y el cerezo \"Duke\", h�brido de los anteriores. Ambas especies son naturales del sureste de Europa y oeste de Asia. El cerezo dulce tuvo su origen probablemente en el mar Negro y en el mar Caspio, difundi�ndose despu�s hacia Europa y Asia, llevado por los p�jaros y las migraciones humanas. Fue uno de los frutales m�s apreciados por los griegos y con el Imperio Romano se extendi� a regiones muy diversas. En la actualidad, el cerezo se encuentra difundido por numerosas regiones y pa�ses del mundo con clima templado',400,8,6);
INSERT INTO producto VALUES ('FR-29','Cerezo Napole�n',4,'','Jerte Distribuciones S.L.','Las principales especies de cerezo cultivadas en el mundo son el cerezo dulce (Prunus avium), el guindo (P. cerasus) y el cerezo \"Duke\", h�brido de los anteriores. Ambas especies son naturales del sureste de Europa y oeste de Asia. El cerezo dulce tuvo su origen probablemente en el mar Negro y en el mar Caspio, difundi�ndose despu�s hacia Europa y Asia, llevado por los p�jaros y las migraciones humanas. Fue uno de los frutales m�s apreciados por los griegos y con el Imperio Romano se extendi� a regiones muy diversas. En la actualidad, el cerezo se encuentra difundido por numerosas regiones y pa�ses del mundo con clima templado',400,8,6);
INSERT INTO producto VALUES ('FR-3','Naranjo 2 a�os injerto',4,'','NaranjasValencianas.com','El naranjo es un �rbol peque�o, que no supera los 3-5 metros de altura, con una copa compacta, c�nica, transformada en es�rica gracias a la poda. Su tronco es de color gris y liso, y las hojas son perennes, cori�ceas, de un verde intenso y brillante, con forma oval o el�ptico-lanceolada. Poseen, en el caso del naranjo amargo, un t�pico peciolo alado en forma de coraz�n, que en el naranjo dulce es m�s estrecho y menos patente.',15,7,5);
INSERT INTO producto VALUES ('FR-30','Ciruelo R. Claudia Verde   ',4,'','Frutales Talavera S.A','�rbol de tama�o mediano que alcanza una altura m�xima de 5-6 m. Tronco de corteza pardo-azulada, brillante, lisa o agrietada longitudinalmente. Produce ramas alternas, peque�as, delgadas, unas veces lisas, glabras y otras pubescentes y vellosas',400,8,6);
INSERT INTO producto VALUES ('FR-31','Ciruelo Santa Rosa',4,'','Frutales Talavera S.A','�rbol de tama�o mediano que alcanza una altura m�xima de 5-6 m. Tronco de corteza pardo-azulada, brillante, lisa o agrietada longitudinalmente. Produce ramas alternas, peque�as, delgadas, unas veces lisas, glabras y otras pubescentes y vellosas',400,8,6);
INSERT INTO producto VALUES ('FR-32','Ciruelo Golden Japan',4,'','Frutales Talavera S.A','�rbol de tama�o mediano que alcanza una altura m�xima de 5-6 m. Tronco de corteza pardo-azulada, brillante, lisa o agrietada longitudinalmente. Produce ramas alternas, peque�as, delgadas, unas veces lisas, glabras y otras pubescentes y vellosas',400,8,6);
INSERT INTO producto VALUES ('FR-33','Ciruelo Friar',4,'','Frutales Talavera S.A','�rbol de tama�o mediano que alcanza una altura m�xima de 5-6 m. Tronco de corteza pardo-azulada, brillante, lisa o agrietada longitudinalmente. Produce ramas alternas, peque�as, delgadas, unas veces lisas, glabras y otras pubescentes y vellosas',400,8,6);
INSERT INTO producto VALUES ('FR-34','Ciruelo Reina C. De Ollins',4,'','Frutales Talavera S.A','�rbol de tama�o mediano que alcanza una altura m�xima de 5-6 m. Tronco de corteza pardo-azulada, brillante, lisa o agrietada longitudinalmente. Produce ramas alternas, peque�as, delgadas, unas veces lisas, glabras y otras pubescentes y vellosas',400,8,6);
INSERT INTO producto VALUES ('FR-35','Ciruelo Claudia Negra',4,'','Frutales Talavera S.A','�rbol de tama�o mediano que alcanza una altura m�xima de 5-6 m. Tronco de corteza pardo-azulada, brillante, lisa o agrietada longitudinalmente. Produce ramas alternas, peque�as, delgadas, unas veces lisas, glabras y otras pubescentes y vellosas',400,8,6);
INSERT INTO producto VALUES ('FR-36','Granado Mollar de Elche',4,'','Frutales Talavera S.A','peque�o �rbol caducifolio, a veces con porte arbustivo, de 3 a 6 m de altura, con el tronco retorcido. Madera dura y corteza escamosa de color gris�ceo. Las ramitas j�venes son m�s o menos cuadrangulares o angostas y de cuatro alas, posteriormente se vuelven redondas con corteza de color caf� gris�ceo, la mayor�a de las ramas, pero especialmente las peque�as ramitas axilares, son en forma de espina o terminan en una espina aguda; la copa es extendida.',400,9,7);
INSERT INTO producto VALUES ('FR-37','Higuera Napolitana',4,'','Frutales Talavera S.A','La higuera (Ficus carica L.) es un �rbol t�pico de secano en los pa�ses mediterr�neos. Su rusticidad y su f�cil multiplicaci�n hacen de la higuera un frutal muy apropiado para el cultivo extensivo.. Siempre ha sido considerado como �rbol que no requiere cuidado alguno una vez plantado y arraigado, limit�ndose el hombre a recoger de �l los frutos cuando maduran, unos para consumo en fresco y otros para conserva. Las �nicas higueras con cuidados culturales esmerados, en muchas comarcas, son las brevales, por el inter�s econ�mico de su primera cosecha, la de brevas.',400,9,7);
INSERT INTO producto VALUES ('FR-38','Higuera Verdal',4,'','Frutales Talavera S.A','La higuera (Ficus carica L.) es un �rbol t�pico de secano en los pa�ses mediterr�neos. Su rusticidad y su f�cil multiplicaci�n hacen de la higuera un frutal muy apropiado para el cultivo extensivo.. Siempre ha sido considerado como �rbol que no requiere cuidado alguno una vez plantado y arraigado, limit�ndose el hombre a recoger de �l los frutos cuando maduran, unos para consumo en fresco y otros para conserva. Las �nicas higueras con cuidados culturales esmerados, en muchas comarcas, son las brevales, por el inter�s econ�mico de su primera cosecha, la de brevas.',400,9,7);
INSERT INTO producto VALUES ('FR-39','Higuera Breva',4,'','Frutales Talavera S.A','La higuera (Ficus carica L.) es un �rbol t�pico de secano en los pa�ses mediterr�neos. Su rusticidad y su f�cil multiplicaci�n hacen de la higuera un frutal muy apropiado para el cultivo extensivo.. Siempre ha sido considerado como �rbol que no requiere cuidado alguno una vez plantado y arraigado, limit�ndose el hombre a recoger de �l los frutos cuando maduran, unos para consumo en fresco y otros para conserva. Las �nicas higueras con cuidados culturales esmerados, en muchas comarcas, son las brevales, por el inter�s econ�mico de su primera cosecha, la de brevas.',400,9,7);
INSERT INTO producto VALUES ('FR-4','Naranjo calibre 8/10',4,'','NaranjasValencianas.com','El naranjo es un �rbol peque�o, que no supera los 3-5 metros de altura, con una copa compacta, c�nica, transformada en es�rica gracias a la poda. Su tronco es de color gris y liso, y las hojas son perennes, cori�ceas, de un verde intenso y brillante, con forma oval o el�ptico-lanceolada. Poseen, en el caso del naranjo amargo, un t�pico peciolo alado en forma de coraz�n, que en el naranjo dulce es m�s estrecho y menos patente.',15,29,23);
INSERT INTO producto VALUES ('FR-40','Manzano Starking Delicious',4,'','Frutales Talavera S.A','alcanza como m�ximo 10 m. de altura y tiene una copa globosa. Tronco derecho que normalmente alcanza de 2 a 2,5 m. de altura, con corteza cubierta de lenticelas, lisa, adherida, de color ceniciento verdoso sobre los ramos y escamosa y gris parda sobre las partes viejas del �rbol. Tiene una vida de unos 60-80 a�os. Las ramas se insertan en �ngulo abierto sobre el tallo, de color verde oscuro, a veces tendiendo a negruzco o viol�ceo. Los brotes j�venes terminan con frecuencia en una espina',400,8,6);
INSERT INTO producto VALUES ('FR-41','Manzano Reineta',4,'','Frutales Talavera S.A','alcanza como m�ximo 10 m. de altura y tiene una copa globosa. Tronco derecho que normalmente alcanza de 2 a 2,5 m. de altura, con corteza cubierta de lenticelas, lisa, adherida, de color ceniciento verdoso sobre los ramos y escamosa y gris parda sobre las partes viejas del �rbol. Tiene una vida de unos 60-80 a�os. Las ramas se insertan en �ngulo abierto sobre el tallo, de color verde oscuro, a veces tendiendo a negruzco o viol�ceo. Los brotes j�venes terminan con frecuencia en una espina',400,8,6);
INSERT INTO producto VALUES ('FR-42','Manzano Golden Delicious',4,'','Frutales Talavera S.A','alcanza como m�ximo 10 m. de altura y tiene una copa globosa. Tronco derecho que normalmente alcanza de 2 a 2,5 m. de altura, con corteza cubierta de lenticelas, lisa, adherida, de color ceniciento verdoso sobre los ramos y escamosa y gris parda sobre las partes viejas del �rbol. Tiene una vida de unos 60-80 a�os. Las ramas se insertan en �ngulo abierto sobre el tallo, de color verde oscuro, a veces tendiendo a negruzco o viol�ceo. Los brotes j�venes terminan con frecuencia en una espina',400,8,6);
INSERT INTO producto VALUES ('FR-43','Membrillero Gigante de Wranja',4,'','Frutales Talavera S.A','',400,8,6);
INSERT INTO producto VALUES ('FR-44','Melocotonero Spring Crest',4,'','Melocotones de Cieza S.A.','�rbol caducifolio de porte bajo con corteza lisa, de color ceniciento. Sus hojas son alargadas con el margen ligeramente aserrado, de color verde brillante, algo m�s claras por el env�s. El melocotonero est� muy arraigado en la cultura asi�tica.\r\nEn Jap�n, el noble heroe Momotaro, una especie de Cid japon�s, naci� del interior de un enorme melocot�n que flotaba r�o abajo.\r\nEn China se piensa que comer melocot�n confiere longevidad al ser humano, ya que formaba parte de la dieta de sus dioses inmortales.',400,8,6);
INSERT INTO producto VALUES ('FR-45','Melocotonero Amarillo de Agosto',4,'','Melocotones de Cieza S.A.','�rbol caducifolio de porte bajo con corteza lisa, de color ceniciento. Sus hojas son alargadas con el margen ligeramente aserrado, de color verde brillante, algo m�s claras por el env�s. El melocotonero est� muy arraigado en la cultura asi�tica.\r\nEn Jap�n, el noble heroe Momotaro, una especie de Cid japon�s, naci� del interior de un enorme melocot�n que flotaba r�o abajo.\r\nEn China se piensa que comer melocot�n confiere longevidad al ser humano, ya que formaba parte de la dieta de sus dioses inmortales.',400,8,6);
INSERT INTO producto VALUES ('FR-46','Melocotonero Federica',4,'','Melocotones de Cieza S.A.','�rbol caducifolio de porte bajo con corteza lisa, de color ceniciento. Sus hojas son alargadas con el margen ligeramente aserrado, de color verde brillante, algo m�s claras por el env�s. El melocotonero est� muy arraigado en la cultura asi�tica.\r\nEn Jap�n, el noble heroe Momotaro, una especie de Cid japon�s, naci� del interior de un enorme melocot�n que flotaba r�o abajo.\r\nEn China se piensa que comer melocot�n confiere longevidad al ser humano, ya que formaba parte de la dieta de sus dioses inmortales.',400,8,6);
INSERT INTO producto VALUES ('FR-47','Melocotonero Paraguayo',4,'','Melocotones de Cieza S.A.','�rbol caducifolio de porte bajo con corteza lisa, de color ceniciento. Sus hojas son alargadas con el margen ligeramente aserrado, de color verde brillante, algo m�s claras por el env�s. El melocotonero est� muy arraigado en la cultura asi�tica.\r\nEn Jap�n, el noble heroe Momotaro, una especie de Cid japon�s, naci� del interior de un enorme melocot�n que flotaba r�o abajo.\r\nEn China se piensa que comer melocot�n confiere longevidad al ser humano, ya que formaba parte de la dieta de sus dioses inmortales.',400,8,6);
INSERT INTO producto VALUES ('FR-48','Nogal Com�n',4,'','Frutales Talavera S.A','',400,9,7);
INSERT INTO producto VALUES ('FR-49','Parra Uva de Mesa',4,'','Frutales Talavera S.A','',400,8,6);
INSERT INTO producto VALUES ('FR-5','Mandarino -Plant�n joven',4,'','Frutales Talavera S.A','',15,6,4);
INSERT INTO producto VALUES ('FR-50','Peral Castell',4,'','Frutales Talavera S.A','�rbol piramidal, redondeado en su juventud, luego oval, que llega hasta 20 metros de altura y por t�rmino medio vive 65 a�os.Tronco alto, grueso, de corteza agrietada, gris, de la cual se destacan con frecuencia placas lenticulares.Las ramas se insertan formando �ngulo agudo con el tronco (45�), de corteza lisa, primero verde y luego gris-viol�cea, con numerosas lenticelas.',400,8,6);
INSERT INTO producto VALUES ('FR-51','Peral Williams',4,'','Frutales Talavera S.A','�rbol piramidal, redondeado en su juventud, luego oval, que llega hasta 20 metros de altura y por t�rmino medio vive 65 a�os.Tronco alto, grueso, de corteza agrietada, gris, de la cual se destacan con frecuencia placas lenticulares.Las ramas se insertan formando �ngulo agudo con el tronco (45�), de corteza lisa, primero verde y luego gris-viol�cea, con numerosas lenticelas.',400,8,6);
INSERT INTO producto VALUES ('FR-52','Peral Conference',4,'','Frutales Talavera S.A','�rbol piramidal, redondeado en su juventud, luego oval, que llega hasta 20 metros de altura y por t�rmino medio vive 65 a�os.Tronco alto, grueso, de corteza agrietada, gris, de la cual se destacan con frecuencia placas lenticulares.Las ramas se insertan formando �ngulo agudo con el tronco (45�), de corteza lisa, primero verde y luego gris-viol�cea, con numerosas lenticelas.',400,8,6);
INSERT INTO producto VALUES ('FR-53','Peral Blanq. de Aranjuez',4,'','Frutales Talavera S.A','�rbol piramidal, redondeado en su juventud, luego oval, que llega hasta 20 metros de altura y por t�rmino medio vive 65 a�os.Tronco alto, grueso, de corteza agrietada, gris, de la cual se destacan con frecuencia placas lenticulares.Las ramas se insertan formando �ngulo agudo con el tronco (45�), de corteza lisa, primero verde y luego gris-viol�cea, con numerosas lenticelas.',400,8,6);
INSERT INTO producto VALUES ('FR-54','N�spero Tanaca',4,'','Frutales Talavera S.A','Aunque originario del Sudeste de China, el n�spero lleg� a Europa procedente de Jap�n en el siglo XVIII como �rbol ornamental. En el siglo XIX se inici� el consumo de los frutos en toda el �rea mediterr�nea, donde se adapt� muy bien a las zonas de cultivo de los c�tricos.El cultivo intensivo comenz� a desarrollarse a finales de los a�os 60 y principios de los 70, cuando comenzaron a implantarse las variedades y t�cnicas de cultivo actualmente utilizadas.',400,9,7);
INSERT INTO producto VALUES ('FR-55','Olivo Cipresino',4,'','Frutales Talavera S.A','Existen dos hip�tesis sobre el origen del olivo, una que postula que proviene de las costas de Siria, L�bano e Israel y otra que considera que lo considera originario de Asia menor. La llegada a Europa probablemente tuvo lugar de mano de los Fenicios, en transito por Chipre, Creta, e Islas del Mar Egeo, pasando a Grecia y m�s tarde a Italia. Los primeros indicios de la presencia del olivo en las costas mediterr�neas espa�olas coinciden con el dominio romano, aunque fueron posteriormente los �rabes los que impulsaron su cultivo en Andaluc�a, convirtiendo a Espa�a en el primer pa�s productor de aceite de oliva a nivel mundial.',400,8,6);
INSERT INTO producto VALUES ('FR-56','Nectarina',4,'','Frutales Talavera S.A','',400,8,6);
INSERT INTO producto VALUES ('FR-57','Kaki Rojo Brillante',4,'','NaranjasValencianas.com','De crecimiento algo lento los primeros a�os, llega a alcanzar hasta doce metros de altura o m�s, aunque en cultivo se prefiere algo m�s bajo (5-6). Tronco corto y copa extendida. Ramifica muy poco debido a la dominancia apical. Porte m�s o menos piramidal, aunque con la edad se hace m�s globoso.',400,9,7);
INSERT INTO producto VALUES ('FR-58','Albaricoquero',4,'8/10','Melocotones de Cieza S.A.','�rbol que puede pasar de los 6 m de altura, en la regi�n mediterr�nea con ramas formando una copa redondeada. La corteza del tronco es pardo-viol�cea, agrietada; las ramas son rojizas y extendidas cuando j�venes y las ramas secundarias son cortas, divergentes y escasas. Las yemas latentes son frecuentes especialmente sobre las ramas viejas.',200,11,8);
INSERT INTO producto VALUES ('FR-59','Albaricoquero',4,'10/12','Melocotones de Cieza S.A.','�rbol que puede pasar de los 6 m de altura, en la regi�n mediterr�nea con ramas formando una copa redondeada. La corteza del tronco es pardo-viol�cea, agrietada; las ramas son rojizas y extendidas cuando j�venes y las ramas secundarias son cortas, divergentes y escasas. Las yemas latentes son frecuentes especialmente sobre las ramas viejas.',200,22,17);
INSERT INTO producto VALUES ('FR-6','Mandarino 2 a�os injerto',4,'','Frutales Talavera S.A','',15,7,5);
INSERT INTO producto VALUES ('FR-60','Albaricoquero',4,'12/14','Melocotones de Cieza S.A.','�rbol que puede pasar de los 6 m de altura, en la regi�n mediterr�nea con ramas formando una copa redondeada. La corteza del tronco es pardo-viol�cea, agrietada; las ramas son rojizas y extendidas cuando j�venes y las ramas secundarias son cortas, divergentes y escasas. Las yemas latentes son frecuentes especialmente sobre las ramas viejas.',200,32,25);
INSERT INTO producto VALUES ('FR-61','Albaricoquero',4,'14/16','Melocotones de Cieza S.A.','�rbol que puede pasar de los 6 m de altura, en la regi�n mediterr�nea con ramas formando una copa redondeada. La corteza del tronco es pardo-viol�cea, agrietada; las ramas son rojizas y extendidas cuando j�venes y las ramas secundarias son cortas, divergentes y escasas. Las yemas latentes son frecuentes especialmente sobre las ramas viejas.',200,49,39);
INSERT INTO producto VALUES ('FR-62','Albaricoquero',4,'16/18','Melocotones de Cieza S.A.','�rbol que puede pasar de los 6 m de altura, en la regi�n mediterr�nea con ramas formando una copa redondeada. La corteza del tronco es pardo-viol�cea, agrietada; las ramas son rojizas y extendidas cuando j�venes y las ramas secundarias son cortas, divergentes y escasas. Las yemas latentes son frecuentes especialmente sobre las ramas viejas.',200,70,56);
INSERT INTO producto VALUES ('FR-63','Cerezo',4,'8/10','Jerte Distribuciones S.L.','Las principales especies de cerezo cultivadas en el mundo son el cerezo dulce (Prunus avium), el guindo (P. cerasus) y el cerezo \"Duke\", h�brido de los anteriores. Ambas especies son naturales del sureste de Europa y oeste de Asia. El cerezo dulce tuvo su origen probablemente en el mar Negro y en el mar Caspio, difundi�ndose despu�s hacia Europa y Asia, llevado por los p�jaros y las migraciones humanas. Fue uno de los frutales m�s apreciados por los griegos y con el Imperio Romano se extendi� a regiones muy diversas. En la actualidad, el cerezo se encuentra difundido por numerosas regiones y pa�ses del mundo con clima templado',300,11,8);
INSERT INTO producto VALUES ('FR-64','Cerezo',4,'10/12','Jerte Distribuciones S.L.','Las principales especies de cerezo cultivadas en el mundo son el cerezo dulce (Prunus avium), el guindo (P. cerasus) y el cerezo \"Duke\", h�brido de los anteriores. Ambas especies son naturales del sureste de Europa y oeste de Asia. El cerezo dulce tuvo su origen probablemente en el mar Negro y en el mar Caspio, difundi�ndose despu�s hacia Europa y Asia, llevado por los p�jaros y las migraciones humanas. Fue uno de los frutales m�s apreciados por los griegos y con el Imperio Romano se extendi� a regiones muy diversas. En la actualidad, el cerezo se encuentra difundido por numerosas regiones y pa�ses del mundo con clima templado',15,22,17);
INSERT INTO producto VALUES ('FR-65','Cerezo',4,'12/14','Jerte Distribuciones S.L.','Las principales especies de cerezo cultivadas en el mundo son el cerezo dulce (Prunus avium), el guindo (P. cerasus) y el cerezo \"Duke\", h�brido de los anteriores. Ambas especies son naturales del sureste de Europa y oeste de Asia. El cerezo dulce tuvo su origen probablemente en el mar Negro y en el mar Caspio, difundi�ndose despu�s hacia Europa y Asia, llevado por los p�jaros y las migraciones humanas. Fue uno de los frutales m�s apreciados por los griegos y con el Imperio Romano se extendi� a regiones muy diversas. En la actualidad, el cerezo se encuentra difundido por numerosas regiones y pa�ses del mundo con clima templado',200,32,25);
INSERT INTO producto VALUES ('FR-66','Cerezo',4,'14/16','Jerte Distribuciones S.L.','Las principales especies de cerezo cultivadas en el mundo son el cerezo dulce (Prunus avium), el guindo (P. cerasus) y el cerezo \"Duke\", h�brido de los anteriores. Ambas especies son naturales del sureste de Europa y oeste de Asia. El cerezo dulce tuvo su origen probablemente en el mar Negro y en el mar Caspio, difundi�ndose despu�s hacia Europa y Asia, llevado por los p�jaros y las migraciones humanas. Fue uno de los frutales m�s apreciados por los griegos y con el Imperio Romano se extendi� a regiones muy diversas. En la actualidad, el cerezo se encuentra difundido por numerosas regiones y pa�ses del mundo con clima templado',50,49,39);
INSERT INTO producto VALUES ('FR-67','Cerezo',4,'16/18','Jerte Distribuciones S.L.','Las principales especies de cerezo cultivadas en el mundo son el cerezo dulce (Prunus avium), el guindo (P. cerasus) y el cerezo \"Duke\", h�brido de los anteriores. Ambas especies son naturales del sureste de Europa y oeste de Asia. El cerezo dulce tuvo su origen probablemente en el mar Negro y en el mar Caspio, difundi�ndose despu�s hacia Europa y Asia, llevado por los p�jaros y las migraciones humanas. Fue uno de los frutales m�s apreciados por los griegos y con el Imperio Romano se extendi� a regiones muy diversas. En la actualidad, el cerezo se encuentra difundido por numerosas regiones y pa�ses del mundo con clima templado',50,70,56);
INSERT INTO producto VALUES ('FR-68','Cerezo',4,'18/20','Jerte Distribuciones S.L.','Las principales especies de cerezo cultivadas en el mundo son el cerezo dulce (Prunus avium), el guindo (P. cerasus) y el cerezo \"Duke\", h�brido de los anteriores. Ambas especies son naturales del sureste de Europa y oeste de Asia. El cerezo dulce tuvo su origen probablemente en el mar Negro y en el mar Caspio, difundi�ndose despu�s hacia Europa y Asia, llevado por los p�jaros y las migraciones humanas. Fue uno de los frutales m�s apreciados por los griegos y con el Imperio Romano se extendi� a regiones muy diversas. En la actualidad, el cerezo se encuentra difundido por numerosas regiones y pa�ses del mundo con clima templado',50,80,64);
INSERT INTO producto VALUES ('FR-69','Cerezo',4,'20/25','Jerte Distribuciones S.L.','Las principales especies de cerezo cultivadas en el mundo son el cerezo dulce (Prunus avium), el guindo (P. cerasus) y el cerezo \"Duke\", h�brido de los anteriores. Ambas especies son naturales del sureste de Europa y oeste de Asia. El cerezo dulce tuvo su origen probablemente en el mar Negro y en el mar Caspio, difundi�ndose despu�s hacia Europa y Asia, llevado por los p�jaros y las migraciones humanas. Fue uno de los frutales m�s apreciados por los griegos y con el Imperio Romano se extendi� a regiones muy diversas. En la actualidad, el cerezo se encuentra difundido por numerosas regiones y pa�ses del mundo con clima templado',50,91,72);
INSERT INTO producto VALUES ('FR-7','Mandarino calibre 8/10',4,'','Frutales Talavera S.A','',15,29,23);
INSERT INTO producto VALUES ('FR-70','Ciruelo',4,'8/10','Frutales Talavera S.A','�rbol de tama�o mediano que alcanza una altura m�xima de 5-6 m. Tronco de corteza pardo-azulada, brillante, lisa o agrietada longitudinalmente. Produce ramas alternas, peque�as, delgadas, unas veces lisas, glabras y otras pubescentes y vellosas',50,11,8);
INSERT INTO producto VALUES ('FR-71','Ciruelo',4,'10/12','Frutales Talavera S.A','�rbol de tama�o mediano que alcanza una altura m�xima de 5-6 m. Tronco de corteza pardo-azulada, brillante, lisa o agrietada longitudinalmente. Produce ramas alternas, peque�as, delgadas, unas veces lisas, glabras y otras pubescentes y vellosas',50,22,17);
INSERT INTO producto VALUES ('FR-72','Ciruelo',4,'12/14','Frutales Talavera S.A','�rbol de tama�o mediano que alcanza una altura m�xima de 5-6 m. Tronco de corteza pardo-azulada, brillante, lisa o agrietada longitudinalmente. Produce ramas alternas, peque�as, delgadas, unas veces lisas, glabras y otras pubescentes y vellosas',50,32,25);
INSERT INTO producto VALUES ('FR-73','Granado',4,'8/10','Frutales Talavera S.A','peque�o �rbol caducifolio, a veces con porte arbustivo, de 3 a 6 m de altura, con el tronco retorcido. Madera dura y corteza escamosa de color gris�ceo. Las ramitas j�venes son m�s o menos cuadrangulares o angostas y de cuatro alas, posteriormente se vuelven redondas con corteza de color caf� gris�ceo, la mayor�a de las ramas, pero especialmente las peque�as ramitas axilares, son en forma de espina o terminan en una espina aguda; la copa es extendida.',50,13,10);
INSERT INTO producto VALUES ('FR-74','Granado',4,'10/12','Frutales Talavera S.A','peque�o �rbol caducifolio, a veces con porte arbustivo, de 3 a 6 m de altura, con el tronco retorcido. Madera dura y corteza escamosa de color gris�ceo. Las ramitas j�venes son m�s o menos cuadrangulares o angostas y de cuatro alas, posteriormente se vuelven redondas con corteza de color caf� gris�ceo, la mayor�a de las ramas, pero especialmente las peque�as ramitas axilares, son en forma de espina o terminan en una espina aguda; la copa es extendida.',50,22,17);
INSERT INTO producto VALUES ('FR-75','Granado',4,'12/14','Frutales Talavera S.A','peque�o �rbol caducifolio, a veces con porte arbustivo, de 3 a 6 m de altura, con el tronco retorcido. Madera dura y corteza escamosa de color gris�ceo. Las ramitas j�venes son m�s o menos cuadrangulares o angostas y de cuatro alas, posteriormente se vuelven redondas con corteza de color caf� gris�ceo, la mayor�a de las ramas, pero especialmente las peque�as ramitas axilares, son en forma de espina o terminan en una espina aguda; la copa es extendida.',50,32,25);
INSERT INTO producto VALUES ('FR-76','Granado',4,'14/16','Frutales Talavera S.A','peque�o �rbol caducifolio, a veces con porte arbustivo, de 3 a 6 m de altura, con el tronco retorcido. Madera dura y corteza escamosa de color gris�ceo. Las ramitas j�venes son m�s o menos cuadrangulares o angostas y de cuatro alas, posteriormente se vuelven redondas con corteza de color caf� gris�ceo, la mayor�a de las ramas, pero especialmente las peque�as ramitas axilares, son en forma de espina o terminan en una espina aguda; la copa es extendida.',50,49,39);
INSERT INTO producto VALUES ('FR-77','Granado',4,'16/18','Frutales Talavera S.A','peque�o �rbol caducifolio, a veces con porte arbustivo, de 3 a 6 m de altura, con el tronco retorcido. Madera dura y corteza escamosa de color gris�ceo. Las ramitas j�venes son m�s o menos cuadrangulares o angostas y de cuatro alas, posteriormente se vuelven redondas con corteza de color caf� gris�ceo, la mayor�a de las ramas, pero especialmente las peque�as ramitas axilares, son en forma de espina o terminan en una espina aguda; la copa es extendida.',50,70,56);
INSERT INTO producto VALUES ('FR-78','Higuera',4,'8/10','Frutales Talavera S.A','La higuera (Ficus carica L.) es un �rbol t�pico de secano en los pa�ses mediterr�neos. Su rusticidad y su f�cil multiplicaci�n hacen de la higuera un frutal muy apropiado para el cultivo extensivo.. Siempre ha sido considerado como �rbol que no requiere cuidado alguno una vez plantado y arraigado, limit�ndose el hombre a recoger de �l los frutos cuando maduran, unos para consumo en fresco y otros para conserva. Las �nicas higueras con cuidados culturales esmerados, en muchas comarcas, son las brevales, por el inter�s econ�mico de su primera cosecha, la de brevas.',50,15,12);
INSERT INTO producto VALUES ('FR-79','Higuera',4,'10/12','Frutales Talavera S.A','La higuera (Ficus carica L.) es un �rbol t�pico de secano en los pa�ses mediterr�neos. Su rusticidad y su f�cil multiplicaci�n hacen de la higuera un frutal muy apropiado para el cultivo extensivo.. Siempre ha sido considerado como �rbol que no requiere cuidado alguno una vez plantado y arraigado, limit�ndose el hombre a recoger de �l los frutos cuando maduran, unos para consumo en fresco y otros para conserva. Las �nicas higueras con cuidados culturales esmerados, en muchas comarcas, son las brevales, por el inter�s econ�mico de su primera cosecha, la de brevas.',50,22,17);
INSERT INTO producto VALUES ('FR-8','Limonero -Plant�n joven',4,'','NaranjasValencianas.com','El limonero, pertenece al grupo de los c�tricos, teniendo su origen hace unos 20 millones de a�os en el sudeste asi�tico. Fue introducido por los �rabes en el �rea mediterr�nea entre los a�os 1.000 a 1.200, habiendo experimentando numerosas modificaciones debidas tanto a la selecci�n natural mediante hibridaciones espont�neas como a las producidas por el',15,6,4);
INSERT INTO producto VALUES ('FR-80','Higuera',4,'12/14','Frutales Talavera S.A','La higuera (Ficus carica L.) es un �rbol t�pico de secano en los pa�ses mediterr�neos. Su rusticidad y su f�cil multiplicaci�n hacen de la higuera un frutal muy apropiado para el cultivo extensivo.. Siempre ha sido considerado como �rbol que no requiere cuidado alguno una vez plantado y arraigado, limit�ndose el hombre a recoger de �l los frutos cuando maduran, unos para consumo en fresco y otros para conserva. Las �nicas higueras con cuidados culturales esmerados, en muchas comarcas, son las brevales, por el inter�s econ�mico de su primera cosecha, la de brevas.',50,32,25);
INSERT INTO producto VALUES ('FR-81','Higuera',4,'14/16','Frutales Talavera S.A','La higuera (Ficus carica L.) es un �rbol t�pico de secano en los pa�ses mediterr�neos. Su rusticidad y su f�cil multiplicaci�n hacen de la higuera un frutal muy apropiado para el cultivo extensivo.. Siempre ha sido considerado como �rbol que no requiere cuidado alguno una vez plantado y arraigado, limit�ndose el hombre a recoger de �l los frutos cuando maduran, unos para consumo en fresco y otros para conserva. Las �nicas higueras con cuidados culturales esmerados, en muchas comarcas, son las brevales, por el inter�s econ�mico de su primera cosecha, la de brevas.',50,49,39);
INSERT INTO producto VALUES ('FR-82','Higuera',4,'16/18','Frutales Talavera S.A','La higuera (Ficus carica L.) es un �rbol t�pico de secano en los pa�ses mediterr�neos. Su rusticidad y su f�cil multiplicaci�n hacen de la higuera un frutal muy apropiado para el cultivo extensivo.. Siempre ha sido considerado como �rbol que no requiere cuidado alguno una vez plantado y arraigado, limit�ndose el hombre a recoger de �l los frutos cuando maduran, unos para consumo en fresco y otros para conserva. Las �nicas higueras con cuidados culturales esmerados, en muchas comarcas, son las brevales, por el inter�s econ�mico de su primera cosecha, la de brevas.',50,70,56);
INSERT INTO producto VALUES ('FR-83','Higuera',4,'18/20','Frutales Talavera S.A','La higuera (Ficus carica L.) es un �rbol t�pico de secano en los pa�ses mediterr�neos. Su rusticidad y su f�cil multiplicaci�n hacen de la higuera un frutal muy apropiado para el cultivo extensivo.. Siempre ha sido considerado como �rbol que no requiere cuidado alguno una vez plantado y arraigado, limit�ndose el hombre a recoger de �l los frutos cuando maduran, unos para consumo en fresco y otros para conserva. Las �nicas higueras con cuidados culturales esmerados, en muchas comarcas, son las brevales, por el inter�s econ�mico de su primera cosecha, la de brevas.',50,80,64);
INSERT INTO producto VALUES ('FR-84','Kaki',4,'8/10','NaranjasValencianas.com','De crecimiento algo lento los primeros a�os, llega a alcanzar hasta doce metros de altura o m�s, aunque en cultivo se prefiere algo m�s bajo (5-6). Tronco corto y copa extendida. Ramifica muy poco debido a la dominancia apical. Porte m�s o menos piramidal, aunque con la edad se hace m�s globoso.',50,13,10);
INSERT INTO producto VALUES ('FR-85','Kaki',4,'16/18','NaranjasValencianas.com','De crecimiento algo lento los primeros a�os, llega a alcanzar hasta doce metros de altura o m�s, aunque en cultivo se prefiere algo m�s bajo (5-6). Tronco corto y copa extendida. Ramifica muy poco debido a la dominancia apical. Porte m�s o menos piramidal, aunque con la edad se hace m�s globoso.',50,70,56);
INSERT INTO producto VALUES ('FR-86','Manzano',4,'8/10','Frutales Talavera S.A','alcanza como m�ximo 10 m. de altura y tiene una copa globosa. Tronco derecho que normalmente alcanza de 2 a 2,5 m. de altura, con corteza cubierta de lenticelas, lisa, adherida, de color ceniciento verdoso sobre los ramos y escamosa y gris parda sobre las partes viejas del �rbol. Tiene una vida de unos 60-80 a�os. Las ramas se insertan en �ngulo abierto sobre el tallo, de color verde oscuro, a veces tendiendo a negruzco o viol�ceo. Los brotes j�venes terminan con frecuencia en una espina',50,11,8);
INSERT INTO producto VALUES ('FR-87','Manzano',4,'10/12','Frutales Talavera S.A','alcanza como m�ximo 10 m. de altura y tiene una copa globosa. Tronco derecho que normalmente alcanza de 2 a 2,5 m. de altura, con corteza cubierta de lenticelas, lisa, adherida, de color ceniciento verdoso sobre los ramos y escamosa y gris parda sobre las partes viejas del �rbol. Tiene una vida de unos 60-80 a�os. Las ramas se insertan en �ngulo abierto sobre el tallo, de color verde oscuro, a veces tendiendo a negruzco o viol�ceo. Los brotes j�venes terminan con frecuencia en una espina',50,22,17);
INSERT INTO producto VALUES ('FR-88','Manzano',4,'12/14','Frutales Talavera S.A','alcanza como m�ximo 10 m. de altura y tiene una copa globosa. Tronco derecho que normalmente alcanza de 2 a 2,5 m. de altura, con corteza cubierta de lenticelas, lisa, adherida, de color ceniciento verdoso sobre los ramos y escamosa y gris parda sobre las partes viejas del �rbol. Tiene una vida de unos 60-80 a�os. Las ramas se insertan en �ngulo abierto sobre el tallo, de color verde oscuro, a veces tendiendo a negruzco o viol�ceo. Los brotes j�venes terminan con frecuencia en una espina',50,32,25);
INSERT INTO producto VALUES ('FR-89','Manzano',4,'14/16','Frutales Talavera S.A','alcanza como m�ximo 10 m. de altura y tiene una copa globosa. Tronco derecho que normalmente alcanza de 2 a 2,5 m. de altura, con corteza cubierta de lenticelas, lisa, adherida, de color ceniciento verdoso sobre los ramos y escamosa y gris parda sobre las partes viejas del �rbol. Tiene una vida de unos 60-80 a�os. Las ramas se insertan en �ngulo abierto sobre el tallo, de color verde oscuro, a veces tendiendo a negruzco o viol�ceo. Los brotes j�venes terminan con frecuencia en una espina',50,49,39);
INSERT INTO producto VALUES ('FR-9','Limonero calibre 8/10',4,'','NaranjasValencianas.com','El limonero, pertenece al grupo de los c�tricos, teniendo su origen hace unos 20 millones de a�os en el sudeste asi�tico. Fue introducido por los �rabes en el �rea mediterr�nea entre los a�os 1.000 a 1.200, habiendo experimentando numerosas modificaciones debidas tanto a la selecci�n natural mediante hibridaciones espont�neas como a las producidas por el',15,29,23);
INSERT INTO producto VALUES ('FR-90','N�spero',4,'16/18','Frutales Talavera S.A','Aunque originario del Sudeste de China, el n�spero lleg� a Europa procedente de Jap�n en el siglo XVIII como �rbol ornamental. En el siglo XIX se inici� el consumo de los frutos en toda el �rea mediterr�nea, donde se adapt� muy bien a las zonas de cultivo de los c�tricos.El cultivo intensivo comenz� a desarrollarse a finales de los a�os 60 y principios de los 70, cuando comenzaron a implantarse las variedades y t�cnicas de cultivo actualmente utilizadas.',50,70,56);
INSERT INTO producto VALUES ('FR-91','N�spero',4,'18/20','Frutales Talavera S.A','Aunque originario del Sudeste de China, el n�spero lleg� a Europa procedente de Jap�n en el siglo XVIII como �rbol ornamental. En el siglo XIX se inici� el consumo de los frutos en toda el �rea mediterr�nea, donde se adapt� muy bien a las zonas de cultivo de los c�tricos.El cultivo intensivo comenz� a desarrollarse a finales de los a�os 60 y principios de los 70, cuando comenzaron a implantarse las variedades y t�cnicas de cultivo actualmente utilizadas.',50,80,64);
INSERT INTO producto VALUES ('FR-92','Melocotonero',4,'8/10','Melocotones de Cieza S.A.','�rbol caducifolio de porte bajo con corteza lisa, de color ceniciento. Sus hojas son alargadas con el margen ligeramente aserrado, de color verde brillante, algo m�s claras por el env�s. El melocotonero est� muy arraigado en la cultura asi�tica.\r\nEn Jap�n, el noble heroe Momotaro, una especie de Cid japon�s, naci� del interior de un enorme melocot�n que flotaba r�o abajo.\r\nEn China se piensa que comer melocot�n confiere longevidad al ser humano, ya que formaba parte de la dieta de sus dioses inmortales.',50,11,8);
INSERT INTO producto VALUES ('FR-93','Melocotonero',4,'10/12','Melocotones de Cieza S.A.','�rbol caducifolio de porte bajo con corteza lisa, de color ceniciento. Sus hojas son alargadas con el margen ligeramente aserrado, de color verde brillante, algo m�s claras por el env�s. El melocotonero est� muy arraigado en la cultura asi�tica.\r\nEn Jap�n, el noble heroe Momotaro, una especie de Cid japon�s, naci� del interior de un enorme melocot�n que flotaba r�o abajo.\r\nEn China se piensa que comer melocot�n confiere longevidad al ser humano, ya que formaba parte de la dieta de sus dioses inmortales.',50,22,17);
INSERT INTO producto VALUES ('FR-94','Melocotonero',4,'12/14','Melocotones de Cieza S.A.','�rbol caducifolio de porte bajo con corteza lisa, de color ceniciento. Sus hojas son alargadas con el margen ligeramente aserrado, de color verde brillante, algo m�s claras por el env�s. El melocotonero est� muy arraigado en la cultura asi�tica.\r\nEn Jap�n, el noble heroe Momotaro, una especie de Cid japon�s, naci� del interior de un enorme melocot�n que flotaba r�o abajo.\r\nEn China se piensa que comer melocot�n confiere longevidad al ser humano, ya que formaba parte de la dieta de sus dioses inmortales.',50,32,25);
INSERT INTO producto VALUES ('FR-95','Melocotonero',4,'14/16','Melocotones de Cieza S.A.','�rbol caducifolio de porte bajo con corteza lisa, de color ceniciento. Sus hojas son alargadas con el margen ligeramente aserrado, de color verde brillante, algo m�s claras por el env�s. El melocotonero est� muy arraigado en la cultura asi�tica.\r\nEn Jap�n, el noble heroe Momotaro, una especie de Cid japon�s, naci� del interior de un enorme melocot�n que flotaba r�o abajo.\r\nEn China se piensa que comer melocot�n confiere longevidad al ser humano, ya que formaba parte de la dieta de sus dioses inmortales.',50,49,39);
INSERT INTO producto VALUES ('FR-96','Membrillero',4,'8/10','Frutales Talavera S.A','arbolito caducifolio de 4-6 m de altura con el tronco tortuoso y la corteza lisa, gris�cea, que se desprende en escamas con la edad. Copa irregular, con ramas inermes, flexuosas, parduzcas, punteadas. Ramillas j�venes tomentosas',50,11,8);
INSERT INTO producto VALUES ('FR-97','Membrillero',4,'10/12','Frutales Talavera S.A','arbolito caducifolio de 4-6 m de altura con el tronco tortuoso y la corteza lisa, gris�cea, que se desprende en escamas con la edad. Copa irregular, con ramas inermes, flexuosas, parduzcas, punteadas. Ramillas j�venes tomentosas',50,22,17);
INSERT INTO producto VALUES ('FR-98','Membrillero',4,'12/14','Frutales Talavera S.A','arbolito caducifolio de 4-6 m de altura con el tronco tortuoso y la corteza lisa, gris�cea, que se desprende en escamas con la edad. Copa irregular, con ramas inermes, flexuosas, parduzcas, punteadas. Ramillas j�venes tomentosas',50,32,25);
INSERT INTO producto VALUES ('FR-99','Membrillero',4,'14/16','Frutales Talavera S.A','arbolito caducifolio de 4-6 m de altura con el tronco tortuoso y la corteza lisa, gris�cea, que se desprende en escamas con la edad. Copa irregular, con ramas inermes, flexuosas, parduzcas, punteadas. Ramillas j�venes tomentosas',50,49,39);
INSERT INTO producto VALUES ('OR-001','Arbustos Mix Maceta',5,'40-60','Valencia Garden Service','',25,5,4);
INSERT INTO producto VALUES ('OR-100','Mimosa Injerto CLASICA Dealbata ',5,'100-110','Viveros EL OASIS','Acacia dealbata. Nombre com�n o vulgar: Mimosa fina, Mimosa, Mimosa com�n, Mimosa plateada, Aromo franc�s. Familia: Mimosaceae. Origen: Australia, Sureste, (N. G. del Sur y Victoria). Arbol de follaje persistente muy usado en parques por su atractiva floraci�n amarilla hacia fines del invierno. Altura: de 3 a 10 metros generalmente. Crecimiento r�pido. Follaje perenne de tonos plateados, muy ornamental. Sus hojas son de textura fina, de color verde y sus flores amarillas que aparecen en racimos grandes. Florece de Enero a Marzo (Hemisferio Norte). Legumbre de 5-9 cm de longitud, recta o ligeramente curvada, con los bordes algo constre�idos entre las semillas, que se disponen en el fruto longitudinalmente...',100,12,9);
INSERT INTO producto VALUES ('OR-101','Expositor Mimosa Semilla Mix',5,'170-200','Viveros EL OASIS','Acacia dealbata. Nombre com�n o vulgar: Mimosa fina, Mimosa, Mimosa com�n, Mimosa plateada, Aromo franc�s. Familia: Mimosaceae. Origen: Australia, Sureste, (N. G. del Sur y Victoria). Arbol de follaje persistente muy usado en parques por su atractiva floraci�n amarilla hacia fines del invierno. Altura: de 3 a 10 metros generalmente. Crecimiento r�pido. Follaje perenne de tonos plateados, muy ornamental. Sus hojas son de textura fina, de color verde y sus flores amarillas que aparecen en racimos grandes. Florece de Enero a Marzo (Hemisferio Norte). Legumbre de 5-9 cm de longitud, recta o ligeramente curvada, con los bordes algo constre�idos entre las semillas, que se disponen en el fruto longitudinalmente...',100,6,4);
INSERT INTO producto VALUES ('OR-102','Mimosa Semilla Bayleyana  ',5,'170-200','Viveros EL OASIS','Acacia dealbata. Nombre com�n o vulgar: Mimosa fina, Mimosa, Mimosa com�n, Mimosa plateada, Aromo franc�s. Familia: Mimosaceae. Origen: Australia, Sureste, (N. G. del Sur y Victoria). Arbol de follaje persistente muy usado en parques por su atractiva floraci�n amarilla hacia fines del invierno. Altura: de 3 a 10 metros generalmente. Crecimiento r�pido. Follaje perenne de tonos plateados, muy ornamental. Sus hojas son de textura fina, de color verde y sus flores amarillas que aparecen en racimos grandes. Florece de Enero a Marzo (Hemisferio Norte). Legumbre de 5-9 cm de longitud, recta o ligeramente curvada, con los bordes algo constre�idos entre las semillas, que se disponen en el fruto longitudinalmente...',100,6,4);
INSERT INTO producto VALUES ('OR-103','Mimosa Semilla Bayleyana   ',5,'200-225','Viveros EL OASIS','Acacia dealbata. Nombre com�n o vulgar: Mimosa fina, Mimosa, Mimosa com�n, Mimosa plateada, Aromo franc�s. Familia: Mimosaceae. Origen: Australia, Sureste, (N. G. del Sur y Victoria). Arbol de follaje persistente muy usado en parques por su atractiva floraci�n amarilla hacia fines del invierno. Altura: de 3 a 10 metros generalmente. Crecimiento r�pido. Follaje perenne de tonos plateados, muy ornamental. Sus hojas son de textura fina, de color verde y sus flores amarillas que aparecen en racimos grandes. Florece de Enero a Marzo (Hemisferio Norte). Legumbre de 5-9 cm de longitud, recta o ligeramente curvada, con los bordes algo constre�idos entre las semillas, que se disponen en el fruto longitudinalmente...',100,10,8);
INSERT INTO producto VALUES ('OR-104','Mimosa Semilla Cyanophylla    ',5,'200-225','Viveros EL OASIS','Acacia dealbata. Nombre com�n o vulgar: Mimosa fina, Mimosa, Mimosa com�n, Mimosa plateada, Aromo franc�s. Familia: Mimosaceae. Origen: Australia, Sureste, (N. G. del Sur y Victoria). Arbol de follaje persistente muy usado en parques por su atractiva floraci�n amarilla hacia fines del invierno. Altura: de 3 a 10 metros generalmente. Crecimiento r�pido. Follaje perenne de tonos plateados, muy ornamental. Sus hojas son de textura fina, de color verde y sus flores amarillas que aparecen en racimos grandes. Florece de Enero a Marzo (Hemisferio Norte). Legumbre de 5-9 cm de longitud, recta o ligeramente curvada, con los bordes algo constre�idos entre las semillas, que se disponen en el fruto longitudinalmente...',100,10,8);
INSERT INTO producto VALUES ('OR-105','Mimosa Semilla Espectabilis  ',5,'160-170','Viveros EL OASIS','Acacia dealbata. Nombre com�n o vulgar: Mimosa fina, Mimosa, Mimosa com�n, Mimosa plateada, Aromo franc�s. Familia: Mimosaceae. Origen: Australia, Sureste, (N. G. del Sur y Victoria). Arbol de follaje persistente muy usado en parques por su atractiva floraci�n amarilla hacia fines del invierno. Altura: de 3 a 10 metros generalmente. Crecimiento r�pido. Follaje perenne de tonos plateados, muy ornamental. Sus hojas son de textura fina, de color verde y sus flores amarillas que aparecen en racimos grandes. Florece de Enero a Marzo (Hemisferio Norte). Legumbre de 5-9 cm de longitud, recta o ligeramente curvada, con los bordes algo constre�idos entre las semillas, que se disponen en el fruto longitudinalmente...',100,6,4);
INSERT INTO producto VALUES ('OR-106','Mimosa Semilla Longifolia   ',5,'200-225','Viveros EL OASIS','Acacia dealbata. Nombre com�n o vulgar: Mimosa fina, Mimosa, Mimosa com�n, Mimosa plateada, Aromo franc�s. Familia: Mimosaceae. Origen: Australia, Sureste, (N. G. del Sur y Victoria). Arbol de follaje persistente muy usado en parques por su atractiva floraci�n amarilla hacia fines del invierno. Altura: de 3 a 10 metros generalmente. Crecimiento r�pido. Follaje perenne de tonos plateados, muy ornamental. Sus hojas son de textura fina, de color verde y sus flores amarillas que aparecen en racimos grandes. Florece de Enero a Marzo (Hemisferio Norte). Legumbre de 5-9 cm de longitud, recta o ligeramente curvada, con los bordes algo constre�idos entre las semillas, que se disponen en el fruto longitudinalmente...',100,10,8);
INSERT INTO producto VALUES ('OR-107','Mimosa Semilla Floribunda 4 estaciones',5,'120-140','Viveros EL OASIS','Acacia dealbata. Nombre com�n o vulgar: Mimosa fina, Mimosa, Mimosa com�n, Mimosa plateada, Aromo franc�s. Familia: Mimosaceae. Origen: Australia, Sureste, (N. G. del Sur y Victoria). Arbol de follaje persistente muy usado en parques por su atractiva floraci�n amarilla hacia fines del invierno. Altura: de 3 a 10 metros generalmente. Crecimiento r�pido. Follaje perenne de tonos plateados, muy ornamental. Sus hojas son de textura fina, de color verde y sus flores amarillas que aparecen en racimos grandes. Florece de Enero a Marzo (Hemisferio Norte). Legumbre de 5-9 cm de longitud, recta o ligeramente curvada, con los bordes algo constre�idos entre las semillas, que se disponen en el fruto longitudinalmente...',100,6,4);
INSERT INTO producto VALUES ('OR-108','Abelia Floribunda',5,'35-45','Viveros EL OASIS','',100,5,4);
INSERT INTO producto VALUES ('OR-109','Callistemom (Mix)',5,'35-45','Viveros EL OASIS','Limpitatubos. arbolito de 6-7 m de altura. Ramas flexibles y colgantes (de ah� lo de \"llor�n\")..',100,5,4);
INSERT INTO producto VALUES ('OR-110','Callistemom (Mix)',5,'40-60','Viveros EL OASIS','Limpitatubos. arbolito de 6-7 m de altura. Ramas flexibles y colgantes (de ah� lo de \"llor�n\")..',100,2,1);
INSERT INTO producto VALUES ('OR-111','Corylus Avellana \"Contorta\"',5,'35-45','Viveros EL OASIS','',100,5,4);
INSERT INTO producto VALUES ('OR-112','Escallonia (Mix)',5,'35-45','Viveros EL OASIS','',120,5,4);
INSERT INTO producto VALUES ('OR-113','Evonimus Emerald Gayeti',5,'35-45','Viveros EL OASIS','',120,5,4);
INSERT INTO producto VALUES ('OR-114','Evonimus Pulchellus',5,'35-45','Viveros EL OASIS','',120,5,4);
INSERT INTO producto VALUES ('OR-115','Forsytia Intermedia \"Lynwood\"',5,'35-45','Viveros EL OASIS','',120,7,5);
INSERT INTO producto VALUES ('OR-116','Hibiscus Syriacus  \"Diana\" -Blanco Puro',5,'35-45','Viveros EL OASIS','Por su capacidad de soportar podas, pueden ser f�cilmente moldeadas como bons�i en el transcurso de pocos a�os. Flores de muchos colores seg�n la variedad, desde el blanco puro al rojo intenso, del amarillo al anaranjado. La flor apenas dura 1 d�a, pero continuamente aparecen nuevas y la floraci�n se prolonga durante todo el periodo de crecimiento vegetativo.',120,7,5);
INSERT INTO producto VALUES ('OR-117','Hibiscus Syriacus  \"Helene\" -Blanco-C.rojo',5,'35-45','Viveros EL OASIS','Por su capacidad de soportar podas, pueden ser f�cilmente moldeadas como bons�i en el transcurso de pocos a�os. Flores de muchos colores seg�n la variedad, desde el blanco puro al rojo intenso, del amarillo al anaranjado. La flor apenas dura 1 d�a, pero continuamente aparecen nuevas y la floraci�n se prolonga durante todo el periodo de crecimiento vegetativo.',120,7,5);
INSERT INTO producto VALUES ('OR-118','Hibiscus Syriacus \"Pink Giant\" Rosa',5,'35-45','Viveros EL OASIS','Por su capacidad de soportar podas, pueden ser f�cilmente moldeadas como bons�i en el transcurso de pocos a�os. Flores de muchos colores seg�n la variedad, desde el blanco puro al rojo intenso, del amarillo al anaranjado. La flor apenas dura 1 d�a, pero continuamente aparecen nuevas y la floraci�n se prolonga durante todo el periodo de crecimiento vegetativo.',120,7,5);
INSERT INTO producto VALUES ('OR-119','Laurus Nobilis Arbusto - Ramificado Bajo',5,'40-50','Viveros EL OASIS','',120,5,4);
INSERT INTO producto VALUES ('OR-120','Lonicera Nitida ',5,'35-45','Viveros EL OASIS','',120,5,4);
INSERT INTO producto VALUES ('OR-121','Lonicera Nitida \"Maigrum\"',5,'35-45','Viveros EL OASIS','',120,5,4);
INSERT INTO producto VALUES ('OR-122','Lonicera Pileata',5,'35-45','Viveros EL OASIS','',120,5,4);
INSERT INTO producto VALUES ('OR-123','Philadelphus \"Virginal\"',5,'35-45','Viveros EL OASIS','',120,5,4);
INSERT INTO producto VALUES ('OR-124','Prunus pisardii  ',5,'35-45','Viveros EL OASIS','',120,5,4);
INSERT INTO producto VALUES ('OR-125','Viburnum Tinus \"Eve Price\"',5,'35-45','Viveros EL OASIS','',120,5,4);
INSERT INTO producto VALUES ('OR-126','Weigelia \"Bristol Ruby\"',5,'35-45','Viveros EL OASIS','',120,5,4);
INSERT INTO producto VALUES ('OR-127','Camelia japonica',5,'40-60','Viveros EL OASIS','Arbusto excepcional por su floraci�n oto�al, invernal o primaveral. Flores: Las flores son solitarias, aparecen en el �pice de cada rama, y son con una corola simple o doble, y comprendiendo varios colores. Suelen medir unos 7-12 cm de di� metro y tienen 5 s�palos y 5 p�talos. Estambres numerosos unidos en la mitad o en 2/3 de su longitud.',50,7,5);
INSERT INTO producto VALUES ('OR-128','Camelia japonica ejemplar',5,'200-250','Viveros EL OASIS','Arbusto excepcional por su floraci�n oto�al, invernal o primaveral. Flores: Las flores son solitarias, aparecen en el �pice de cada rama, y son con una corola simple o doble, y comprendiendo varios colores. Suelen medir unos 7-12 cm de di� metro y tienen 5 s�palos y 5 p�talos. Estambres numerosos unidos en la mitad o en 2/3 de su longitud.',50,98,78);
INSERT INTO producto VALUES ('OR-129','Camelia japonica ejemplar',5,'250-300','Viveros EL OASIS','Arbusto excepcional por su floraci�n oto�al, invernal o primaveral. Flores: Las flores son solitarias, aparecen en el �pice de cada rama, y son con una corola simple o doble, y comprendiendo varios colores. Suelen medir unos 7-12 cm de di� metro y tienen 5 s�palos y 5 p�talos. Estambres numerosos unidos en la mitad o en 2/3 de su longitud.',50,110,88);
INSERT INTO producto VALUES ('OR-130','Callistemom COPA',5,'110/120','Viveros EL OASIS','Limpitatubos. arbolito de 6-7 m de altura. Ramas flexibles y colgantes (de ah� lo de \"llor�n\")..',50,18,14);
INSERT INTO producto VALUES ('OR-131','Leptospermum formado PIRAMIDE',5,'80-100','Viveros EL OASIS','',50,18,14);
INSERT INTO producto VALUES ('OR-132','Leptospermum COPA',5,'110/120','Viveros EL OASIS','',50,18,14);
INSERT INTO producto VALUES ('OR-133','Nerium oleander-CALIDAD \"GARDEN\"',5,'40-45','Viveros EL OASIS','',50,2,1);
INSERT INTO producto VALUES ('OR-134','Nerium Oleander Arbusto GRANDE',5,'160-200','Viveros EL OASIS','',100,38,30);
INSERT INTO producto VALUES ('OR-135','Nerium oleander COPA  Calibre 6/8',5,'50-60','Viveros EL OASIS','',100,5,4);
INSERT INTO producto VALUES ('OR-136','Nerium oleander ARBOL Calibre 8/10',5,'225-250','Viveros EL OASIS','',100,18,14);
INSERT INTO producto VALUES ('OR-137','ROSAL TREPADOR',5,'','Viveros EL OASIS','',100,4,3);
INSERT INTO producto VALUES ('OR-138','Camelia Blanco, Chrysler Rojo, Soraya Naranja, ',5,'','Viveros EL OASIS','',100,4,3);
INSERT INTO producto VALUES ('OR-139','Landora Amarillo, Rose Gaujard bicolor blanco-rojo',5,'','Viveros EL OASIS','',100,4,3);
INSERT INTO producto VALUES ('OR-140','Kordes Perfect bicolor rojo-amarillo, Roundelay rojo fuerte',5,'','Viveros EL OASIS','',100,4,3);
INSERT INTO producto VALUES ('OR-141','Pitimini rojo',5,'','Viveros EL OASIS','',100,4,3);
INSERT INTO producto VALUES ('OR-142','Solanum Jazminoide',5,'150-160','Viveros EL OASIS','',100,2,1);
INSERT INTO producto VALUES ('OR-143','Wisteria Sinensis  azul, rosa, blanca',5,'','Viveros EL OASIS','',100,9,7);
INSERT INTO producto VALUES ('OR-144','Wisteria Sinensis INJERTADAS DECÓ',5,'140-150','Viveros EL OASIS','',100,12,9);
INSERT INTO producto VALUES ('OR-145','Bougamvillea Sanderiana Tutor',5,'80-100','Viveros EL OASIS','',100,2,1);
INSERT INTO producto VALUES ('OR-146','Bougamvillea Sanderiana Tutor',5,'125-150','Viveros EL OASIS','',100,4,3);
INSERT INTO producto VALUES ('OR-147','Bougamvillea Sanderiana Tutor',5,'180-200','Viveros EL OASIS','',100,7,5);
INSERT INTO producto VALUES ('OR-148','Bougamvillea Sanderiana Espaldera',5,'45-50','Viveros EL OASIS','',100,7,5);
INSERT INTO producto VALUES ('OR-149','Bougamvillea Sanderiana Espaldera',5,'140-150','Viveros EL OASIS','',100,17,13);
INSERT INTO producto VALUES ('OR-150','Bougamvillea roja, naranja',5,'110-130','Viveros EL OASIS','',100,2,1);
INSERT INTO producto VALUES ('OR-151','Bougamvillea Sanderiana, 3 tut. piramide',5,'','Viveros EL OASIS','',100,6,4);
INSERT INTO producto VALUES ('OR-152','Expositor �rboles clima continental',5,'170-200','Viveros EL OASIS','',100,6,4);
INSERT INTO producto VALUES ('OR-153','Expositor �rboles clima mediterr�neo',5,'170-200','Viveros EL OASIS','',100,6,4);
INSERT INTO producto VALUES ('OR-154','Expositor �rboles borde del mar',5,'170-200','Viveros EL OASIS','',100,6,4);
INSERT INTO producto VALUES ('OR-155','Acer Negundo  ',5,'200-225','Viveros EL OASIS','',100,6,4);
INSERT INTO producto VALUES ('OR-156','Acer platanoides  ',5,'200-225','Viveros EL OASIS','',100,10,8);
INSERT INTO producto VALUES ('OR-157','Acer Pseudoplatanus ',5,'200-225','Viveros EL OASIS','',100,10,8);
INSERT INTO producto VALUES ('OR-158','Brachychiton Acerifolius  ',5,'200-225','Viveros EL OASIS','',100,6,4);
INSERT INTO producto VALUES ('OR-159','Brachychiton Discolor  ',5,'200-225','Viveros EL OASIS','',100,6,4);
INSERT INTO producto VALUES ('OR-160','Brachychiton Rupestris',5,'170-200','Viveros EL OASIS','',100,10,8);
INSERT INTO producto VALUES ('OR-161','Cassia Corimbosa  ',5,'200-225','Viveros EL OASIS','',100,6,4);
INSERT INTO producto VALUES ('OR-162','Cassia Corimbosa ',5,'200-225','Viveros EL OASIS','',100,10,8);
INSERT INTO producto VALUES ('OR-163','Chitalpa Summer Bells   ',5,'200-225','Viveros EL OASIS','',80,10,8);
INSERT INTO producto VALUES ('OR-164','Erytrina Kafra',5,'170-180','Viveros EL OASIS','',80,6,4);
INSERT INTO producto VALUES ('OR-165','Erytrina Kafra',5,'200-225','Viveros EL OASIS','',80,10,8);
INSERT INTO producto VALUES ('OR-166','Eucalyptus Citriodora  ',5,'170-200','Viveros EL OASIS','',80,6,4);
INSERT INTO producto VALUES ('OR-167','Eucalyptus Ficifolia  ',5,'170-200','Viveros EL OASIS','',80,6,4);
INSERT INTO producto VALUES ('OR-168','Eucalyptus Ficifolia   ',5,'200-225','Viveros EL OASIS','',80,10,8);
INSERT INTO producto VALUES ('OR-169','Hibiscus Syriacus  Var. Injertadas 1 Tallo ',5,'170-200','Viveros EL OASIS','',80,12,9);
INSERT INTO producto VALUES ('OR-170','Lagunaria Patersonii  ',5,'140-150','Viveros EL OASIS','',80,6,4);
INSERT INTO producto VALUES ('OR-171','Lagunaria Patersonii   ',5,'200-225','Viveros EL OASIS','',80,10,8);
INSERT INTO producto VALUES ('OR-172','Lagunaria patersonii  calibre 8/10',5,'200-225','Viveros EL OASIS','',80,18,14);
INSERT INTO producto VALUES ('OR-173','Morus Alba  ',5,'200-225','Viveros EL OASIS','',80,6,4);
INSERT INTO producto VALUES ('OR-174','Morus Alba  calibre 8/10',5,'200-225','Viveros EL OASIS','',80,18,14);
INSERT INTO producto VALUES ('OR-175','Platanus Acerifolia   ',5,'200-225','Viveros EL OASIS','',80,10,8);
INSERT INTO producto VALUES ('OR-176','Prunus pisardii  ',5,'200-225','Viveros EL OASIS','',80,10,8);
INSERT INTO producto VALUES ('OR-177','Robinia Pseudoacacia Casque Rouge   ',5,'200-225','Viveros EL OASIS','',80,15,12);
INSERT INTO producto VALUES ('OR-178','Salix Babylonica  Pendula  ',5,'170-200','Viveros EL OASIS','',80,6,4);
INSERT INTO producto VALUES ('OR-179','Sesbania Punicea   ',5,'170-200','Viveros EL OASIS','',80,6,4);
INSERT INTO producto VALUES ('OR-180','Tamarix  Ramosissima Pink Cascade   ',5,'170-200','Viveros EL OASIS','',80,6,4);
INSERT INTO producto VALUES ('OR-181','Tamarix  Ramosissima Pink Cascade   ',5,'200-225','Viveros EL OASIS','',80,10,8);
INSERT INTO producto VALUES ('OR-182','Tecoma Stands   ',5,'200-225','Viveros EL OASIS','',80,6,4);
INSERT INTO producto VALUES ('OR-183','Tecoma Stands  ',5,'200-225','Viveros EL OASIS','',80,10,8);
INSERT INTO producto VALUES ('OR-184','Tipuana Tipu  ',5,'170-200','Viveros EL OASIS','',80,6,4);
INSERT INTO producto VALUES ('OR-185','Pleioblastus distichus-Bamb� enano',5,'15-20','Viveros EL OASIS','',80,6,4);
INSERT INTO producto VALUES ('OR-186','Sasa palmata ',5,'20-30','Viveros EL OASIS','',80,6,4);
INSERT INTO producto VALUES ('OR-187','Sasa palmata ',5,'40-45','Viveros EL OASIS','',80,10,8);
INSERT INTO producto VALUES ('OR-188','Sasa palmata ',5,'50-60','Viveros EL OASIS','',80,25,20);
INSERT INTO producto VALUES ('OR-189','Phylostachys aurea',5,'180-200','Viveros EL OASIS','',80,22,17);
INSERT INTO producto VALUES ('OR-190','Phylostachys aurea',5,'250-300','Viveros EL OASIS','',80,32,25);
INSERT INTO producto VALUES ('OR-191','Phylostachys Bambusa Spectabilis',5,'180-200','Viveros EL OASIS','',80,24,19);
INSERT INTO producto VALUES ('OR-192','Phylostachys biseti',5,'160-170','Viveros EL OASIS','',80,22,17);
INSERT INTO producto VALUES ('OR-193','Phylostachys biseti',5,'160-180','Viveros EL OASIS','',80,20,16);
INSERT INTO producto VALUES ('OR-194','Pseudosasa japonica (Metake)',5,'225-250','Viveros EL OASIS','',80,20,16);
INSERT INTO producto VALUES ('OR-195','Pseudosasa japonica (Metake) ',5,'30-40','Viveros EL OASIS','',80,6,4);
INSERT INTO producto VALUES ('OR-196','Cedrus Deodara ',5,'80-100','Viveros EL OASIS','',80,10,8);
INSERT INTO producto VALUES ('OR-197','Cedrus Deodara \"Feeling Blue\" Novedad',5,'rastrero','Viveros EL OASIS','',80,12,9);
INSERT INTO producto VALUES ('OR-198','Juniperus chinensis \"Blue Alps\"',5,'20-30','Viveros EL OASIS','',80,4,3);
INSERT INTO producto VALUES ('OR-199','Juniperus Chinensis Stricta',5,'20-30','Viveros EL OASIS','',80,4,3);
INSERT INTO producto VALUES ('OR-200','Juniperus horizontalis Wiltonii',5,'20-30','Viveros EL OASIS','',80,4,3);
INSERT INTO producto VALUES ('OR-201','Juniperus squamata \"Blue Star\"',5,'20-30','Viveros EL OASIS','',80,4,3);
INSERT INTO producto VALUES ('OR-202','Juniperus x media Phitzeriana verde',5,'20-30','Viveros EL OASIS','',80,4,3);
INSERT INTO producto VALUES ('OR-203','Pinus Canariensis',5,'80-100','Viveros EL OASIS','',80,10,8);
INSERT INTO producto VALUES ('OR-204','Pinus Halepensis',5,'160-180','Viveros EL OASIS','',80,10,8);
INSERT INTO producto VALUES ('OR-205','Pinus Pinea -Pino Pi�onero',5,'70-80','Viveros EL OASIS','',80,10,8);
INSERT INTO producto VALUES ('OR-206','Thuja Esmeralda ',5,'80-100','Viveros EL OASIS','',80,5,4);
INSERT INTO producto VALUES ('OR-207','Tuja Occidentalis Woodwardii',5,'20-30','Viveros EL OASIS','',80,4,3);
INSERT INTO producto VALUES ('OR-208','Tuja orientalis \"Aurea nana\"',5,'20-30','Viveros EL OASIS','',80,4,3);
INSERT INTO producto VALUES ('OR-209','Archontophoenix Cunninghamiana',5,'80 - 100','Viveros EL OASIS','',80,10,8);
INSERT INTO producto VALUES ('OR-210','Beucarnea Recurvata',5,'130  - 150','Viveros EL OASIS','',2,39,31);
INSERT INTO producto VALUES ('OR-211','Beucarnea Recurvata',5,'180 - 200','Viveros EL OASIS','',5,59,47);
INSERT INTO producto VALUES ('OR-212','Bismarckia Nobilis',5,'200 - 220','Viveros EL OASIS','',4,217,173);
INSERT INTO producto VALUES ('OR-213','Bismarckia Nobilis',5,'240 - 260','Viveros EL OASIS','',4,266,212);
INSERT INTO producto VALUES ('OR-214','Brahea Armata',5,'45 - 60','Viveros EL OASIS','',0,10,8);
INSERT INTO producto VALUES ('OR-215','Brahea Armata',5,'120 - 140','Viveros EL OASIS','',100,112,89);
INSERT INTO producto VALUES ('OR-216','Brahea Edulis',5,'80 - 100','Viveros EL OASIS','',100,19,15);
INSERT INTO producto VALUES ('OR-217','Brahea Edulis',5,'140 - 160','Viveros EL OASIS','',100,64,51);
INSERT INTO producto VALUES ('OR-218','Butia Capitata',5,'70 - 90','Viveros EL OASIS','',100,25,20);
INSERT INTO producto VALUES ('OR-219','Butia Capitata',5,'90 - 110','Viveros EL OASIS','',100,29,23);
INSERT INTO producto VALUES ('OR-220','Butia Capitata',5,'90 - 120','Viveros EL OASIS','',100,36,28);
INSERT INTO producto VALUES ('OR-221','Butia Capitata',5,'85 - 105','Viveros EL OASIS','',100,59,47);
INSERT INTO producto VALUES ('OR-222','Butia Capitata',5,'130 - 150','Viveros EL OASIS','',100,87,69);
INSERT INTO producto VALUES ('OR-223','Chamaerops Humilis',5,'40 - 45','Viveros EL OASIS','',100,4,3);
INSERT INTO producto VALUES ('OR-224','Chamaerops Humilis',5,'50 - 60','Viveros EL OASIS','',100,7,5);
INSERT INTO producto VALUES ('OR-225','Chamaerops Humilis',5,'70 - 90','Viveros EL OASIS','',100,10,8);
INSERT INTO producto VALUES ('OR-226','Chamaerops Humilis',5,'115 - 130','Viveros EL OASIS','',100,38,30);
INSERT INTO producto VALUES ('OR-227','Chamaerops Humilis',5,'130 - 150','Viveros EL OASIS','',100,64,51);
INSERT INTO producto VALUES ('OR-228','Chamaerops Humilis \"Cerifera\"',5,'70 - 80','Viveros EL OASIS','',100,32,25);
INSERT INTO producto VALUES ('OR-229','Chrysalidocarpus Lutescens -ARECA',5,'130 - 150','Viveros EL OASIS','',100,22,17);
INSERT INTO producto VALUES ('OR-230','Cordyline Australis -DRACAENA',5,'190 - 210','Viveros EL OASIS','',100,38,30);
INSERT INTO producto VALUES ('OR-231','Cycas Revoluta',5,'55 - 65','Viveros EL OASIS','',100,15,12);
INSERT INTO producto VALUES ('OR-232','Cycas Revoluta',5,'80 - 90','Viveros EL OASIS','',100,34,27);
INSERT INTO producto VALUES ('OR-233','Dracaena Drago',5,'60 - 70','Viveros EL OASIS','',1,13,10);
INSERT INTO producto VALUES ('OR-234','Dracaena Drago',5,'130 - 150','Viveros EL OASIS','',2,64,51);
INSERT INTO producto VALUES ('OR-235','Dracaena Drago',5,'150 - 175','Viveros EL OASIS','',2,92,73);
INSERT INTO producto VALUES ('OR-236','Jubaea Chilensis',5,'','Viveros EL OASIS','',100,49,39);
INSERT INTO producto VALUES ('OR-237','Livistonia Australis',5,'100 - 125','Viveros EL OASIS','',50,19,15);
INSERT INTO producto VALUES ('OR-238','Livistonia Decipiens',5,'90 - 110','Viveros EL OASIS','',50,19,15);
INSERT INTO producto VALUES ('OR-239','Livistonia Decipiens',5,'180 - 200','Viveros EL OASIS','',50,49,39);
INSERT INTO producto VALUES ('OR-240','Phoenix Canariensis',5,'110 - 130','Viveros EL OASIS','',50,6,4);
INSERT INTO producto VALUES ('OR-241','Phoenix Canariensis',5,'180 - 200','Viveros EL OASIS','',50,19,15);
INSERT INTO producto VALUES ('OR-242','Rhaphis Excelsa',5,'80 - 100','Viveros EL OASIS','',50,21,16);
INSERT INTO producto VALUES ('OR-243','Rhaphis Humilis',5,'150- 170','Viveros EL OASIS','',50,64,51);
INSERT INTO producto VALUES ('OR-244','Sabal Minor',5,'60 - 75','Viveros EL OASIS','',50,11,8);
INSERT INTO producto VALUES ('OR-245','Sabal Minor',5,'120 - 140','Viveros EL OASIS','',50,34,27);
INSERT INTO producto VALUES ('OR-246','Trachycarpus Fortunei',5,'90 - 105','Viveros EL OASIS','',50,18,14);
INSERT INTO producto VALUES ('OR-247','Trachycarpus Fortunei',5,'250-300','Viveros EL OASIS','',2,462,369);
INSERT INTO producto VALUES ('OR-248','Washingtonia Robusta',5,'60 - 70','Viveros EL OASIS','',15,3,2);
INSERT INTO producto VALUES ('OR-249','Washingtonia Robusta',5,'130 - 150','Viveros EL OASIS','',15,5,4);
INSERT INTO producto VALUES ('OR-250','Yucca Jewel',5,'80 - 105','Viveros EL OASIS','',15,10,8);
INSERT INTO producto VALUES ('OR-251','Zamia Furfuracaea',5,'90 - 110','Viveros EL OASIS','',15,168,134);
INSERT INTO producto VALUES ('OR-99','Mimosa DEALBATA Gaulois Astier  ',5,'200-225','Viveros EL OASIS','Acacia dealbata. Nombre com�n o vulgar: Mimosa fina, Mimosa, Mimosa com�n, Mimosa plateada, Aromo franc�s. Familia: Mimosaceae. Origen: Australia, Sureste, (N. G. del Sur y Victoria). Arbol de follaje persistente muy usado en parques por su atractiva floraci�n amarilla hacia fines del invierno. Altura: de 3 a 10 metros generalmente. Crecimiento r�pido. Follaje perenne de tonos plateados, muy ornamental. Sus hojas son de textura fina, de color verde y sus flores amarillas que aparecen en racimos grandes. Florece de Enero a Marzo (Hemisferio Norte). Legumbre de 5-9 cm de longitud, recta o ligeramente curvada, con los bordes algo constre�idos entre las semillas, que se disponen en el fruto longitudinalmente...',100,14,11);

INSERT INTO detalle_pedido VALUES (1,87,10,70,3);
INSERT INTO detalle_pedido VALUES (1,151,40,4,1);
INSERT INTO detalle_pedido VALUES (1,165,25,4,2);
INSERT INTO detalle_pedido VALUES (1,265,15,19,4);
INSERT INTO detalle_pedido VALUES (1,276,23,14,5);
INSERT INTO detalle_pedido VALUES (2,57,3,29,6);
INSERT INTO detalle_pedido VALUES (2,58,7,8,7);
INSERT INTO detalle_pedido VALUES (2,164,50,4,3);
INSERT INTO detalle_pedido VALUES (2,165,20,5,2);
INSERT INTO detalle_pedido VALUES (2,183,12,6,5);
INSERT INTO detalle_pedido VALUES (2,251,67,64,1);
INSERT INTO detalle_pedido VALUES (2,271,5,462,4);
INSERT INTO detalle_pedido VALUES (3,66,120,9,6);
INSERT INTO detalle_pedido VALUES (3,146,32,5,4);
INSERT INTO detalle_pedido VALUES (3,147,11,5,5);
INSERT INTO detalle_pedido VALUES (3,237,30,266,1);
INSERT INTO detalle_pedido VALUES (3,241,15,65,2);
INSERT INTO detalle_pedido VALUES (3,242,24,25,3);
INSERT INTO detalle_pedido VALUES (4,48,12,8,7);
INSERT INTO detalle_pedido VALUES (4,51,42,8,6);
INSERT INTO detalle_pedido VALUES (4,58,42,9,8);
INSERT INTO detalle_pedido VALUES (4,176,3,6,5);
INSERT INTO detalle_pedido VALUES (4,179,4,6,3);
INSERT INTO detalle_pedido VALUES (4,180,17,9,4);
INSERT INTO detalle_pedido VALUES (4,181,38,10,2);
INSERT INTO detalle_pedido VALUES (4,246,21,59,1);
INSERT INTO detalle_pedido VALUES (8,23,3,11,1);
INSERT INTO detalle_pedido VALUES (8,25,1,32,2);
INSERT INTO detalle_pedido VALUES (8,26,10,100,3);
INSERT INTO detalle_pedido VALUES (9,5,80,1,3);
INSERT INTO detalle_pedido VALUES (9,12,450,1,2);
INSERT INTO detalle_pedido VALUES (9,23,80,8,1);
INSERT INTO detalle_pedido VALUES (9,89,15,91,2);
INSERT INTO detalle_pedido VALUES (10,104,5,70,2);
INSERT INTO detalle_pedido VALUES (10,114,30,75,1);
INSERT INTO detalle_pedido VALUES (10,258,5,64,3);
INSERT INTO detalle_pedido VALUES (11,10,180,1,3);
INSERT INTO detalle_pedido VALUES (11,271,80,8,1);
INSERT INTO detalle_pedido VALUES (12,13,290,1,1);
INSERT INTO detalle_pedido VALUES (13,1,5,14,1);
INSERT INTO detalle_pedido VALUES (13,2,12,14,2);
INSERT INTO detalle_pedido VALUES (13,26,5,100,3);
INSERT INTO detalle_pedido VALUES (14,17,8,11,2);
INSERT INTO detalle_pedido VALUES (14,28,13,57,1);
INSERT INTO detalle_pedido VALUES (15,106,4,13,3);
INSERT INTO detalle_pedido VALUES (15,125,2,6,2);
INSERT INTO detalle_pedido VALUES (15,180,6,10,1);
INSERT INTO detalle_pedido VALUES (15,227,9,10,4);
INSERT INTO detalle_pedido VALUES (16,4,12,12,1);
INSERT INTO detalle_pedido VALUES (16,53,10,9,2);
INSERT INTO detalle_pedido VALUES (17,1,5,14,1);
INSERT INTO detalle_pedido VALUES (17,3,5,12,3);
INSERT INTO detalle_pedido VALUES (17,54,5,9,2);
INSERT INTO detalle_pedido VALUES (17,84,5,22,4);
INSERT INTO detalle_pedido VALUES (17,160,5,18,5);
INSERT INTO detalle_pedido VALUES (18,3,4,12,2);
INSERT INTO detalle_pedido VALUES (18,38,2,4,1);
INSERT INTO detalle_pedido VALUES (18,183,10,6,3);
INSERT INTO detalle_pedido VALUES (19,4,9,12,5);
INSERT INTO detalle_pedido VALUES (19,39,6,8,4);
INSERT INTO detalle_pedido VALUES (19,96,1,32,2);
INSERT INTO detalle_pedido VALUES (19,106,5,13,1);
INSERT INTO detalle_pedido VALUES (19,232,20,4,3);
INSERT INTO detalle_pedido VALUES (20,1,14,14,1);
INSERT INTO detalle_pedido VALUES (20,4,8,12,2);
INSERT INTO detalle_pedido VALUES (21,2,5,14,3);
INSERT INTO detalle_pedido VALUES (21,33,22,4,1);
INSERT INTO detalle_pedido VALUES (21,72,3,8,2);
INSERT INTO detalle_pedido VALUES (22,264,1,6,1);
INSERT INTO detalle_pedido VALUES (23,6,110,1,4);
INSERT INTO detalle_pedido VALUES (23,24,50,22,3);
INSERT INTO detalle_pedido VALUES (23,107,4,70,2);
INSERT INTO detalle_pedido VALUES (23,273,30,5,1);
INSERT INTO detalle_pedido VALUES (24,3,3,15,1);
INSERT INTO detalle_pedido VALUES (24,15,4,7,4);
INSERT INTO detalle_pedido VALUES (24,39,2,7,2);
INSERT INTO detalle_pedido VALUES (24,265,10,20,3);
INSERT INTO detalle_pedido VALUES (25,98,15,69,1);
INSERT INTO detalle_pedido VALUES (25,112,4,30,3);
INSERT INTO detalle_pedido VALUES (25,117,10,30,2);
INSERT INTO detalle_pedido VALUES (26,30,9,25,3);
INSERT INTO detalle_pedido VALUES (26,212,4,25,1);
INSERT INTO detalle_pedido VALUES (26,242,14,25,2);
INSERT INTO detalle_pedido VALUES (27,125,22,6,2);
INSERT INTO detalle_pedido VALUES (27,126,22,6,3);
INSERT INTO detalle_pedido VALUES (27,210,40,6,1);
INSERT INTO detalle_pedido VALUES (28,26,8,99,3);
INSERT INTO detalle_pedido VALUES (28,237,3,266,2);
INSERT INTO detalle_pedido VALUES (28,271,1,462,1);
INSERT INTO detalle_pedido VALUES (29,104,4,70,4);
INSERT INTO detalle_pedido VALUES (29,112,4,28,1);
INSERT INTO detalle_pedido VALUES (29,117,20,31,5);
INSERT INTO detalle_pedido VALUES (29,153,2,111,2);
INSERT INTO detalle_pedido VALUES (29,184,10,9,3);
INSERT INTO detalle_pedido VALUES (30,8,10,1,6);
INSERT INTO detalle_pedido VALUES (30,25,2,32,2);
INSERT INTO detalle_pedido VALUES (30,27,2,19,3);
INSERT INTO detalle_pedido VALUES (30,93,4,31,5);
INSERT INTO detalle_pedido VALUES (30,111,10,45,1);
INSERT INTO detalle_pedido VALUES (30,144,5,5,4);
INSERT INTO detalle_pedido VALUES (31,13,25,2,3);
INSERT INTO detalle_pedido VALUES (31,19,1,20,1);
INSERT INTO detalle_pedido VALUES (31,57,6,29,2);
INSERT INTO detalle_pedido VALUES (32,1,1,14,4);
INSERT INTO detalle_pedido VALUES (32,2,4,15,5);
INSERT INTO detalle_pedido VALUES (32,3,1,15,3);
INSERT INTO detalle_pedido VALUES (32,152,29,100,2);
INSERT INTO detalle_pedido VALUES (32,217,5,20,1);
INSERT INTO detalle_pedido VALUES (33,32,423,2,4);
INSERT INTO detalle_pedido VALUES (33,45,120,8,3);
INSERT INTO detalle_pedido VALUES (33,238,212,10,2);
INSERT INTO detalle_pedido VALUES (33,271,150,462,1);
INSERT INTO detalle_pedido VALUES (34,46,56,7,4);
INSERT INTO detalle_pedido VALUES (34,90,12,29,3);
INSERT INTO detalle_pedido VALUES (34,196,20,18,1);
INSERT INTO detalle_pedido VALUES (34,198,24,18,2);
INSERT INTO detalle_pedido VALUES (35,2,12,14,4);
INSERT INTO detalle_pedido VALUES (35,65,55,8,3);
INSERT INTO detalle_pedido VALUES (35,189,3,10,2);
INSERT INTO detalle_pedido VALUES (35,205,36,10,1);
INSERT INTO detalle_pedido VALUES (35,249,72,10,5);
INSERT INTO detalle_pedido VALUES (36,4,4,12,2);
INSERT INTO detalle_pedido VALUES (36,15,2,7,3);
INSERT INTO detalle_pedido VALUES (36,171,6,7,4);
INSERT INTO detalle_pedido VALUES (36,227,1,12,5);
INSERT INTO detalle_pedido VALUES (36,276,15,13,1);
INSERT INTO detalle_pedido VALUES (37,22,4,70,1);
INSERT INTO detalle_pedido VALUES (37,76,203,8,2);
INSERT INTO detalle_pedido VALUES (37,200,38,10,3);
INSERT INTO detalle_pedido VALUES (38,1,5,14,1);
INSERT INTO detalle_pedido VALUES (38,2,2,14,2);
INSERT INTO detalle_pedido VALUES (39,3,3,12,1);
INSERT INTO detalle_pedido VALUES (39,4,6,12,2);
INSERT INTO detalle_pedido VALUES (40,5,4,1,1);
INSERT INTO detalle_pedido VALUES (40,6,8,1,2);
INSERT INTO detalle_pedido VALUES (41,7,5,1,1);
INSERT INTO detalle_pedido VALUES (41,8,5,1,2);
INSERT INTO detalle_pedido VALUES (42,9,3,1,1);
INSERT INTO detalle_pedido VALUES (42,10,1,1,2);
INSERT INTO detalle_pedido VALUES (43,11,9,1,1);
INSERT INTO detalle_pedido VALUES (44,12,5,1,1);
INSERT INTO detalle_pedido VALUES (45,13,6,1,1);
INSERT INTO detalle_pedido VALUES (45,14,4,1,2);
INSERT INTO detalle_pedido VALUES (46,15,4,7,1);
INSERT INTO detalle_pedido VALUES (46,16,8,7,2);
INSERT INTO detalle_pedido VALUES (47,17,9,11,1);
INSERT INTO detalle_pedido VALUES (47,18,5,13,2);
INSERT INTO detalle_pedido VALUES (48,19,1,18,1);
INSERT INTO detalle_pedido VALUES (48,20,1,25,2);
INSERT INTO detalle_pedido VALUES (48,258,50,64,1);
INSERT INTO detalle_pedido VALUES (48,260,45,49,2);
INSERT INTO detalle_pedido VALUES (48,261,50,19,3);
INSERT INTO detalle_pedido VALUES (49,228,50,10,1);
INSERT INTO detalle_pedido VALUES (49,229,10,10,2);
INSERT INTO detalle_pedido VALUES (49,230,5,5,3);
INSERT INTO detalle_pedido VALUES (50,249,12,10,1);
INSERT INTO detalle_pedido VALUES (50,250,15,38,2);
INSERT INTO detalle_pedido VALUES (50,251,44,64,3);
INSERT INTO detalle_pedido VALUES (51,233,50,10,1);
INSERT INTO detalle_pedido VALUES (51,234,80,39,2);
INSERT INTO detalle_pedido VALUES (51,235,70,59,3);
INSERT INTO detalle_pedido VALUES (53,35,1,7,1);
INSERT INTO detalle_pedido VALUES (53,107,1,70,3);
INSERT INTO detalle_pedido VALUES (53,108,2,11,2);
INSERT INTO detalle_pedido VALUES (53,140,6,7,4);
INSERT INTO detalle_pedido VALUES (54,1,3,14,3);
INSERT INTO detalle_pedido VALUES (54,17,45,10,2);
INSERT INTO detalle_pedido VALUES (54,33,5,4,1);
INSERT INTO detalle_pedido VALUES (54,100,3,22,4);
INSERT INTO detalle_pedido VALUES (54,140,8,7,6);
INSERT INTO detalle_pedido VALUES (54,147,3,5,5);
INSERT INTO detalle_pedido VALUES (54,192,2,10,7);
INSERT INTO detalle_pedido VALUES (55,139,9,7,1);
INSERT INTO detalle_pedido VALUES (55,237,2,266,2);
INSERT INTO detalle_pedido VALUES (55,251,6,64,5);
INSERT INTO detalle_pedido VALUES (55,267,2,64,4);
INSERT INTO detalle_pedido VALUES (55,271,1,462,3);
INSERT INTO detalle_pedido VALUES (56,153,1,115,5);
INSERT INTO detalle_pedido VALUES (56,154,10,18,6);
INSERT INTO detalle_pedido VALUES (56,203,1,6,3);
INSERT INTO detalle_pedido VALUES (56,220,3,10,4);
INSERT INTO detalle_pedido VALUES (56,231,4,4,2);
INSERT INTO detalle_pedido VALUES (56,274,3,10,1);
INSERT INTO detalle_pedido VALUES (57,89,6,91,4);
INSERT INTO detalle_pedido VALUES (57,103,3,49,3);
INSERT INTO detalle_pedido VALUES (57,106,2,13,1);
INSERT INTO detalle_pedido VALUES (57,117,6,9,2);
INSERT INTO detalle_pedido VALUES (58,126,65,18,3);
INSERT INTO detalle_pedido VALUES (58,163,80,4,1);
INSERT INTO detalle_pedido VALUES (58,196,69,15,2);
INSERT INTO detalle_pedido VALUES (58,201,150,15,4);
INSERT INTO detalle_pedido VALUES (74,87,15,70,1);
INSERT INTO detalle_pedido VALUES (74,251,34,64,2);
INSERT INTO detalle_pedido VALUES (74,271,42,8,3);
INSERT INTO detalle_pedido VALUES (75,10,60,1,2);
INSERT INTO detalle_pedido VALUES (75,109,24,22,3);
INSERT INTO detalle_pedido VALUES (75,181,46,10,1);
INSERT INTO detalle_pedido VALUES (76,13,250,1,5);
INSERT INTO detalle_pedido VALUES (76,100,40,22,3);
INSERT INTO detalle_pedido VALUES (76,109,24,22,4);
INSERT INTO detalle_pedido VALUES (76,117,35,9,1);
INSERT INTO detalle_pedido VALUES (76,220,25,10,2);
INSERT INTO detalle_pedido VALUES (77,3,34,12,2);
INSERT INTO detalle_pedido VALUES (77,4,15,12,1);
INSERT INTO detalle_pedido VALUES (78,72,25,8,2);
INSERT INTO detalle_pedido VALUES (78,107,56,70,3);
INSERT INTO detalle_pedido VALUES (78,181,42,10,4);
INSERT INTO detalle_pedido VALUES (78,232,30,4,1);
INSERT INTO detalle_pedido VALUES (79,264,50,6,1);
INSERT INTO detalle_pedido VALUES (80,26,40,100,3);
INSERT INTO detalle_pedido VALUES (80,53,47,9,2);
INSERT INTO detalle_pedido VALUES (80,160,75,18,1);
INSERT INTO detalle_pedido VALUES (81,232,30,4,1);
INSERT INTO detalle_pedido VALUES (82,251,34,64,1);
INSERT INTO detalle_pedido VALUES (83,232,30,4,1);
INSERT INTO detalle_pedido VALUES (89,25,3,32,2);
INSERT INTO detalle_pedido VALUES (89,46,15,7,6);
INSERT INTO detalle_pedido VALUES (89,60,12,8,4);
INSERT INTO detalle_pedido VALUES (89,86,5,49,1);
INSERT INTO detalle_pedido VALUES (89,109,4,22,3);
INSERT INTO detalle_pedido VALUES (89,181,8,10,5);
INSERT INTO detalle_pedido VALUES (90,5,19,1,1);
INSERT INTO detalle_pedido VALUES (90,6,10,1,2);
INSERT INTO detalle_pedido VALUES (90,7,12,1,3);
INSERT INTO detalle_pedido VALUES (91,17,52,11,1);
INSERT INTO detalle_pedido VALUES (91,18,14,13,2);
INSERT INTO detalle_pedido VALUES (91,19,35,18,3);
INSERT INTO detalle_pedido VALUES (92,25,12,23,1);
INSERT INTO detalle_pedido VALUES (92,26,20,100,2);
INSERT INTO detalle_pedido VALUES (92,27,30,21,3);
INSERT INTO detalle_pedido VALUES (93,73,25,9,1);
INSERT INTO detalle_pedido VALUES (93,77,51,11,2);
INSERT INTO detalle_pedido VALUES (93,80,3,32,3);
INSERT INTO detalle_pedido VALUES (94,1,12,14,1);
INSERT INTO detalle_pedido VALUES (94,26,33,100,3);
INSERT INTO detalle_pedido VALUES (94,57,79,29,2);
INSERT INTO detalle_pedido VALUES (95,16,9,7,2);
INSERT INTO detalle_pedido VALUES (95,96,6,32,1);
INSERT INTO detalle_pedido VALUES (95,104,5,70,3);
INSERT INTO detalle_pedido VALUES (96,61,6,8,1);
INSERT INTO detalle_pedido VALUES (96,79,16,7,4);
INSERT INTO detalle_pedido VALUES (96,92,10,22,3);
INSERT INTO detalle_pedido VALUES (96,113,4,70,2);
INSERT INTO detalle_pedido VALUES (97,59,12,8,1);
INSERT INTO detalle_pedido VALUES (97,73,14,9,2);
INSERT INTO detalle_pedido VALUES (97,180,10,10,3);
INSERT INTO detalle_pedido VALUES (98,50,14,8,4);
INSERT INTO detalle_pedido VALUES (98,75,16,8,3);
INSERT INTO detalle_pedido VALUES (98,80,8,32,1);
INSERT INTO detalle_pedido VALUES (98,101,18,6,5);
INSERT INTO detalle_pedido VALUES (98,107,6,70,2);
INSERT INTO detalle_pedido VALUES (99,181,15,10,2);
INSERT INTO detalle_pedido VALUES (99,251,30,64,1);
INSERT INTO detalle_pedido VALUES (100,109,20,22,1);
INSERT INTO detalle_pedido VALUES (100,117,40,9,2);
INSERT INTO detalle_pedido VALUES (101,10,50,1,1);
INSERT INTO detalle_pedido VALUES (101,13,159,1,2);
INSERT INTO detalle_pedido VALUES (102,3,32,12,2);
INSERT INTO detalle_pedido VALUES (102,4,23,12,1);
INSERT INTO detalle_pedido VALUES (103,72,12,8,2);
INSERT INTO detalle_pedido VALUES (103,232,52,4,1);
INSERT INTO detalle_pedido VALUES (104,107,9,70,1);
INSERT INTO detalle_pedido VALUES (104,181,113,10,2);
INSERT INTO detalle_pedido VALUES (105,251,21,64,2);
INSERT INTO detalle_pedido VALUES (105,264,27,6,1);
INSERT INTO detalle_pedido VALUES (106,13,231,1,1);
INSERT INTO detalle_pedido VALUES (106,160,47,18,2);
INSERT INTO detalle_pedido VALUES (107,4,143,12,2);
INSERT INTO detalle_pedido VALUES (107,26,15,100,1);
INSERT INTO detalle_pedido VALUES (108,72,53,8,1);
INSERT INTO detalle_pedido VALUES (108,232,59,4,2);
INSERT INTO detalle_pedido VALUES (109,38,8,4,5);
INSERT INTO detalle_pedido VALUES (109,53,12,9,3);
INSERT INTO detalle_pedido VALUES (109,63,14,8,4);
INSERT INTO detalle_pedido VALUES (109,128,20,10,1);
INSERT INTO detalle_pedido VALUES (109,143,10,5,2);
INSERT INTO detalle_pedido VALUES (109,149,3,5,6);
INSERT INTO detalle_pedido VALUES (109,154,2,18,7);
INSERT INTO detalle_pedido VALUES (110,14,6,1,3);
INSERT INTO detalle_pedido VALUES (110,15,14,7,1);
INSERT INTO detalle_pedido VALUES (110,31,1,45,2);
INSERT INTO detalle_pedido VALUES (115,2,5,14,1);
INSERT INTO detalle_pedido VALUES (115,5,32,1,2);
INSERT INTO detalle_pedido VALUES (115,9,18,1,5);
INSERT INTO detalle_pedido VALUES (115,50,13,8,3);
INSERT INTO detalle_pedido VALUES (115,224,10,4,4);
INSERT INTO detalle_pedido VALUES (114,99,2,15,1);
INSERT INTO detalle_pedido VALUES (114,102,1,32,3);
INSERT INTO detalle_pedido VALUES (114,170,17,4,2);
INSERT INTO detalle_pedido VALUES (114,203,4,6,4);
INSERT INTO detalle_pedido VALUES (110,8,15,1,1);
INSERT INTO detalle_pedido VALUES (110,174,18,2,2);
INSERT INTO detalle_pedido VALUES (52,87,10,70,1);
INSERT INTO detalle_pedido VALUES (59,87,10,70,1);
INSERT INTO detalle_pedido VALUES (60,87,10,70,1);
INSERT INTO detalle_pedido VALUES (61,87,10,70,1);
INSERT INTO detalle_pedido VALUES (62,87,10,70,1);
INSERT INTO detalle_pedido VALUES (63,87,10,70,1);
INSERT INTO detalle_pedido VALUES (64,87,10,70,1);
INSERT INTO detalle_pedido VALUES (65,87,10,70,1);
INSERT INTO detalle_pedido VALUES (66,87,10,70,1);
INSERT INTO detalle_pedido VALUES (67,87,10,70,1);
INSERT INTO detalle_pedido VALUES (68,87,10,70,1);
INSERT INTO detalle_pedido VALUES (111,87,10,70,1);
INSERT INTO detalle_pedido VALUES (112,87,10,70,1);
INSERT INTO detalle_pedido VALUES (113,87,10,70,1);
INSERT INTO detalle_pedido VALUES (114,87,10,70,1);
INSERT INTO detalle_pedido VALUES (115,87,10,70,1);
INSERT INTO detalle_pedido VALUES (108,87,10,70,1);
INSERT INTO detalle_pedido VALUES (109,87,10,70,1);
INSERT INTO detalle_pedido VALUES (110,87,10,70,1);
INSERT INTO detalle_pedido VALUES (101,87,10,70,1);
INSERT INTO detalle_pedido VALUES (103,87,10,70,1);
INSERT INTO detalle_pedido VALUES (104,87,10,70,1);
INSERT INTO detalle_pedido VALUES (105,87,10,70,1);
INSERT INTO detalle_pedido VALUES (102,87,10,70,1);
INSERT INTO detalle_pedido VALUES (101,87,10,70,1);
INSERT INTO detalle_pedido VALUES (100,87,10,70,1);


INSERT INTO pago VALUES (1,'PayPal','ak-std-000001','2008-11-10',2000);
INSERT INTO pago VALUES (1,'PayPal','ak-std-000002','2008-12-10',2000);
INSERT INTO pago VALUES (3,'PayPal','ak-std-000003','2009-01-16',5000);
INSERT INTO pago VALUES (3,'PayPal','ak-std-000004','2009-02-16',5000);
INSERT INTO pago VALUES (3,'PayPal','ak-std-000005','2009-02-19',926);
INSERT INTO pago VALUES (4,'PayPal','ak-std-000006','2007-01-08',20000);
INSERT INTO pago VALUES (4,'PayPal','ak-std-000007','2007-01-08',20000);
INSERT INTO pago VALUES (4,'PayPal','ak-std-000008','2007-01-08',20000);
INSERT INTO pago VALUES (4,'PayPal','ak-std-000009','2007-01-08',20000);
INSERT INTO pago VALUES (4,'PayPal','ak-std-000010','2007-01-08',1849);
INSERT INTO pago VALUES (5,'Transferencia','ak-std-000011','2006-01-18',23794);
INSERT INTO pago VALUES (7,'Cheque','ak-std-000012','2009-01-13',2390);
INSERT INTO pago VALUES (9,'PayPal','ak-std-000013','2009-01-06',929);
INSERT INTO pago VALUES (13,'PayPal','ak-std-000014','2008-08-04',2246);
INSERT INTO pago VALUES (14,'PayPal','ak-std-000015','2008-07-15',4160);
INSERT INTO pago VALUES (15,'PayPal','ak-std-000016','2009-01-15',2081);
INSERT INTO pago VALUES (15,'PayPal','ak-std-000035','2009-02-15',10000);
INSERT INTO pago VALUES (16,'PayPal','ak-std-000017','2009-02-16',4399);
INSERT INTO pago VALUES (19,'PayPal','ak-std-000018','2009-03-06',232);
INSERT INTO pago VALUES (23,'PayPal','ak-std-000019','2009-03-26',272);
INSERT INTO pago VALUES (26,'PayPal','ak-std-000020','2008-03-18',18846);
INSERT INTO pago VALUES (27,'PayPal','ak-std-000021','2009-02-08',10972);
INSERT INTO pago VALUES (28,'PayPal','ak-std-000022','2009-01-13',8489);
INSERT INTO pago VALUES (30,'PayPal','ak-std-000024','2009-01-16',7863);
INSERT INTO pago VALUES (35,'PayPal','ak-std-000025','2007-10-06',3321);
INSERT INTO pago VALUES (36,'PayPal','ak-std-000026','2006-05-26',1171);

--Crear bases de datos Staging--
create database Staging

use Staging
use jardineria
CREATE TABLE Staging_oficina (
  ID_oficina INT PRIMARY KEY,
  Descripcion VARCHAR(10),
  ciudad VARCHAR(30),
  pais VARCHAR(50),
  region VARCHAR(50),
  codigo_postal VARCHAR(10),
  telefono VARCHAR(20),
  linea_direccion1 VARCHAR(50),
  linea_direccion2 VARCHAR(50)
);

CREATE TABLE Staging_empleado (
  ID_empleado INT PRIMARY KEY,
  nombre VARCHAR(50),
  apellido1 VARCHAR(50),
  apellido2 VARCHAR(50),
  extension VARCHAR(10),
  email VARCHAR(100),
  ID_oficina INT,
  ID_jefe INT,
  puesto VARCHAR(50),
  FOREIGN KEY (ID_oficina) REFERENCES Staging_oficina(ID_oficina)
);

CREATE TABLE Staging_cliente (
  ID_cliente INT PRIMARY KEY,
  nombre_cliente VARCHAR(50),
  nombre_contacto VARCHAR(30),
  apellido_contacto VARCHAR(30),
  telefono VARCHAR(15),
  linea_direccion1 VARCHAR(50),
  ciudad VARCHAR(50),
  pais VARCHAR(50),
  codigo_postal VARCHAR(10),
  ID_empleado_rep_ventas INT,
  limite_credito NUMERIC(15, 2),
  FOREIGN KEY (ID_empleado_rep_ventas) REFERENCES Staging_empleado(ID_empleado)
);

CREATE TABLE Staging_producto (
  ID_producto VARCHAR(15) PRIMARY KEY,
  nombre VARCHAR(70),
  Categoria INT,
  cantidad_en_stock SMALLINT,
  precio_venta NUMERIC(15, 2)
);

CREATE TABLE Staging_pedido (
  ID_pedido INT PRIMARY KEY,
  fecha_pedido DATE,
  fecha_esperada DATE,
  estado VARCHAR(15),
  ID_cliente INT,
  FOREIGN KEY (ID_cliente) REFERENCES Staging_cliente(ID_cliente)
);

CREATE TABLE Staging_detalle_pedido (
  ID_pedido INT,
  ID_producto VARCHAR(15),
  cantidad INT,
  precio_unidad NUMERIC(15, 2),
  PRIMARY KEY (ID_pedido, ID_producto),
  FOREIGN KEY (ID_pedido) REFERENCES Staging_pedido(ID_pedido),
  FOREIGN KEY (ID_producto) REFERENCES Staging_producto(ID_producto)
);

/*Migrar datos a Staging oficina*/
INSERT INTO Staging.dbo.Staging_oficina(ID_oficina, Descripcion, ciudad, pais, region, codigo_postal, telefono, linea_direccion1, linea_direccion2)
SELECT ID_oficina, Descripcion, ciudad, pais, region, codigo_postal, telefono, linea_direccion1, linea_direccion2
FROM jardineria.dbo.oficina oficina;
 
/*Migrar datos a Staging empleado*/
INSERT INTO  Staging.dbo.Staging_empleado (ID_empleado, nombre, apellido1, apellido2, extension, email, ID_oficina, ID_jefe, puesto)
SELECT ID_empleado, nombre, apellido1, apellido2, extension, email, ID_oficina, ID_jefe, puesto
FROM jardineria.dbo.empleado;

/*Migrar datos a Staging cliente*/
INSERT INTO Staging.dbo.Staging_cliente (ID_cliente, nombre_cliente, nombre_contacto, apellido_contacto, telefono, linea_direccion1, ciudad, pais, codigo_postal, ID_empleado_rep_ventas, limite_credito)
SELECT ID_cliente, nombre_cliente, nombre_contacto, apellido_contacto, telefono, linea_direccion1, ciudad, pais, codigo_postal, ID_empleado_rep_ventas, limite_credito
FROM jardineria.dbo.cliente;

/*Migrar datos a Staging producto*/
INSERT INTO Staging.dbo.Staging_producto (ID_producto, nombre, Categoria, cantidad_en_stock, precio_venta)
SELECT ID_producto, nombre, Categoria, cantidad_en_stock, precio_venta
FROM Jardineria.dbo.producto;

/*Migrar datos a Staging pedido*/
INSERT INTO Staging.dbo.Staging_pedido (ID_pedido, fecha_pedido, fecha_esperada, estado, ID_cliente)
SELECT ID_pedido, fecha_pedido, fecha_esperada, estado, ID_cliente
FROM Jardineria.dbo.pedido;

/*Migrar datos a Staging detalle de pedido*/
INSERT INTO Staging.dbo.Staging_detalle_pedido (ID_pedido, ID_producto, cantidad, precio_unidad)
SELECT DISTINCT  ID_pedido, ID_producto, cantidad, precio_unidad
FROM Jardineria.dbo.detalle_pedido;

--Transformaci�n de datos--

UPDATE Staging.dbo.Staging_pedido
SET fecha_esperada = DATEADD(DAY, 5, fecha_pedido);

ALTER TABLE Staging.dbo.Staging_cliente
ADD segmento_credito VARCHAR(20);

-- Asignar categor�as basadas en el l�mite de cr�dito
UPDATE Staging.dbo.Staging_cliente
SET segmento_credito = 
    CASE 
        WHEN limite_credito > 50000 THEN 'Alto'
        WHEN limite_credito BETWEEN 20000 AND 50000 THEN 'Medio'
        ELSE 'Bajo'
    END;
select * from Staging.dbo.Staging_cliente

ALTER TABLE Staging.dbo.Staging_pedido
ADD dias_desde_pedido INT;

-- Actualizar con la diferencia en d�as
UPDATE Staging.dbo.Staging_pedido
SET dias_desde_pedido = DATEDIFF(DAY, fecha_pedido, GETDATE());


-- Convertir todos los nombres a may�sculas
UPDATE Staging.dbo.Staging_empleado
SET nombre = UPPER(nombre);

-- Capitalizar la primera letra de cada palabra (en SQL Server 2017 o superior)
UPDATE  Staging.dbo.Staging_empleado
SET nombre = CONCAT(UPPER(LEFT(nombre, 1)), LOWER(SUBSTRING(nombre, 2, LEN(nombre))));

select * from Staging.dbo.Staging_empleado

--Cargas datos al Data Mart--

Create Database DataMarFinal

use DataMarFinal

CREATE TABLE DataMart_Hecho_Pedido (
  ID_pedido INT PRIMARY KEY,
  Fecha_pedido DATE,
  ID_cliente INT,
  ID_empleado INT,
  ID_producto VARCHAR(15),
  Cantidad INT,
  Precio_unidad NUMERIC(15,2),
  Total NUMERIC(15,2)
);

-- Insertar los Pedidos desde Staging.pedido--
INSERT INTO DataMarFinal.dbo.DataMart_Hecho_Pedido(ID_pedido, Fecha_pedido, ID_cliente, ID_empleado, ID_producto, Cantidad, Precio_unidad, Total)
SELECT ID_pedido, fecha_pedido, ID_cliente, ID_empleado, ID_producto, cantidad, precio_unidad, Total
FROM Staging.dbo.Staging_pedido;

CREATE TABLE DataMart_Dim_Cliente (
  ID_cliente INT PRIMARY KEY,
  Nombre_cliente VARCHAR(50),
  Ciudad VARCHAR(50),
  Pa�s VARCHAR(50),
  Limite_credito NUMERIC(15,2)
);

-- Insertar los Clientes desde Staging.cliente--
INSERT INTO DataMarFinal.dbo.DataMart_Dim_Cliente (ID_cliente, Nombre_cliente, Ciudad, Pa�s, Limite_credito)
SELECT ID_cliente, nombre_cliente, ciudad, pais, limite_credito
FROM Staging.dbo.Staging_cliente;

CREATE TABLE DataMart_Dim_Producto (
  ID_producto VARCHAR(15) PRIMARY KEY,
  Nombre_producto VARCHAR(70),
  Categoria INT,
  Precio_venta NUMERIC(15,2)
);

-- Insertar los Producto desde Staging.producto--
INSERT INTO DataMarFinal.dbo.DataMart_Dim_Producto (ID_producto, Nombre_producto, Categoria, Precio_venta)
SELECT ID_producto, nombre, Categoria, precio_venta
FROM Staging.dbo.Staging_producto;

CREATE TABLE DataMart_Dim_Empleado (
  ID_empleado INT PRIMARY KEY,
  Nombre VARCHAR(50),
  Apellido1 VARCHAR(50),
  Puesto VARCHAR(50),
  Oficina VARCHAR(50)
);
-- Insertar los Empleados desde Staging.Empleados--
INSERT INTO DataMarFinal.dbo.DataMart_Dim_Empleado (ID_empleado, Nombre, Apellido1, Puesto, Oficina)
SELECT e.ID_empleado, e.nombre, e.apellido1, e.puesto, e.extension
FROM Staging.dbo.Staging_empleado e
INNER JOIN DataMarFinal.dbo.DataMart_Dim_Empleado o ON e.ID_oficina = o.Oficina;


CREATE TABLE DataMart_Dim_Tiempo (
  Fecha DATE PRIMARY KEY,
  A�o INT,
  Mes INT,
  D�a INT
);
-- Insertar las fechas desde Staging.pedido--
INSERT INTO DataMarFinal.dbo.DataMart_Dim_Tiempo (Fecha, A�o, Mes, D�a)
SELECT DISTINCT fecha_pedido, YEAR(fecha_pedido), MONTH(fecha_pedido), DAY(fecha_pedido)
FROM Staging.dbo.Staging_pedido;

--Consulta a DataMar--

SELECT*FROM DataMarFinal.dbo.DataMart_Hecho_Pedido


/*Hacemos El backup de Data MArt*/
BACKUP DATABASE DataMarFinal
TO DISK = 'C:\Users\camil\Desktop\Tarea Bases de datos 2\Backup\dataMar_backup.bak'
WITH FORMAT;

/*Hacemos El backup de Jardineria*/
BACKUP DATABASE Jardineria
TO DISK = 'C:\Users\camil\Desktop\Tarea Bases de datos 2\Backup\Jardineria_backup.bak'
WITH FORMAT;

/*Hacemos El backup de Staging*/
BACKUP DATABASE Staging
TO DISK = 'C:\Users\camil\Desktop\Tarea Bases de datos 2\Backup\Staging_backup.bak'
WITH FORMAT;


 select * from Staging.dbo.Staging_detalle_pedido