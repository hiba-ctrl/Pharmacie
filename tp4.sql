drop table if exists Arret_Effectue;
drop table if exists Arret;
drop table if exists Vol_Effectue;
drop table if exists Vol_Futur;
drop table if exists Type_Vol;
drop table if exists Aeroport;



create table Aeroport (
    code_aero varchar(5) primary key, 
    nom varchar (30), 
    ville varchar (50),
    unique (nom, ville)
);

create table Type_Vol (
    num_vol int primary key,  
    aero_dep varchar(5) not null,  
    aero_arr varchar(5) not null,  
    hp_dep time,  
    hp_arr time,  
    international boolean,
    foreign key (aero_dep) references Aeroport(code_aero),
    foreign key (aero_arr) references Aeroport(code_aero)
);

create table Vol_Effectue (
    num_vol int, 
    dat date,  
    h_dep time, 
    h_arr time,
    primary key (num_vol, dat),
    foreign key (num_vol) references Type_Vol(num_vol) ON DELETE CASCADE -- Permet de supprimer le vol effectue si le type de vol est supprime
);

create table Vol_Futur (
    num_vol int,  
    dat date,  
    places int,
    primary key (num_vol, dat),
    foreign key (num_vol) references Type_Vol(num_vol) ON DELETE CASCADE
); 

create table Arret (
    num_vol int, 
    code_aero varchar(5),
    hp_arr time,  
    hp_dep time, 
    primary key (num_vol, code_aero),
    foreign key (num_vol) references Type_Vol(num_vol) ON DELETE CASCADE,
    foreign key (code_aero) references Aeroport(code_aero)
);

create table Arret_Effectue (
    num_vol int, 
    dat date,  
    code_aero varchar(5),  
    h_arr time,
    h_dep time,  
    primary key (num_vol, dat, code_aero),
    foreign key (num_vol, dat) references Vol_Effectue(num_vol, dat) ON DELETE CASCADE, -- Permet de supprimer l'arret effectue si le vol effectue est supprime
    foreign key (code_aero) references Aeroport(code_aero)
);	

insert into Aeroport values ('CDG', 'Charles de Gaulle', 'Paris');
insert into Aeroport values ('MPX', 'Malpensa', 'Milan');
insert into Aeroport values ('JFK', 'JFK', 'New York');
insert into Aeroport values ('FCO', 'Roma Fiumicino', 'Rome');
insert into Aeroport values ('SYD', 'Sydney Intl Airport', 'Sydney');
insert into Aeroport values ('HKG', 'Hong Kong Intl Airport', 'Hong Kong');


insert into Type_Vol values (1, 'CDG', 'JFK', '08:30', '19:00', true);
insert into Type_Vol values (2, 'CDG', 'MPX', '11:30', '13:00', true);
insert into Type_Vol values (3, 'MPX', 'JFK', '13:40', '19:30', true);
insert into Type_Vol values (4, 'MPX', 'JFK', '14:10', '20:30', true);
insert into Type_Vol values (5, 'MPX', 'FCO', '7:10', '8:20', false);
insert into Type_Vol values (6, 'MPX', 'SYD', '7:10', '8:20', true);
insert into Type_Vol values (7, 'CDG', 'SYD', '6:10', '7:20', true);
insert into Type_Vol values (8, 'FCO', 'JFK', '10:00', '18:00', true);


insert into Vol_Effectue values (2, '2016/01/20', '11:30', '13:15');
insert into Vol_Effectue values (1, '2016/01/27', '08:40', '18:50');
insert into Vol_Effectue values (1, '2016/01/30', '08:50', '18:50');

-- arret intermediaires prevus
insert into Arret values (1, 'MPX', '09:30', '09:40');
insert into Arret values (1, 'FCO', '10:15', '10:25');
insert into Arret values (8, 'MPX', '11:00', '11:10');
insert into Arret values (6, 'HKG', '03:40', '04:00');
insert into Arret values (7, 'HKG', '02:40', '03:20');

-- arret intermediaires effectue
insert into Arret_Effectue values (1, '2016/01/27', 'MPX', '09:32', '09:42');
insert into Arret_Effectue values (1, '2016/01/27', 'FCO', '10:16', '10:25');
insert into Arret_Effectue values (1, '2016/01/30', 'MPX', '09:35', '09:44');
insert into Arret_Effectue values (1, '2016/01/30', 'FCO', '09:36', '09:46');

insert into Vol_Futur values (1, '2017/01/20', 0);
insert into Vol_Futur values (2, '2017/01/20', 3);
insert into Vol_Futur values (3, '2017/01/20', 5);
insert into Vol_Futur values (4, '2017/01/20', 18);


-- Question 1

SELECT TV.num_vol, AD.nom AS Departure_Airport, AA.nom AS Arrival_Airport
FROM Type_Vol TV
JOIN Aeroport AD ON TV.aero_dep = AD.code_aero
JOIN Aeroport AA ON TV.aero_arr = AA.code_aero
WHERE TV.aero_arr >= 1; 
-- Question 2
SELECT VE.num_vol
FROM Vol_Effectue VE
JOIN Type_Vol TV ON VE.num_vol = TV.num_vol
JOIN Aeroport AD ON TV.aero_dep = AD.code_aero
JOIN Aeroport AA ON TV.aero_arr = AA.code_aero
WHERE VE.h_arr > TV.hp_arr;

-- Question 3
SELECT TV.num_vol
FROM Vol_Futur VF
JOIN Type_Vol TV ON VF.num_vol = TV.num_vol
JOIN Aeroport AD ON TV.aero_dep = AD.code_aero
JOIN Aeroport AA ON TV.aero_arr = AA.code_aero
WHERE AD.ville = 'Paris' AND AA.ville = 'New York' AND VF.dat = '2017-01-20' AND VF.places > 0;