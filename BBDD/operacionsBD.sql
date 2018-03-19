CREATE TABLE `TAG` (
  `idTag` int(3) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) DEFAULT NULL,
  `descripcion` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`idTag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

insert into TAG (nome, descripcion) values ('Montaña', 'Transcorre en montaña');
insert into TAG (nome, descripcion) values ('Ciclismo', 'Utilización de bicicleta');
insert into TAG (nome, descripcion) values ('Agua', 'Transcorre en parte ou totalidade por auga');

CREATE TABLE `FACTOR_PUNTUACION` (
  `idFactorPuntuacion` int(3) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idFactorPuntuacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
insert into FACTOR_PUNTUACION (nome) values ('Ambiente');
insert into FACTOR_PUNTUACION (nome) values ('Climatoloxía');
insert into FACTOR_PUNTUACION (nome) values ('Avituallamento');
insert into FACTOR_PUNTUACION (nome) values ('Calidade/Precio');

CREATE TABLE `TIPO_LINK` (
  `idTipoLink` int(3) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idTipoLink`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
insert into TIPO_LINK (nome) values ('Web Evento');
insert into TIPO_LINK (nome) values ('Galeria Fotos');
insert into TIPO_LINK (nome) values ('Facebook');
insert into TIPO_LINK (nome) values ('Twitter');

