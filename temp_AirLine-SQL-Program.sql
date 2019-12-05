USE `rakshaadb`;

CREATE TABLE `admin` (
	`admin_username` varchar(50),
    `admin_password` varchar(50)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `users` (
  `firstname` varchar(50),
  `lastname` varchar(50),
  `username` varchar(50),
  `password` varchar(50),
  `ticketNum` int,
  `cid`int,
  PRIMARY KEY (`cid`),
  FOREIGN KEY(`ticketNum`) REFERENCES ticket
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `airlinecompany` (
  `airlineid` int,
  `name` varchar(50),
  `aircraftnum` int,
PRIMARY KEY (`airlineid`),
FOREIGN KEY(`aircraftnum`) REFERENCES aircraft
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `aircraft` (
  `aircraftNum` int,
PRIMARY KEY (`aircraftNum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `airport` (
  `airportid` int,
  `airportname` varchar(50),
  `flightNum` int,
  PRIMARY KEY (`airportid`),
  FOREIGN KEY (`flightNum`) REFERENCES flight
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `employee` (
  `eid` int,
  `firstname` varchar(50),
  `lastname` varchar(50),
  `ssn` int,
  `emp_username` varchar(50),
  `emp_password` varchar(50),
  PRIMARY KEY (`eid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `flight` (
  `flightnum` int,
  `days` varchar(50),
  `isinternational` boolean,
  `isdomestic` boolean,
  `price` int,
  `stops` int,
  `aircraftNum` int,
  `airportid` int,
  `airlineid` int,
PRIMARY KEY (`flightnum,days`),
FOREIGN KEY (`days`) REFERENCES operate,
FOREIGN KEY (`airlineid`) REFERENCES airlinecompany,
FOREIGN KEY (`aircraftNum`) REFERENCES aircraft,
FOREIGN KEY (`airportid`) REFERENCES airport
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `schedule` (
  `scheduleid` int,
  `destinationdate` date,
  `departuredate` date,
  `departureairport` varchar(50),
  `destinationairport` varchar(50),
  `flightNum` int DEFAULT NULL,
  PRIMARY KEY (`scheduleid`),
FOREIGN KEY (`flightNum`) REFERENCES flight
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `ticket` (
  `cid` int,
  `flightNum` int,
  `ticketNum` int,
  `isflexible` boolean,
  `bookingcost` int,
  `cancelfee` int,
  `numflights`int,
  `seatnum` int,
  `fare` float,
  `datebought` date,
  `priorityNum` int,
  `accountNum` int,
  `is_oneway` boolean,
  `waitlist` boolean,
  `is_roundtrip` boolean,
  PRIMARY KEY (`ticketNum`),
FOREIGN KEY (`flightNum`) REFERENCES flight,
FOREIGN KEY (`priorityNum`) REFERENCES class,
FOREIGN KEY (`cid`) REFERENCES users
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `class` (
`ticketNum` int,
`priorityNum` int,
PRIMARY KEY (`ticketNum, priorityNum`),
FOREIGN KEY (`ticketNum`) REFERENCES ticket
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

