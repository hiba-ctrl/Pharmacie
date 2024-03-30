-- requete 1

SELECT Distinct Joueurtennis.nom, Joueurtennis.annaiss
FROM Joueurtennis
JOIN Rencontre ON Joueurtennis.nujoueur = Rencontre.nugagnant OR Joueurtennis.nujoueur = Rencontre.nuperdant
WHERE Rencontre.lieutournoi = 'Roland Garros' AND Rencontre.annee = 1994;


 -- requete 2
SELECT DISTINCT Joueurtennis.nom, Joueurtennis.nationalite
FROM Joueurtennis
JOIN Rencontre RG ON Joueurtennis.nujoueur = RG.nugagnant OR Joueurtennis.nujoueur = RG.nuperdant
JOIN Rencontre W ON Joueurtennis.nujoueur = W.nugagnant OR Joueurtennis.nujoueur = W.nuperdant
WHERE RG.lieutournoi = 'Roland Garros' AND RG.annee = 1994
AND W.lieutournoi = 'Wimbledon' AND W.annee = 1992;
-- requete 3

SELECT DISTINCT Joueurtennis.nom, Joueurtennis.nationalite
FROM Joueurtennis
JOIN Rencontre ON Joueurtennis.nujoueur = Rencontre.nugagnant
JOIN Gain ON Joueurtennis.nujoueur = Gain.nujoueur
WHERE Gain.sponsor = 'Peugeot' AND Rencontre.lieutournoi = 'Roland Garros';

-- requete 4

SELECT DISTINCT Joueurtennis.nujoueur 
FROM Joueurtennis
JOIN Rencontre ON Joueurtennis.nujoueur = Rencontre.nuperdant Where Rencontre.lieutournoi = 'Wimbledon'
JOIN Gain  