CREATE TABLE `EVENTO` (
  `idEvento` int(5) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `foto` varchar(250) DEFAULT NULL,
  `lugar` varchar(250) DEFAULT NULL,
  `coordenadas_lugar` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`idEvento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
insert into EVENTO (nome, foto, lugar, coordenadas_lugar) 
values ('Trail do Mandeo', 'trail_mandeo.jpg', 'Betanzos e concellos limítrofes', '2.34;34.32');

CREATE TABLE `PARTICIPANTE` (
  `idParticipante` int(5) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `foto` varchar(250) DEFAULT NULL,
  `lugar_nacemento` varchar(250) DEFAULT NULL,
  `data_nacemento` date DEFAULT NULL,
  `sexo` int(1) DEFAULT NULL,
  `rol` int(1) NOT NULL,
  PRIMARY KEY (`idParticipante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
insert into PARTICIPANTE (nome, foto, lugar_nacemento, data_nacemento, sexo, rol) 
values ('Pablo Seoane', 'pablo_seoane.jpg', 'Betanzos', '19821220',1,1);

CREATE TABLE `USUARIO` (
  `idUsuario` int(5) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `login` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `foto` varchar(250) DEFAULT NULL,
  `email` varchar(250) DEFAULT NULL,
  `idParticipante` int(5) DEFAULT NULL,
  `data_creacion` date NOT NULL,
  PRIMARY KEY (`idUsuario`),
  FOREIGN KEY (`idParticipante`) REFERENCES PARTICIPANTE(`idParticipante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
insert into USUARIO (nome, login, password, foto, email, idParticipante, data_creacion) 
values ('Pablo Seoane', 'pabseo', 'algoencriptado', 'pablo_seoane_participante.jpg',
'correo@correo.com',1,sysdate());

CREATE TABLE `EDICION` (
  `idEdicion` int(6) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `descripcion` varchar(250) NOT NULL,
  `idEvento` int(5) NOT NULL,
  `idUsuario` int(5) NOT NULL,
  `lugar` varchar(250) DEFAULT NULL,
  `coordenadas_lugar` varchar(250) DEFAULT NULL,
  `data_celebracion` date NOT NULL,
  `data_alta` date NOT NULL,
  PRIMARY KEY (`idEdicion`),
  FOREIGN KEY (`idUsuario`) REFERENCES USUARIO(`idUsuario`),
  FOREIGN KEY (`idEvento`) REFERENCES EVENTO(`idEvento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
insert into EDICION (nome, descripcion, idEvento, idUsuario, lugar, coordenadas_lugar, data_celebracion, data_alta) 
values ('Trail do Mandeo 18', 'Trail Mandeo 2018', 1, 1, 'Betanzos', '2.34;34.32','20180609',sysdate());

CREATE TABLE `LINK` (
  `idLink` int(5) NOT NULL AUTO_INCREMENT,
  `url` varchar(500) NOT NULL,
  `descripcion` varchar(250) NOT NULL,
  `idTipoLink` int(3) NOT NULL,
  `idUsuario` int(5) NOT NULL,
  `idEdicion` int(6) NOT NULL,
  `data_alta` date NOT NULL,
  PRIMARY KEY (`idLink`),
  FOREIGN KEY (`idUsuario`) REFERENCES USUARIO(`idUsuario`),
  FOREIGN KEY (`idEdicion`) REFERENCES EDICION(`idEdicion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
insert into LINK (url, descripcion, idTipoLink, idUsuario, idEdicion, data_alta) 
values ('fotos.como', 'Fotos do trail mandeo 2018', 2, 1, 1, sysdate());

CREATE TABLE `COMENTARIO` (
  `idComentario` int(5) NOT NULL AUTO_INCREMENT,
  `comentario` varchar(2500) NOT NULL,  
  `idEdicion` int(3) NOT NULL,
  `idUsuario` int(5) NOT NULL,
  `data_alta` date NOT NULL,
  PRIMARY KEY (`idComentario`),
  FOREIGN KEY (`idUsuario`) REFERENCES USUARIO(`idUsuario`),
  FOREIGN KEY (`idEdicion`) REFERENCES EDICION(`idEdicion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
insert into COMENTARIO (comentario, idEdicion, idUsuario, data_alta) values ('Carreira collouda',1, 1, sysdate());

#TÁBOAS RELACIONÁIS
CREATE TABLE `TAG_EVENTO` (
  `idEvento` int(5) NOT NULL,
  `idTag` int(5) NOT NULL,
  PRIMARY KEY (`idEvento`,`idTag`),
  FOREIGN KEY (`idEvento`) REFERENCES EVENTO(`idEvento`),
  FOREIGN KEY (`idTag`) REFERENCES TAG(`idTag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
insert into TAG_EVENTO values(1,2);

CREATE TABLE `PARTICIPANTE_EDICION` (
  `idParticipante` int(5) NOT NULL,
  `idEdicion` int(6) NOT NULL,
  `posicion` int(6),
  `finisher` int(1),
  `individual` int(1),
  `MMP_tipo_proba` int(1),
  `MMP_na_proba` int(1),
  `tiempo` varchar(100),
  PRIMARY KEY (`idParticipante`,`idEdicion`),
  FOREIGN KEY (`idParticipante`) REFERENCES PARTICIPANTE(`idParticipante`),
  FOREIGN KEY (`idEdicion`) REFERENCES EDICION(`idEdicion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
insert into PARTICIPANTE_EDICION values(1,1,23,1,1,0,1,'2h:56');

CREATE TABLE `FACTOR_EDICION` (
  `idFactorEdicion` int(6) NOT NULL AUTO_INCREMENT,
  `idFactorPuntuacion` int(3) NOT NULL,
  `idEdicion` int(6) NOT NULL,  
   PRIMARY KEY (`idFactorEdicion`),
   FOREIGN KEY (`idFactorPuntuacion`) REFERENCES FACTOR_PUNTUACION(`idFactorPuntuacion`),
   FOREIGN KEY (`idEdicion`) REFERENCES EDICION(`idEdicion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
insert into FACTOR_EDICION(idFactorPuntuacion,idEdicion) values(1,1);

CREATE TABLE `FACTOR_EDICION_USUARIO` (
  `idFactorEdicion` int(6) NOT NULL,  
  `idUsuario` int(5) NOT NULL,
  `puntuacion` int(2) NOT NULL,
   PRIMARY KEY (`idFactorEdicion`,`idUsuario`),
   FOREIGN KEY (`idFactorEdicion`) REFERENCES FACTOR_EDICION(`idFactorEdicion`),   
   FOREIGN KEY (`idUsuario`) REFERENCES USUARIO(`idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
insert into FACTOR_EDICION_USUARIO values(1,1,3);





