-- Requete 1
SELECT * FROM produit;
SELECT * FROM usine;
SELECT * FROM magasin;
SELECT * FROM provenance;

-- Requete 2

SELECT ville FROM usine;
SELECT DISTINCT ville FROM usine;

-- Requete 3

SELECT nom_prod, couleur FROM produit;

-- Requete 4

SELECT ref_prod, quantite FROM provenance;

-- Requete 5 

SELECT ref_usine, nom_usine, ville FROM usine WHERE ville = 'Marseille';

-- Requete 6 


-- Requete 7 
SELECT ref_prod, nom_prod FROM produit WHERE poids > 15 AND poids poids < 45;

-- Requete 8 
SELECT ref_prod, nom_prod FROM produit WHERE couleur = 'rouge';

-- Requete 9 
SELECT nom_mag FROM magasin WHERE nom_mag LIKE 'L%';

-- Requete 10 
SELECT 
