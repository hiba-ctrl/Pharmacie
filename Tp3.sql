
INSERT INTO tournois (tid,nom, annee, pays) 
VALUES(9,'match paris_milan',2020,'France');

INSERT INTO tournois (nom, annee, pays) 
VALUES ('New Tournament', 2024, 'Paris');
CREATE TABLE joueurEquipes (
    jid INT,
    eid INT,
    PRIMARY KEY (jid, eid),
    FOREIGN KEY (jid) references joueurs(jid),
    FOREIGN KEY (eid) references equipes(eid)
);
CREATE TABLE joueurs(
    jid INT,
    eid INT,
    PRIMARY KEY (jid, eid),
    nom VARCHAR(50),
    prenom VARCHAR(50),
    dateDeNaissance DATE,
    nationalite VARCHAR(50),
    FOREIGN KEY (eid) references equipes(eid) 
    
);

INSERT INTO joueurs (jid,eid,nom, prenom, dateDeNaissance, nationalite) VALUES 
(1,4,'Sanchez','Federico','1988-10-26','Argentine'),
(2,9,'Goromaru','Aymuru','1986-03-01','Japon'),
(3,7,'Foley','Bernard','1989-09-08','Australie'),
(4,6,'Pollard','Handré','1994-03-11','Afrique du Sud'),
(5,3,'Biggar','Dan','1989-10-16','Pays de Galles'),
(6,5,'Farrel','Owen','1991-09-24','Angleterre'),
(7,2,'Michalak','Frederic','1982-10-16','France'),
(8,8,'Laidlaw','Greig','1985-10-12','Ecosse'),
(9,10,'Tommaso','Allan','1993-04-26','Ecosse'),
(9,8,'Tommaso','Allan','1993-04-26','Ecosse'),
(9,1,'Tommaso','Allan','1993-04-26','Ecosse'),
(10,0,'Jaziri','Samy','1970-01-30','France');