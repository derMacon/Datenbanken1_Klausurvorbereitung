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
    
Inhalt: Schwerpunkte d. Lesenden Zugriffsoperatoren
1. select
2. like
3. Berechnungen im select
4. AS Ausgabe formatieren
5. ORDER BY Ausgabe sortieren
6. Join: Verknuepfen von Tabellen (Standard)
7. Outer join 
8. union (inkls. full outer join)
9. except
10. subqueries
11. Weitere Aufg. fuer die FirmaDB fuer zuhause
  
Fehler: Nochmal wiederholen
S4, S9, S10, S11, S12, S14, Uebung 3 S. 139, S18, Uebung S. 147 nr. 1
Uebung S. 149, S26, S27

Aktueller Stand: S. 169
*/



-- 1. select
-- S1: Gib alle Maschinen der firma-DB aus
select *
from firma.maschine;

-- S2: Eliminiere im Ergebnis alle Duplikate
select distinct * 
from firma.maschine;

-- S3: S3: Gib die Maschinen komplett aus, aber nur folgende Spalten und mit der
-- Attributreihenfolge: ansch_datum, name, neuwert
select ansch_datum, name, neuwert
from firma.maschine;

-- S4: Gib alle Maschinen mit obigen Spalten aus, die vor 2000 angeschafft wurden
select *
from firma.maschine
where ansch_datum < '2000-01-01';

-- S5: gleiche Frage wie S4 allerdings sollen die Maschinen zusätzlich einen
-- Neuwert > 30000 gehabt haben
select *
from firma.maschine
where ansch_datum < '2000-01-01' and neuwert > 30000;

-- S6: Gib alle Mitarbeiter der Gehaltsstufe it1 aus, die bei der AOK oder der TKK
-- krankenversichert sind. 
select *
from firma.personal
where (krankenkasse = 'aok' or krankenkasse = 'tkk') and geh_stufe = 'it1'; 

-- Uebung, S. 133: 
-- Geben Sie Maschinennamen mit Neuwert < 35.000 aus. Vermeiden Sie Duplikate.
select distinct * 
from firma.maschine
where neuwert < 35000; 

-- Geben Sie alle Kinder mit Name und Vorname aus, deren Eltern eine der folgenden 
-- pnr haben: 123, 124 und 168
select *
from firma.kind
where pnr in (123, 124, 168);

-- Geben Sie Name und Vorname des Personals aus, bei denen auch eine krankenkasse 
-- hinterlegt ist
select name, vorname
from firma.personal
where krankenkasse is not null; 


-- 2. like
-- S7: Gib alle Mitarbeiter aus die Maier, Meier oder Meyer als Namen haben. (%-Operator)
select *
from firma.personal
where name like 'M%er'; 

-- S8: Gib alle Mitarbeiter aus die Maier, Meier oder Meyer als Namen haben. (_-Operator)
select *
from firma.personal
where name like 'M__er'; 


-- 3. Berechnungen im select
-- S9: Gib das Anschaffungsjahr aller Maschinen aus
select name, year(ansch_datum)
from firma.maschine;

-- S10: Gib alle Maschinen mit ihrem Ausmusterungsjahr (Anschaffungsjahr + 20) aus. 
select name, year(ansch_datum) + 20
from firma.maschine;

-- S11: Gib alle Maschinen aus sowie deren Zeitwert + 15% (als Verkaufspreis)
select name, zeitwert * 1.15 as verkaufspreis
from firma.maschine;


-- 4. AS Ausgabe formatieren
-- Nehmen wir hierzu S11 und S12 und benennen die Spalte "YEAR(ansch_datum) + 20“ in 
-- „Ausmusterungsdatum“ sowie „Zeitwert *1.15“ in „Verkaufspreis“.
-- S12:
select name, year(ansch_datum) + 20 as ausmusterungsdatum
from firma.maschine; 

-- S13:
select name, zeitwert * 1.15 as verkaufspreis
from firma.maschine; 


-- 5. ORDER BY Ausgabe sortieren
-- S14: Zusätzliche Sortierung von S13 für Name aufsteigend und Verkaufspreis absteigend
select name, zeitwert * 1.15 as verkaufspreis
from firma.maschine
order by name asc, verkaufspreis desc; 

