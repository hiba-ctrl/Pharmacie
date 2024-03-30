
-- 1. requetes 
SELECT * FROM tournois;
SELECT * FROM matchs;
SELECT * FROM equipes;
SELECT * FROM participation;
SELECT annee FROM tournois WHERE pays = 'Nouvelle-Zélande';
SELECT pays FROM equipes WHERE nom = 'XV de France';
SELECT DISTINCT gagnant FROM matchs;
--2. Requêtes avec jointure
SELECT e.nom 
FROM equipes e 
JOIN participation p ON e.eid = p.eid 
JOIN tournois t ON p.tid = t.tid 
WHERE t.annee = 1991;SELECT DISTINCT nom FROM equipes JOIN matchs ON equipes.eid = matchs.gagnant;
SELECT t.nom, t.annee FROM tournois t JOIN matchs m ON t.tid = m.tournois WHERE m.perdant = 2;
SELECT m.mid FROM matchs m JOIN equipes e ON m.perdant = e.eid WHERE e.nom = 'Wallabies';
SELECT m.mid FROM matchs m JOIN equipes e ON m.gagnant = e.eid OR m.perdant = e.eid WHERE e.nom = 'All Blacks';
SELECT p.eid FROM participation p WHERE p.tid = (SELECT tid FROM tournois WHERE annee = 1991);
--3. Reqêtes avec double jointureSELECT e.nom 
SELECT E.NOM FROM EQUIPES E JOIN PARTICIPATION P ON E.EID = P.EID JOIN TOURNOIS T ON P.TID = T.TID WHERE T.ANNEE = 1991;
SELECT t.nom, t.annee FROM tournois t JOIN matchs m ON t.tid = m.tournois JOIN equipes e ON m.perdant = e.eid WHERE e.nom = 'XV de France';
SELECT e.nom,t.annee FROM tournois t JOIN matchs m ON t.tid = m.mid JOIN equipes e ON m.gagnant = e.eid WHERE m.tour = 'finale';
SELECT e.nom FROM equipes e WHERE e.eid IN ( SELECT gagnant FROM matchs GROUP BY tid, WHERE gagnant >=1 )
FROM equipes e 
JOIN matchs m ON e.eid = m.gagnant 
WHERE m.tour = 'finale' 
GROUP BY e.nom 
HAVING COUNT(*) >= 2;