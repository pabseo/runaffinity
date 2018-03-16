CREATE TABLE `TAG` (
  `idTag` int(3) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) DEFAULT NULL,
  `descripcion` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`idTag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

select * from TAG;
insert into TAG (nome, descripcion) values ('Montaña', 'Transcorre en montaña');
insert into TAG (nome, descripcion) values ('Ciclismo', 'Utilización de bicicleta');