-- Uebung S. 139
-- Geben Sie alle Personen aus, die mit einem „H“ im Nachnamen beginnen. Die Namen sollen 
-- aufsteigend sortiert werden.
select *
from firma.personal
where name like 'H%'
order by name; 

-- Geben Sie aus, in welchen Monaten Maschinen angeschafft wurden (Ausgabe als Anschaffungsm). 
-- Die Liste soll nach dem Monat absteigend sortiert werden
select name, month(ansch_datum) as anschaffungsm
from firma.maschine
order by anschaffungsm desc; 

-- Geben Sie sortiert nach Jahr den Vornamen und das Geburtsjahr der Kinder sowie, in einer 
-- Spalte „volljährig“, in welchem Jahr diese 18 werden, aus.
select k_vorname, k_name, k_geb + 18 as volljaehrig
from firma.kind
order by k_geb; 


-- Join: Verknuepfen von Tabellen
-- S15/16: Gib alle Namen der Mitarbeiter, mit den jeweiligen Gehältern, aus.
select name, betrag
from firma.personal as p join firma.gehalt as g on p.geh_stufe = g.geh_stufe; 

-- S17: Gib alle Personen aus, die Kinder haben. Jede Person soll nur einmal 
-- ausgegeben werden.
select distinct *
from firma.personal as p join firma.kind as k on p.pnr = k.pnr; 

-- S18: Gib alle Mitarbeiter der Abteilung „Verkauf“ aus, die mehr als 2750€ Gehalt
-- haben.
select p.name
from firma.personal as p 
	join firma.abteilung as a on p.abt_nr = a.abt_nr
    join firma.gehalt as g on p.geh_stufe = g.geh_stufe
where a.name = 'verkauf' and betrag > 2750;

-- Der Anschaulichkeitshalber mal eine Uebersicht ueber saemtliche Mitarbeiter mit ihren Gehaeltern
select p.name, g.betrag
from firma.personal as p 
join firma.abteilung as a on p.abt_nr = a.abt_nr
join firma.gehalt as g on p.geh_stufe = g.geh_stufe;

-- Uebung S. 147
-- Geben Sie alle Maschinen und die Abteilungen, von denen diese Maschinen genutzt werden, aus. 
-- Es soll jeweils der Name der Abteilung, sowie der Maschine ausgegeben werden.
select m.name as maschine, a.name as abteilung
from firma.personal as p
join firma.maschine as m on p.pnr = m.pnr
join firma.abteilung as a on p.pnr;

-- Geben Sie alle Maschinen aus, die von Mitarbeiter Karl Lehmann genutzt werden. Ausgabe der 
-- Maschine als Maschinenname.
select m.name as maschinenname
from firma.maschine as m 
join firma.personal p on m.pnr = p.pnr
where p.name = 'Lehmann' and p.vorname = 'Karl';

-- Uebung S. 149 (Selfjoin)
-- Gib die Namen aller Mitarbeiter an, die die gleiche Gehaltsstufe wie Krause haben:
select x.name
from firma.personal as x
join firma.personal as y on x.geh_stufe = y.geh_stufe
where y.name = 'Krause'; 

-- S19: Gib alle Personen aus, bei denen keine Krankenkasse eingepflegt wurde
select *
from firma.personal
where krankenkasse is null; 


-- Outer Join 
-- S20:Gib alle Personen mit ihren Kindern aus, auch wenn sie keine Kinder haben.
select p.name as mitarbeiter, k.k_name as kind
from firma.personal as p 
left outer join firma.kind as k on p.pnr = k.pnr;

-- Uebung S. 156
-- Gib alle Personen aus, die keine Maschine bedienen dürfen
select *
from firma.personal as p 
left outer join firma.maschine as m on p.pnr = m.pnr
where m.pnr is null;

-- Gib alle Personen aus, die keine Prämie erhalten. Schreiben Sie die Anfrage mit einem RIGHT OUTER 
-- JOIN und mit einem LEFT OUTER JOIN.
select *
from firma.personal as pers
left outer join firma.praemie as prae on pers.pnr = prae.pnr
where prae.pnr is null;

