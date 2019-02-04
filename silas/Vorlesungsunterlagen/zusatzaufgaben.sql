/* Beispiele aus der Vorlesung:
● Alle im Folgenden betrachteten Beispiele werden in der Firma-DB
  durchgeführt. Diese Datenbank können Sie auch für eigene Übungen
  zuhause nutzen.
● Eine virtuelle Maschine (Virtual Box), in der eine MySQL-Datenbank mit allen
  Daten läuft und eine entsprechende Anleitung zur Installation finden Sie auf
  der Übungswebseite unter
  http://intern.fh-wedel.de/mitarbeiter/mpa/db/ws18/
● Die virtuelle Maschine können Sie später auch für die Übungen nutzen
● Nutzen Sie diese Möglichkeit die Beispiele aus der Vorlesung
  nachzuvollziehen. SQL-Befehle benötigen Übung!
  
Aufbau der Datenbank "firma":
● = Name der Datenbank
- = Name einzelner Tabellen
+ = Spaltenueberschriften

● firma 
  - abteilung
    + abt_nr
    + name
  - gehalt
    + geh_stufe
    + betrag
  - kind
    + pnr
    + k_name
    + k_vorname
    + k_geb
  - maschine 
    + mnr
    + name 
    + pnr
    + ansch_datum
    + neuwert
    + zeitwert
  - personal
    + pnr
    + name
    + vorname
    + geh_stufe
    + abt_nr
    + krankenkasse
  - praemie
    + pnr
    + p_betrag
*/


-- Weitere Aufg. fuer zuhause
-- Finden Sie die Namen aller Mitarbeiter, die an einer Bohrmaschine arbeiten
-- dürfen.

-- unkorrelierte Subquery
select distinct name as mitarbeiter
from firma.personal
where pnr in (
	select pnr 
    from firma.maschine 
    where name = 'Bohrmaschine'); 

-- Inner Join
select distinct p.name as mitarbeiter
from firma.personal as p 
join firma.maschine as m 
on p.pnr = m.pnr and m.name = 'Bohrmaschine'; 


-- Nennen Sie die Namen aller Mitarbeiter, die nicht in der Verwaltung arbeiten.
-- unkorrelierte Subquery
select name as mitarbeiter, abt_nr
from firma.personal 
where abt_nr not in (
	select abt_nr
    from firma.abteilung
    where name = 'Verwaltung')
order by name;

-- korrelierte Subquery
select name as mitarbeiter, abt_nr
from firma.personal as p
where not exists (
	select *
    from firma.abteilung as a
    where a.name = 'Verwaltung' and p.abt_nr = a.abt_nr)
order by name;
    
-- join
select p.name as mitarbeiter, a.name as abteilungsname
from firma.personal as p 
join firma.abteilung as a on p.abt_nr = a.abt_nr and a.name != 'Verwaltung'
order by p.name;


-- Finden Sie die Vornamen, die sowohl Vornamen der Mitarbeiter als auch
-- Vornamen der Kinder sind. (Hinweis: IN)
-- unkorrelierte Subquery: in-Operator
select vorname
from firma.personal
where vorname in (
	select vorname 
    from firma.kind
    where vorname = k_vorname); 

-- korrelierte Subquery: exists-Operator
select vorname
from firma.personal
where exists (
	select vorname 
    from firma.kind
    where vorname = k_vorname); 

-- join 
select p.vorname 
from firma.personal as p 
join firma.kind as k on p.vorname = k.k_vorname; 


-- Finden Sie die Vornamen der Mitarbeiter, die keine Vornamen der Kinder
-- sind. (Hinweis: NOT IN)
-- unkorrelierte Subquery
select vorname
from firma.personal
where vorname in (
	select vorname 
    from firma.kind
    where vorname != k_vorname); 

-- unkorrelierte Subquery
select vorname
from firma.personal
where vorname not in (
	select vorname 
    from firma.kind
    where vorname = k_vorname); 

-- join 
select p.vorname 
from firma.personal as p 
join firma.kind as k on p.vorname != k.k_vorname; 


-- Nennen Sie Namen und Vornamen aller Mitarbeiter, die in der Abteilung
-- Lagerung arbeiten. (Hinweis: ANY)
-- unkorrelierte Subquery
select name, vorname
from firma.personal 
where abt_nr = any (
	select abt_nr
    from firma.abteilung
    where name = 'Lagerung');   

-- korrelierte Subquerie
select p.name, p.vorname
from firma.personal as p
where exists (
	select *
    from firma.abteilung as a
    where a.name = 'Lagerung' and p.abt_nr = a.abt_nr);

-- join 
select p.name, p.vorname
from firma.personal as p 
join firma.abteilung as a on p.abt_nr = a.abt_nr and a.name = 'Lagerung';


-- Nennen Sie den Prämienbetrag des Mitarbeiters, der die größte PNR hat.
-- (Hinweis: ALL)
-- unkorrelierte Subquery mit aufgelisteten Praemien
select pnr, p_betrag
from firma.praemie
where pnr >= all (
	select pnr 
    from firma.personal);

-- unkorrelierte Subquerie mit aufsummierten Praemien
select pnr as personalnr, sum(p_betrag) as aufsummiertePraemien
from firma.praemie
where pnr >= all (
	select pnr 
    from firma.personal);
    
-- unkorrelierte Subquerie mit aufsummierten Praemien
select pnr as personalnr, sum(p_betrag) as aufsummiertePraemien
from firma.praemie
where pnr >= all (
	select pnr 
    from firma.personal);

-- selfjoin hier moeglich??? Vgl. Folie 57
