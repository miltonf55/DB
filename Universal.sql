-- Generated: 2022-06-13 16:51
-- Model: New Model
-- Version: 1.0
-- Project: DB Project
-- Author: milto

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `Universal` DEFAULT CHARACTER SET latin1;

CREATE TABLE IF NOT EXISTS `Universal`.`parques` (
  `id_par` INT(11) NOT NULL AUTO_INCREMENT,
  `nom_par` VARCHAR(100) NOT NULL,
  `des_par` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id_par`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `Universal`.`atracciones` (
  `id_atr` INT(11) NOT NULL AUTO_INCREMENT,
  `nom_atr` VARCHAR(100) NOT NULL,
  `des_atr` VARCHAR(300) NOT NULL,
  `id_par` INT(11) NOT NULL,
  PRIMARY KEY (`id_atr`),
  CONSTRAINT `fk_atracciones_parques`
    FOREIGN KEY (`id_par`)
    REFERENCES `Universal`.`parques` (`id_par`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `Universal`.`actividades` (
  `id_act` INT(11) NOT NULL AUTO_INCREMENT,
  `nom_act` VARCHAR(100) NOT NULL,
  `des_act` VARCHAR(300) NOT NULL,
  `id_par` INT(11) NOT NULL,
  PRIMARY KEY (`id_act`, `id_par`),
  CONSTRAINT `fk_actividades_parques1`
    FOREIGN KEY (`id_par`)
    REFERENCES `Universal`.`parques` (`id_par`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `Universal`.`hoteles` (
  `id_hot` INT(11) NOT NULL AUTO_INCREMENT,
  `nom_hot` VARCHAR(100) NOT NULL,
  `des_hot` VARCHAR(300) NOT NULL,
  `id_par` INT(11) NOT NULL,
  PRIMARY KEY (`id_hot`, `id_par`),
  CONSTRAINT `fk_hoteles_parques1`
    FOREIGN KEY (`id_par`)
    REFERENCES `Universal`.`parques` (`id_par`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `Universal`.`entradas` (
  `id_ent` INT(11) NOT NULL AUTO_INCREMENT,
  `pre_ent` FLOAT(11) NOT NULL,
  `tp_ent` VARCHAR(1) NOT NULL,
  `id_par` INT(11) NOT NULL,
  `id_ten` INT(11) NOT NULL,
  PRIMARY KEY (`id_ent`, `id_par`, `id_ten`),
  CONSTRAINT `fk_actividades_copy1_parques1`
    FOREIGN KEY (`id_par`)
    REFERENCES `Universal`.`parques` (`id_par`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_entradas_tipoEntrada1`
    FOREIGN KEY (`id_ten`)
    REFERENCES `Universal`.`tipoEntrada` (`id_ten`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `Universal`.`tipoEntrada` (
  `id_ten` INT(11) NOT NULL AUTO_INCREMENT,
  `des_ten` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_ten`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS `Universal`.`ventaEntradas` (
  `id_ven` INT(11) NOT NULL AUTO_INCREMENT,
  `can_ven` TINYINT(2) NOT NULL,
  `dat_ven` DATETIME NOT NULL,
  `id_ent` INT(11) NOT NULL,
  PRIMARY KEY (`id_ven`, `id_ent`),
  CONSTRAINT `fk_ventaEntradas_entradas1`
    FOREIGN KEY (`id_ent`)
    REFERENCES `Universal`.`entradas` (`id_ent`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

/*insert into parques values 
(1,"Universal Studios Florida","Es como ver tus programas de Tv pero en la vida real"),             
(2,"Islands of Adventure", "Este es el lugar donde la diversi??n sigue sin parar."),
(3,"Volcano Bay","Es un parque acu??tico tem??tico.Y es como un volc??n real."),
(4,"CityWalk","Inolvidables locales y restaurantes, para satisfacer tanto el paladarcomo la imaginaci??n. ");          
                        
insert into hoteles values 
(1,"Resort - Dockside Inn and Suites","Ambiente tranquilo y m??s econ??mico. Inspirado por la arena, mar y hermosos atardeceres",1),
(2,"Surfside Inn and Suites","Hotel para familias de categor??a Value ofrece m??s conveniencia para tus vacaciones en Universal.",1),
("3","Aventura Hotel","ofrece hospedaje moderno y con estilo. Este hotel tiene una vista espectacular.",2),
("4","Cabana Bay Beach","habitaciones y suites llenas de vida, en estilo retro, dise??adas para tu diversi??n y econom??a.",2),
("5","Loews Sapphire Falls","estar??s en un lugar rodeado de vida, y lleno de detalles inspirados en paisajes de islas.",3),
("6","Loews Royal Pacific","Una piscina estilo laguna, rodeada de arena blanca y palmas, te invitan a desconectar de todo.",3),
("7","Hard Rock ","Vive como una estrella y los beneficios de la realeza del rock n roll en un hospedaje impecable.",4),
("8","Loews Portofino","Inspirado por la belleza, el romance y el encanto de la aldea costera de Portofino en Italia. ",4);

insert into tipoEntrada values
(1, "Park-to-Park"),
(2, "One Park per Day");

insert into entradas values
(1, 77.40, 0, 1, 1),
(2, 80.20, 0, 2, 1),
(3, 75.50, 0, 3, 1),
(4, 70.80, 0, 4, 1),
(5, 73.10, 0, 1, 2),
(6, 85.30, 0, 2, 2),
(7, 82.60, 0, 3, 2),
(8, 77.70, 0, 4, 2),
(9, 90.00, 1, 1, 1),
(10, 95.90, 1, 2, 1),
(11, 100.00, 1, 3, 1),
(12, 90.10, 1, 4, 1),
(13, 89.90, 1, 1, 2),
(14, 97.30, 1, 2, 2),
(15, 99.00, 1, 3, 2),
(16, 105.90, 1, 4, 2);

insert into ventaEntradas values
(1, 2, '2022-02-18 23:46:59', 1),
(2, 2, '2020-04-12 01:13:33', 2),
(3, 1, '2019-01-17 21:45:21', 3),
(4, 1, '2021-11-24 23:22:00', 4),
(5, 3, '2019-01-04 07:39:30', 5),
(6, 2, '2020-03-13 00:07:57', 6),
(7, 2, '2018-07-07 09:13:22', 7),
(8, 3, '2018-06-05 21:01:03', 8),
(9, 4, '2022-05-05 21:47:10', 9),
(10, 2, '2019-08-15 08:15:57', 10),
(11, 3, '2019-01-21 10:40:25', 11),
(12, 2, '2019-01-22 03:11:13', 12),
(13, 1, '2020-01-06 04:26:44', 13),
(14, 2, '2020-07-07 16:06:27', 14),
(15, 1, '2019-09-15 05:53:01', 15),
(16, 2, '2020-01-05 09:38:43', 16);

insert into atracciones values 
(1, "Harry Potter and the Escape from Gringotts", "Entra debajo de un enorme drag??n que escupe fuego y viaja a las profundidades subterr??neas en este emocionante viaje multidimensional.",1),
(2, "Despicable Me Minion Mayhem", "??nete a Gru, sus hijas y los traviesos Minions en un viaje impredecible. Eres reclutado para el ??ltimo esquema de Gru, uno en el que te convertir??s en un Minio real.",1),
(3, "Hogwarts??? Express", "Viaje entre la estaci??n King's Cross en el ??rea londinense de Universal Studios Florida y la estaci??n Hogsmeade??? en Universal's Islands of Adventure",1),
(4, "E.T. Adventure", "El planeta de origen de E.T. se est?? muriendo y necesita tu ayuda para salvarlo. Suba a bordo de su bicicleta voladora y despegue en un viaje emocionante (pero suave) por el cielo",1),
(5, "Revenge of the Mummy", "Clavando las u??as en la barandilla de seguridad, te agarrar??s fuerte mientras corres hacia adelante y hacia atr??s en la v??a, huyendo de la malvada momia Imhotep.",1),
(6, "Fast And Furious - Supercharged", "Ad??ntrate en una incre??ble recreaci??n de la sede de la tripulaci??n llena de accesorios de pel??culas reales y veh??culos supercargados que solo has visto en la pantalla grande",1),
(7, "TRANSFORMERS: The Ride-3D", "??nate a Optimus Prime y Bumblebee en un viaje emocionante ultra-inmersivo que desdibuja la l??nea entre la ficci??n y la realidad",1),
(8, "The Simpsons Ride", "Tome asiento en una monta??a rusa simulada bajo techo, donde correr?? y chocar?? por el parque con Homer, Marge, Bart, Lisa y Maggie en una aventura emocionante sin parar.",1),
(9, "MEN IN BLACK??? Alien Attack", "Nueva York ha sido golpeada por una epidemia de extraterrestres y depende de usted, agente en pr??cticas, destruirlos.",1),

(10, "VelociCoaster de Jurassic", "Acelerar??s sobre rieles que llegan m??s alto que la jungla, ya que es la monta??a rusa m??s feroz: la VelociCoaster de Jurassic World",2),
(11, "Hagrid's Magical Creatures Motorbike Adventure", "??nete a Hagrid??? mientras te adentras en las profundidades del Bosque Prohibido, m??s all?? de los terrenos del castillo de Hogwarts???",2),
(12, "Jurassic Park River Adventure", "Un minuto, est??s desliz??ndote en tu balsa. Al siguiente, est??s cara a cara con un T. rex gigante. No hay a d??nde ir",2),
(13, "Harry Potter and the Forbidden Journey", "Ingrese a trav??s de las imponentes puertas del castillo y recorra los pasillos y pasillos familiares de la Escuela de Magia y Hechicer??a de Hogwarts???.",2),
(14, "Hogwarts Express", "Viaje entre la estaci??n King's Cross en el ??rea londinense de Universal Studios Florida y la estaci??n Hogsmeade??? en Universal's Islands of Adventure",2),
(15, "Caro-Seuss-el", "No solo puedes subir a bordo de un elenco creativo de personajes del Dr. Seuss, sino que tambi??n puedes hacer que sus ojos parpadeen, sus o??dos se muevan y sus cabezas giren.",2),
(16, "Doctor Doom's Fearfall", "Sus secuaces te atar??n a un asiento, te lanzar??n al cielo y luego, sin un segundo para recuperar el aliento, te arrojar??n hacia abajo con una fuerza que te derretir?? la cara m??s fuerte que la gravedad misma.",2),

(17, "Honu of the Honu ika Moana", "Al igual que los antiguos waturi que cabalgaban sobre las olas del oc??ano en ballenas amigables, puedes disfrutar de este tobog??n giratorio y giratorio para varias personas.",3),
(18, "Kala & Tai Nui Serpentine Body Slides", "Las trampillas gemelas sumergen a dos invitados en tubos entrelazados antes de enviarlos alegremente a chapotear en las aguas turquesas de abajo.", 3),
(19, "Krakatau Aqua Coaster", "Las canoas para cuatro personas se deslizan hacia arriba a trav??s de la niebla y hacia los oscuros giros y vueltas dentro del volc??n antes de emerger con una zambullida a trav??s de una cascada reluciente.", 3),
(20, "Ko???okiri Body Plunge", "Con una ca??da de 70 grados a trav??s de una puerta abatible y 125 pies de diversi??n, este vertiginoso descenso termina con un tributo acu??tico del mismo Vol.", 3),
(21, "Ohyah of Ohyah & Ohno Drop Slides", "Asciende por el lado de un acantilado antes de caer en picado por estas aguas retorcidas y caer cuatro pies por encima de una piscina arremolinada.", 3),
(22, "Waturi Beach", "Disfruta de una vista inolvidable de Krakatau, el poderoso volc??n y su impresionante serie de cascadas que se vierten en la laguna reluciente", 3),
(23, "Tonga of Taniwha Tubes", "Los troncos serpenteantes de los ??rboles puka m??s altos parecen unir la tierra con el cielo. Los Waturi buscaron reflejar su camino serpenteante cuando construyeron estos dos toboganes de agua verdes y curvos.", 3),
(24, "TeAwa The Fearless River", "Ponte tu chaleco salvavidas y corre a lo largo de una embestida rugiente y acu??tica de r??pidos agitados y olas cortantes.", 3),
(25, "Raki of Taniwha Tubes", "Inspir??ndose en sus ra??ces retorcidas, los Waturi construyeron estos dos toboganes de agua azules retorcidos.", 3),
(26, " Puihi of the Maku Puihi Round Raft Rides", "Ingrese al dram??tico camino del tubo de lava y pruebe su valent??a en Puihi, donde se desliza a trav??s de una caverna oscura y sinuosa.", 3),
(27, " Maku of the Maku Puihi Round Raft Rides", "Maku se desliza a gran velocidad a trav??s de un desfiladero volc??nico antes de girar alrededor de formaciones en forma de cuenco. Cuando un g??iser estalla, eres absorbido por un v??rtice acuoso", 3);

insert into actividades values
(1, "The Bourne Stuntacular", "Olv??date de lo que conoces de espect??culos de acrobacias. A trav??s de una vanguardista fusi??n de t??cnica teatral y de pel??culas, sigue a Jason Bourne mientras derrota siniestros personajes que intentan detenerlo.", 1),
(2, "Universal Orlando's Cinematic Celebration", "Podr??s ver dinosaurios y o??rlos rugir en Jurassic World, sentir la adrenalina que producen los autom??viles de alta velocidad de Fast & Furious", 1),
(3, "Universal Orlando's Horror Make-Up Show", "En este extravagante espect??culo en vivo, ver??s c??mo los principales maquilladores y encargados de efectos especiales crean algunos de los personajes espeluznantes que has visto en la gran pantalla.", 1),
(4, "The Blues Brothers?? Show", "Directo desde las rudas calles de Chicago, prep??rate para escuchar la conmovedora m??sica de estos faraones del funk, The Blues Brothers.", 1),
(5, "The Tales of Beedle the Bard", "Te invitamos a ver un espect??culo presentado por The Wizarding Academy of Dramatic Arts. Estos artistas, realizan una obra con piezas de escenograf??a, accesorios y t??teres.", 1),
(6, "Animal Actors On Location!", "Este espect??culo presenta a algunos de los animales m??s talentosos del cine y la televisi??n, actuando en una divertida mezcla de videos, bromas en vivo, e interacciones con el p??blico.", 1),
(7, "Celestina Warbeck and the Banshees", "Mu??vete y disfruta del dulce tono de voz de la sensaci??n del wizarding world (y la cantante favorita de Molly Weasley), Celestina Warbeck and the Banshees.", 1),
(8, "Simpsons??? Games ", "Atr??vete y mide tus habilidades en los juegos de estilo de feria directo del divertido Krustyland. Prueba tu suerte en juegos como Whac-A-Rat, Dunk or Flunk, Mr. Burns' Radioactive Rings y m??s.", 1),
(9, "Knight Bus???", "El Knight Bus??? es el autob??s p??rpura de tres pisos, estacionado en Londres, al que brujas y magos solicitan con sus varitas en caso de emergencia.", 1),
(10, "Palace Theater Arcade", "Las aplicaciones y los videojuegos son divertidos, pero los mejores triunfos vienen cuando dominas los cl??sicos. Hockey de aire. Pinball. ", 1),

(11, "Dark Arts at Hogwarts??? Castle", "Cuando cae la noche en el castillo de Hogwarts???, los Dementores, Mort??fagos, y otras innombrables criaturas, cubren las paredes de piedra con siniestras im??genes y malvada magia.", 2),
(12, "Jurassic Park??? Games", "Participa en la diversi??n de gran tama??o que te ofrecen los juegos de estilo carnaval de Jurassic Park.", 2),
(13, "Kingpin???s Arcade??", "Kingpin (tambi??n conocido como The Brainwasher o Wilson Grant Fisk) puede controlar a la mafia con un pu??o de hierro, pero no puede evitar que derrotes a sus m??quinas.", 2),
(14, "The Mystic Fountain", "Tallada de piedra antigua sobre los misteriosos g??iseres subterr??neos de The Lost Continent, esta curiosa fuente en Sinbad???s Bazaar es el hogar de un travieso esp??ritu de agua.", 2),
(15, "The Nighttime Lights At Hogwarts??? Castle", "Ven y descubre The Nighttime Lights at Hogwarts??? Castle, un espect??culo deslumbrante de m??sica y luces.", 2),
(16, "Toon Lagoon Games", "Esta maravillosa secci??n con juegos de carnaval, cuenta con juegos y premios para visitantes de todas las edades, que realmente pondr??n a prueba tu fuerza.", 2),
(17, "Poseidon's Fury", "Sigue a un gu??a arque??logo y avent??rate por las sombr??as ruinas del antiguo Templo de Poseid??n, el dios griego del mar.", 2),
(18, "Frog Choir", "Escucha las melod??as de este peque??o coro de estudiantes de Hogwarts???, acompa??ado de los sonidos guturales de sus ranas gigantes.", 2),
(19, "Oh! The Stories You'll Hear!", "Dir??gete a Seuss Landing??? y echa un vistazo a estos espect??culos diarios con tus personajes favoritos del Dr. Seuss: The Cat in the Hat??? con Thing One??? y Thing Two???, Sam-I-Am", 2),
(20, "Triwizard Spirit Rally", "Anima a los estudiantes de las legendarias escuelas m??gicas de Hogwarts???, Beauxbatons y Durmstrang, mientras se dirigen al emocionante Torneo de los Tres Magos.", 2),

(21, "CityWalk's Rising Star", "S??bete al escenario en este bar de karaoke con estilo rockero, donde puedes lucirte al ritmo de tus canciones favoritas con la ayuda de coristas talentosos y una banda en vivo", 4),
(22, "Hard Rock Live?? Orlando", "Este es tu momento de disfrutar a los m??sicos y comediantes m??s aclamado.", 4),
(23, "Hollywood Drive-In Golf???", "Prep??rate para una invasi??n de ciencia ficci??n de los a??os 50 y la diversi??n de las pel??culas de terror, a trav??s de dos circuitos interactivos de mini golf de 18 hoyos.", 4),
(24, "Universal Cinemark en Universal CityWalk?? Orlando", "Ve los estrenos en 20 grandes pantallas con proyectores y sonido de ??ltima generaci??n, para que disfrutes de un espect??culo incre??ble.", 4);
*/


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
