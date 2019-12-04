-- phpMyAdmin SQL Dump
-- version 4.1.14.8
-- http://www.phpmyadmin.net
--
-- Hostiteľ: 127.0.0.1:3309
-- Čas generovania: Út 19.Nov 2019, 12:06
-- Verzia serveru: 5.1.73-14.12-log
-- Verzia PHP: 7.2.19-0ubuntu0.18.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Databáza: `roulage1`
--

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `certification`
--

CREATE TABLE IF NOT EXISTS `certification` (
  `id` int(8) unsigned NOT NULL AUTO_INCREMENT,
  `desc_sk` varchar(128) DEFAULT NULL,
  `desc_en` varchar(128) DEFAULT NULL,
  `desc_de` varchar(128) DEFAULT NULL,
  `desc_fr` varchar(128) DEFAULT NULL,
  `route` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Sťahujem dáta pre tabuľku `certification`
--

INSERT INTO `certification` (`id`, `desc_sk`, `desc_en`, `desc_de`, `desc_fr`, `route`) VALUES
(1, 'Koncesná listina', NULL, NULL, NULL, '/img/certification/koncesna_listina_1.jpg'),
(2, 'Koncesná listina', NULL, NULL, NULL, '/img/certification/koncesna_listina_2.jpg'),
(3, 'Výpis z obchodného registra', NULL, NULL, NULL, '/img/certification/vypis_obch_register_1.jpg'),
(4, 'Výpis z obchodného registra', NULL, NULL, NULL, '/img/certification/vypis_obch_register_2.jpg\r\n'),
(5, 'Výpis z obchodného registra', NULL, NULL, NULL, '/img/certification/vypis_obch_register_3.jpg\r\n');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `contact`
--

CREATE TABLE IF NOT EXISTS `contact` (
  `id` int(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `phone` varchar(32) DEFAULT NULL,
  `mail` varchar(128) DEFAULT NULL,
  `fax` varchar(32) DEFAULT NULL,
  `desc_sk` text,
  `desc_en` text,
  `desc_de` text,
  `desc_fr` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Sťahujem dáta pre tabuľku `contact`
--

INSERT INTO `contact` (`id`, `name`, `phone`, `mail`, `fax`, `desc_sk`, `desc_en`, `desc_de`, `desc_fr`) VALUES
(2, 'ing. František Kováč', '+421 905 136 261', 'roulage.fero@dkubin.sk', NULL, '- konateľ spoločnosti\r\n- zodpovedný za colnú deklaráciu', NULL, NULL, NULL),
(8, 'Magdaléna Blanová', NULL, 'roulage.magdalena@dkubin.sk', NULL, '- Intrastat\r\n- Administratíva', NULL, NULL, NULL),
(5, 'ing. Andrea Feješová', NULL, NULL, NULL, '- zodpovedná za účtovníctvo', NULL, NULL, NULL),
(6, 'Matej Kováč', '+421 944 22 10 23', 'roulage.mato@gmail.com', NULL, '- intrastat\r\n- administratíva / údržba\r\n- rozvoz dokladov', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `hits`
--

CREATE TABLE IF NOT EXISTS `hits` (
  `hits` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Sťahujem dáta pre tabuľku `hits`
--

INSERT INTO `hits` (`hits`) VALUES
(120337);

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `home`
--

CREATE TABLE IF NOT EXISTS `home` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text_sk` text,
  `text_en` text,
  `text_de` text,
  `text_fr` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Sťahujem dáta pre tabuľku `home`
--

INSERT INTO `home` (`id`, `text_sk`, `text_en`, `text_de`, `text_fr`) VALUES
(1, 'O Nás\r\n=====\r\n\r\n- Firma **Roulage SK, s.r.o** vznikla v roku 2005 spojením ľudí s dlhoročnými skúsenosťami v odbore colnej deklarácie, tovarovej štatistiky, dopravy, zasielateľstva a logistiky.\r\n- Od roku 2018 sa užšie špecializujeme už len na služby týkajúce sa colného konania a vykazovania hlásení pre celoeurópsku štatistiku o pohybe tovaru Intrastat. \r\n\r\n<br />\r\n\r\nPrečo Roulage\r\n=============\r\n\r\n- Na trhu stabilne pôsobíme **od roku 2005**.\r\n- Naším cieľom a filozofiou je **stať sa vašim spoľahlivým partnerom** na vysokej kvalitatívnej úrovni pre **dlhodobú** a **perspektívnu spoluprácu**.\r\n- Našim bonusom je **flexibilita** a **individuálny prístup**,  **spoľahlivosť** a **precíznosť** sú pri našej práci **samozrejmosťou**.\r\n\r\n<br />\r\n\r\nNovinky & Budúcnosť\r\n===================\r\n\r\n- Na začiatku roku 2018 prešla naša spoločnosť viacerými zmenami, tá najpodstatnejšia je rozdelenie a **vznik** druhej spoločnosti **Roulage Plus s.r.o.**, ktorá preberá pod svoje krídla činnosti týkajúce sa **dopravy** a **logistiky**. \r\n<br />\r\nO Vaše potreby sa bude taktiež starať človek s dlhoročnými skúsenosťami a menom, p. **ing. Alexander Luczy** a jeho tím.\r\n<br />\r\n<br />\r\nKontakt:\r\n> **Alexander Luczy**, tel.: [+421 911 548 450](tel:+421911548450), e-mail: [roulage.alex@dkubin.sk](mailto:roulage.alex@dkubin.sk)\r\n<br />\r\n**Martina Kubernátová**, tel.: [+421 911 548 455](tel:+421911548455), e-mail: [roulage.martina@dkubin.sk](mailto:roulage.martina@dkubin.sk)', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `locations`
--

CREATE TABLE IF NOT EXISTS `locations` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `address` text,
  `title_sk` varchar(128) DEFAULT NULL,
  `title_en` varchar(128) DEFAULT NULL,
  `title_de` varchar(128) DEFAULT NULL,
  `title_fr` varchar(128) DEFAULT NULL,
  `lat` varchar(64) DEFAULT NULL,
  `lon` varchar(64) DEFAULT NULL,
  `extras_sk` text,
  `extras_en` text,
  `extras_de` text,
  `extras_fr` text,
  `lat_pin` varchar(64) DEFAULT NULL,
  `lon_pin` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Sťahujem dáta pre tabuľku `locations`
--

INSERT INTO `locations` (`id`, `address`, `title_sk`, `title_en`, `title_de`, `title_fr`, `lat`, `lon`, `extras_sk`, `extras_en`, `extras_de`, `extras_fr`, `lat_pin`, `lon_pin`) VALUES
(1, 'Roulage SK, s.r.o.   \r\nMilana Rastislava Štefánika 1831/46  \r\n026 19 Dolný Kubín  \r\nSlovenská republika\r\n', 'Sídlo firmy', NULL, NULL, NULL, '49.219953', '19.296305', NULL, NULL, NULL, NULL, '49.216785', '19.296777 '),
(2, 'Roulage SK, s.r.o.   \r\nBystrická cesta 62   \r\n034 01 Ružomberok   \r\nSlovenská republika  ', 'Pobočka', NULL, NULL, NULL, '49.069963', '19.311813', NULL, NULL, NULL, NULL, '49.069963', '19.311813'),
(3, NULL, 'Identifikačné čísla', NULL, NULL, NULL, NULL, NULL, '**IČO:** 36435244   \r\n**DIČ:** 2022071887  \r\n**IČ DPH:** SK2022071887  \r\n', NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `references`
--

CREATE TABLE IF NOT EXISTS `references` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `refs` varchar(128) DEFAULT NULL,
  `hrefs` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=33 ;

--
-- Sťahujem dáta pre tabuľku `references`
--

INSERT INTO `references` (`id`, `refs`, `hrefs`) VALUES
(32, 'SPN Plus s.r.o.', 'https://www.espeen.sk/'),
(31, 'Promet Czech', 'http://www.prometczech.cz/'),
(30, 'Ing. Pavol Zrník s.r.o.', NULL),
(29, 'Drast s.r.o.', NULL),
(28, 'SEMACO Tools and Software', 'https://www.semaco.cz/sk'),
(8, 'HDS', 'http://www.hds.sk/'),
(27, 'Kovopam', 'http://www.kovopam.sk/'),
(10, 'Klauke Slovakia', 'http://www.klauke.com/sk/'),
(11, 'MAHLE Engine Components Slovakia', 'http://www.mahle.com/mahle/en/about-mahle/locations/3518.jsp'),
(12, 'Nobel Automotive Slovakia', 'http://nobel-automotive.com/en/site/slovaquie?menu=implantation&site=slovaquie'),
(13, 'Primalex Slovakia', 'http://www.primalex.sk/'),
(14, 'Promet Slovakia', 'http://www.prometslovakia.sk/'),
(26, 'METALES Fixing', 'http://www.kotvenia.eu/'),
(16, 'SEZ', 'http://www.sez.sk/'),
(25, 'Kovohuty Dolný Kubín', 'http://www.kovohuty.com/'),
(24, 'PPG deco Slovakia', 'http://www.ppgdeco.sk/'),
(23, 'Leonteus', 'https://www.kozivrsok.sk/'),
(22, 'XD Vision', 'http://www.xdvision.sk/'),
(21, 'Miba Sinter Slovakia', 'http://www.miba.com/Sintered_Components-Sites-Miba_Sinter_Slovakia,70,en.html');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `services`
--

CREATE TABLE IF NOT EXISTS `services` (
  `id` int(8) unsigned NOT NULL AUTO_INCREMENT,
  `nadpis_fr` varchar(128) DEFAULT NULL,
  `group_fr` varchar(128) DEFAULT NULL,
  `slug_sk` varchar(128) DEFAULT NULL,
  `slug_en` varchar(128) DEFAULT NULL,
  `slug_de` varchar(128) DEFAULT NULL,
  `slug_fr` varchar(128) DEFAULT NULL,
  `preview_sk` text,
  `preview_en` text,
  `preview_de` text,
  `preview_fr` text,
  `text_sk` mediumtext,
  `text_en` mediumtext,
  `text_de` mediumtext,
  `text_fr` mediumtext,
  `group_sk` varchar(128) DEFAULT NULL,
  `group_en` varchar(128) DEFAULT NULL,
  `group_de` varchar(128) DEFAULT NULL,
  `nadpis_sk` varchar(128) DEFAULT NULL,
  `nadpis_en` varchar(128) DEFAULT NULL,
  `nadpis_de` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- Sťahujem dáta pre tabuľku `services`
--

INSERT INTO `services` (`id`, `nadpis_fr`, `group_fr`, `slug_sk`, `slug_en`, `slug_de`, `slug_fr`, `preview_sk`, `preview_en`, `preview_de`, `preview_fr`, `text_sk`, `text_en`, `text_de`, `text_fr`, `group_sk`, `group_en`, `group_de`, `nadpis_sk`, `nadpis_en`, `nadpis_de`) VALUES
(7, NULL, NULL, 'colne-konanie', NULL, NULL, NULL, '- Komplexné zastupovanie v colnom konaní pre **export** a **import** v regióne **Liptov** (colnica Ružomberok) a **Orava** (colnica Trstená)\r\n- Na základe **jednorázového plnomocenstva**\r\n- Na základe **mandátnej zmluvy**\r\n- Na základe **komisionárskej zmluvy**\r\n', NULL, NULL, NULL, '- Komplexné zastupovanie v colnom konaní pre **export** a **import** v regióne **Liptov** (colnica Ružomberok) a **Orava** (colnica Trstená)\r\n- Na základe **jednorázového plnomocenstva**\r\n- Na základe **mandátnej zmluvy**\r\n- Na základe **komisionárskej zmluvy**\r\n', NULL, NULL, NULL, 'Colné služby', NULL, NULL, 'Zastupovanie v colnom konaní', NULL, NULL),
(8, NULL, NULL, 'vystavenie-dokladov', NULL, NULL, NULL, '- Jednotný colný doklad **JCD**\r\n- Deklarácia údajov o **colnej hodnote**\r\n- Osvedčenia o pôvode **EUR.1**, **EUR-MED**, **FORM A**\r\n- Osvedčenie o **nepreferenčnom pôvode tovaru**\r\n- Osvedčenie o statuse **A.TR**\r\n- Nákladný list **CMR**\r\n- Karnet **TIR**\r\n- Karnet **ATA**', NULL, NULL, NULL, '- Komplexné zastupovanie v colnom konaní pre **export** a **import** v regióne **Liptov** (colnica Ružomberok) a **Orava** (colnica Trstená)\r\n- Na základe **jednorázového plnomocenstva**\r\n- Na základe **mandátnej zmluvy**\r\n- Na základe **komisionárskej zmluvy**\r\n', NULL, NULL, NULL, 'Colné služby', NULL, NULL, 'Vystavenie colných dokladov', NULL, NULL),
(9, NULL, NULL, 'poradenstvo-colne-sluzby', NULL, NULL, NULL, '- Poradenstvo v **colnom konaní**\r\n- Poradenstvo v otázkach **pôvodu tovaru**\r\n- Poradenstvo v otázkach **colných taríf** a **podmienok dovozu a vývozu** v rámci **EU**\r\n- Poradenstvo v otázkach **colných taríf** a **podmienok dovozu a vývozu** v rámci **tretích krajín**', NULL, NULL, NULL, '- Poradenstvo v **colnom konaní**\r\n- Poradenstvo v otázkach **pôvodu tovaru**\r\n- Poradenstvo v otázkach **colných taríf** a **podmienok dovozu a vývozu** v rámci **EU**\r\n- Poradenstvo v otázkach **colných taríf** a **podmienok dovozu a vývozu** v rámci **tretích krajín**', NULL, NULL, NULL, 'Colné služby', NULL, NULL, 'Poradenstvo', NULL, NULL),
(10, NULL, NULL, 'intrastat', NULL, NULL, NULL, '- Komplexné **zastupovanie s celoslovenskou pôsobnosťou**', NULL, NULL, NULL, '- Komplexné **zastupovanie s celoslovenskou pôsobnosťou**', NULL, NULL, NULL, 'Colné služby', NULL, NULL, 'Intrastat', NULL, NULL);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
