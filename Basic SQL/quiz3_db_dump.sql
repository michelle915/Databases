SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS bsg_planets;
DROP TABLE IF EXISTS bsg_people;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE `bsg_planets` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`name` varchar(255) NOT NULL,
`population` bigint(20) DEFAULT NULL,
`language` varchar(255) DEFAULT NULL,
`capital` varchar(255) DEFAULT NULL,
PRIMARY KEY (`id`),
UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
--
-- Dumping data for table `bsg_planets`
--

INSERT INTO `bsg_planets` (`id`, `name`, `population`, `language`, `capital`) VALUES
(1, 'Gemenon', 2800000000, 'Old Gemenese', 'Oranu'),
(2, 'Leonis', 2600000000, 'Leonese', 'Luminere'),
(3, 'Caprica', 4900000000, 'Caprican', 'Caprica City'),
(7, 'Sagittaron', 1700000000, NULL, 'Tawa'),
(16, 'Aquaria', 25000, NULL, NULL),
(17, 'Canceron', 6700000000, NULL, 'Hades'),
(18, 'Libran', 2100000, NULL, NULL),
(19, 'Picon', 1400000000, NULL, 'Queestown'),
(20, 'Scorpia', 450000000, NULL, 'Celeste'),
(21, 'Tauron', 2500000000, 'Tauron', 'Hypatia'),
(22, 'Virgon', 4300000000, NULL, 'Boskirk');

--
-- Table structure for table `bsg_people`
--

CREATE TABLE `bsg_people` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fname` varchar(255) NOT NULL,
  `lname` varchar(255) DEFAULT NULL,
  `homeworld` int(11) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `homeworld` (`homeworld`),
  CONSTRAINT `bsg_people_ibfk_1` FOREIGN KEY (`homeworld`) REFERENCES `bsg_planets` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

--
-- Dumping data for table `bsg_people`
--

INSERT INTO `bsg_people` (`id`, `fname`, `lname`, `homeworld`, `age`) VALUES
(1, 'William', 'Adama', 3, 61),
(2, 'Lee', 'Adama', 3, 30),
(3, 'Laura', 'Roslin', 3, NULL),
(4, 'Kara', 'Thrace', 3, NULL),
(5, 'Gaius', 'Baltar', 3, NULL),
(6, 'Saul', 'Tigh', NULL, 71),
(7, 'Karl', 'Agathon', 1, NULL),
(8, 'Galen', 'Tyrol', 1, 32),
(9, 'Callandra', 'Henderson', NULL, NULL);

--
-- Indexes for dumped tables
--
