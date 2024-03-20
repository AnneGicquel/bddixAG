--1. Liste des potions : Numéro, libellé, formule et constituant principal. (5 lignes)
select *
from potion ;

--2. Liste des noms des trophées rapportant 3 points. (2 lignes)

select nom_categ as trophees_rapportant_3_points
from categorie 
where nb_points = 3 ;

--3. Liste des villages (noms) contenant plus de 35 huttes. (4 lignes)

select nom_village as villages_contenant_plus_de_35_huttes
from village where nb_huttes > 35 ;

--4. Liste des trophées (numéros) pris en mai / juin 52. (4 lignes)

select num_preneur as trophees_pris_en_mai_juin_52
from trophee 
where date_prise 
between '2052-05-05 00:00:00' and '2052-06-06 00:00:00';

--5. Noms des habitants commençant par 'a' et contenant la lettre 'r'. (3 lignes)

select nom as noms_habitants_commencant_par_a_contenant_r 
from habitant 
where nom like ('A%') and nom like ('%r%');

--6. Numéros des habitants ayant bu les potions numéros 1, 3 ou 4. (8 lignes)

select distinct h.nom as num_hab_ayant_absorbes_potions_1_3_ou_4
from habitant h
join absorber a on h.num_hab = a.num_hab 
where num_potion in (1,3,4)  ;

--7. Liste des trophées : numéro, date de prise, nom de la catégorie et nom du preneur. (10lignes)

select t.num_preneur as numero_de_trophee, t.date_prise, c.nom_categ , h.nom as nom_preneur_se 
from trophee t
join categorie c on t.code_cat = c.code_cat 
join habitant h on t.num_preneur = h.num_hab ;

--8. Nom des habitants qui habitent à Aquilona. (7 lignes)

select h.nom as noms_habitant_e_s_aquilona
from habitant h
join village v on v.num_village = h.num_village 
where v.nom_village = 'Aquilona';


--9. Nom des habitants ayant pris des trophées de catégorie Bouclier de Légat. (2 lignes)

select h.nom as hab_ayant_pris_BLT
from habitant h
join trophee t on h.num_hab  = t.num_preneur 
where t.code_cat = 'BLT';

--10. Liste des potions (libellés) fabriquées par Panoramix : libellé, formule et constituantprincipal. (3 lignes)

select distinct p.lib_potion as potion_par_Panoramix
from potion p 
join fabriquer f on p.num_potion = f.num_potion 
join habitant h  on h.num_hab = f.num_hab 
where h.nom = 'Panoramix';

--11. Liste des potions (libellés) absorbées par Homéopatix. (2 lignes)

select distinct p.lib_potion as potion_bue_par_Homeopatix
from potion p 
join absorber a on p.num_potion = a.num_potion 
join habitant h on a.num_hab = h.num_hab 
where h.nom = 'Homéopatix';


--12. Liste des habitants (noms) ayant absorbé une potion fabriquée par l'habitant numéro 3. (4 lignes)

select distinct h.nom as hab_ayant_bu_potion_made_by_hab_3
from habitant h
join absorber a on h.num_hab = a.num_hab
join fabriquer f on a.num_potion = f.num_hab
where f.num_hab = 3;


--13. Liste des habitants (noms) ayant absorbé une potion fabriquée par Amnésix. (7 lignes)

select distinct h.nom
from habitant h
join absorber a on h.num_hab = a.num_hab
join fabriquer f on a.num_potion = f.num_potion
join habitant hBis on f.num_hab = hBis.num_hab
where hBis.nom = 'Amnésix';


--14. Nom des habitants dont la qualité n'est pas renseignée. (2 lignes)

select h.nom
from habitant h 
left join qualite q on h.num_qualite = q.num_qualite 
where q.lib_qualite is null;

--15. Nom des habitants ayant consommé la Potion magique n°1 (c'est le libellé de la potion) en février 52. (3 lignes)

select h.nom
from habitant h 
join absorber a on h.num_hab = a.num_hab 
join potion p on a.num_potion = p.num_potion 
where p.lib_potion = 'Potion magique n°1'
and a.date_a in ('2052-02-18 00:00:00','2052-02-20 00:00:00','2052-02-20 00:00:00','2052-02-20 00:00:00');


--16. Nom et âge des habitants par ordre alphabétique. (22 lignes)

select h.nom, h.age
from habitant h 
order by h.nom asc;

--17. Liste des resserres classées de la plus grande à la plus petite : nom de resserre et nom du village. (3 lignes)

select r.nom_resserre
from resserre r
join village v on r.num_resserre  = v.num_village 
order by r.superficie asc;

--***

--18. Nombre d'habitants du village numéro 5. (4)

select h.nom
from habitant h 
join village v on h.num_village = v.num_village 
where h.num_village  = 5;


--19. Nombre de points gagnés par Goudurix. (5)

select c.nb_points,h.num_hab, h.nom
from categorie c 
join trophee t on c.code_cat = t.code_cat 
join habitant h on t.num_preneur  = h.num_hab 
where h.nom = 'Goudurix'; 

--20. Date de première prise de trophée. (03/04/52)

select min(t.date_prise)
from trophee t;


--21. Nombre de louches de Potion magique n°2 (c'est le libellé de la potion) absorbées. (19)

select a.quantite
from absorber a 
join potion p on a.num_potion  = p.num_potion  
where p.lib_potion = 'Potion magique n°2';

--22. Superficie la plus grande. (895)

select max(r.superficie)
from resserre r;

--***

--23. Nombre d'habitants par village (nom du village, nombre). (7 lignes)

SELECT v.nom_village, COUNT(h.num_hab) AS nombre_habitants
FROM habitant h
JOIN village v ON h.num_village = v.num_village
GROUP BY v.nom_village;


--24. Nombre de trophées par habitant (6 lignes)

select h.nom, count(t.num_preneur)
from habitant h 
join trophee t on h.num_hab = t.num_preneur
group by h.nom ;


--25. Moyenne d'âge des habitants par province (nom de province, calcul). (3 lignes)

SELECT v.num_province AS nom_de_province, AVG(h.age) AS calcul
FROM habitant h
JOIN village v ON h.num_village = v.num_village
GROUP BY v.num_province;


--26. Nombre de potions différentes absorbées par chaque habitant (nom et nombre). (9lignes)

SELECT h.nom AS nom_habitant, COUNT(DISTINCT a.num_potion) AS nombre_de_potions_differentes
FROM habitant h
JOIN absorber a ON h.num_hab = a.num_hab
GROUP BY h.nom;


--27. Nom des habitants ayant bu plus de 2 louches de potion zen. (1 ligne)

select h.nom , a.quantite 
from habitant h 
join absorber a on h.num_hab = a.num_hab
join potion p on a.num_potion = p.num_potion 
where a.quantite > 2 and p.lib_potion = 'Potion Zen';


--***
--28. Noms des villages dans lesquels on trouve une resserre (3 lignes)

select v.nom_village
from village v
join resserre r on v.num_village = r.num_village ;

--29. Nom du village contenant le plus grand nombre de huttes. (Gergovie)

select v.nom_village
from village v 
 WHERE v.nb_huttes = (
    SELECT MAX(nb_huttes)
    FROM village
);

--30. Noms des habitants ayant pris plus de trophées qu'Obélix (3 lignes).

select distinct h.nom as hab_ayant_plus_de_trophees_qu_obelix
from habitant h
join trophee t on h.num_hab = t.num_preneur
where (select count(*) from trophee where num_preneur = h.num_hab) > 
      (select count(*) from trophee where num_preneur = (select num_hab from habitant where nom = 'Obélix'));