select *
from firma.praemie as prae 
right outer join firma.personal as pers on prae.pnr = pers.pnr
where prae.pnr is null;

-- Bsp. S. 157
-- Namen aller Personen, die eine Prämie erhalten und ein Gehalt > 3000 erhalten. Prämie und Gehalt 
-- sollen ebenfalls ausgegeben werden.
select p.name, pr.p_betrag as praemie, g.betrag
from firma.personal as p 
	join firma.praemie as pr on p.pnr = pr.pnr
	join firma.gehalt as g on p.geh_stufe = g.geh_stufe
where g.betrag > 3000; 


-- union
-- S23: Gib eine Liste aller Vornamen in der Firmen DB aus. Es sollen sowohl
-- Namen des Personals als auch der Kinder ausgegeben werden. Jeder Vorname
-- soll nur einmal ausgegeben werden.
select p.vorname as vornamen
from firma.personal as p
union 
select k.k_vorname as kinderVornamen
from firma.kind as k;

-- full outer join mit union
-- S24: Gib eine Liste aller Personen und Maschinen aus. Es sollen dabei sowohl
-- Personen ohne Maschinen als auch Maschinen ohne Personen auftauchen
-- (letzteres gibt es in der Standard Firma-DB nicht).
select *
from firma.maschine as m 
right outer join firma.personal as p on m.pnr = p.pnr
union all
select *
from firma.personal as p
left outer join firma.maschine as m on p.pnr = m.pnr;


-- except 
-- S25: Gib alle Mitarbeiter aus, die nicht in der Abteilung Verwaltung arbeiten.
select *
from firma.personal
except;
select * 
from firma.personal as p 
join firma.abteilung as a on p.abt_nr = a.abt_nr
where a.name = 'Verwaltung'; 

-- subqueries
-- S26: Gib alle Mitarbeiter aus, die eine Maschine bedienen.
select * 
from firma.personal
where pnr in (
	select pnr 
    from firma.maschine); 

-- S27: Gib alle Personen aus, die Kinder haben (korrelierte Subquery).
select * 
from firma.personal as p
where exists (select *
	from firma.kind as k
    where k.pnr = p.pnr);

-- S28: Gib alle Personen aus, die Kinder haben. Variante 2 All/Any
select *
from firma.personal as p
where p.pnr = any (
	select pnr
    from firma.kind); 

-- S29: S28 min in Operator
select *
from firma.personal
where pnr in (select pnr
	from firma.kind);

-- Uebung S. 173
-- Geben Sie alle Personen aus, die eine Prämien erhalten

-- eigene Leosung
select p.name as personen
from firma.personal as p 
where exists (select *
	from firma.praemie as pr
    where pr.pnr = p.pnr);

-- Musterloesung
select p.name as personen
from firma.personal as p 
where p.pnr in (select pnr 
	from firma.praemie); 
    
-- Gib Personalnummer, Name, und Vorname des Mitarbeiters an, dessen Kind
-- Klaus Wendler heißt.
select p.pnr as personalnr, p.name, p.vorname
from firma.personal as p 
where pnr = (select pnr
	from firma.kind as k
    where k.k_name = 'Wendler' and k.k_vorname = 'Klaus'); 

-- Gib die Namen aller Kinder an, die älter als Klaus Wendler sind.
select *
from firma.kind
where k_geb < (
	select k_geb 
	from firma.kind 
	where k_name = 'Wendler' and k_vorname = 'Klaus');

-- Geben Sie alle Maschinen aus, die von Mitarbeiter Karl Lehmann genutzt
-- werden. Ausgabe der Maschine als Maschinenname.
select m.name as maschinenname
from firma.maschine as m 
where pnr = (
	select pnr 
    from firma.personal as p
    where p.name = 'Lehmann' and p.vorname = 'Karl');
    


-- Weitere Aufg. fuer die FirmaDB fuer zuhause
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

-- korrelierte Subquerie
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

SELECT *
FROM firma.personal AS p
WHERE p.pnr = ANY ( SELECT pnr
FROM firma.kind);

SELECT *
FROM firma.personal
WHERE pnr = ANY ( SELECT pnr
FROM firma.kind)