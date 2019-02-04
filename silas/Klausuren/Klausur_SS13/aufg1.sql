/* SS13 - Aufg. 1
Wir betrachten die in der Vorlesung behandelte Datenbank Firma mit den Tabellen Maschinen,
Mitarbeiter, Gehalt, Kind. Beispieltabellen, aus denen sich auch das Datenbankschema ablesen
lässt, finden sich auf dem zusätzlich ausgeteilten Blatt.
Schreiben Sie bitte SQL-Anweisungen, um die folgenden
”Fragen“ zu beantworten.

a) Wie viele Bohrmaschinen besitzt die Firma? */

select count(*)
from maschine 
where name = 'bohrmaschine';


/* b)  Geben Sie bitte zu jedem Mitarbeiter (Spalten Name und Vorname) aus, wie
hoch sein monatliches Gehalt (Spaltenüberschrift Gehalt) ist. Das Ergebnis soll
absteigend nach Höhe des Gehalts der Mitarbeiter, bei gleichem Gehalt
nach Nachname, dann Vorname sortiert werden */

select p.name, vorname, betrag as Gehalt
from personal as p
join gehalt using(geh_stufe) 
order by betrag desc, p.name, vorname;

/* c) Die an Gehältern zu zahlende Gesamtsumme pro Abteilung soll absteigend sor-
tiert nach der Gesamtsumme in einer Tabelle mit der Ueberschrift ABT NR, NAME,
Gesamtsumme ausgegeben werden. */

select abt_nr as 'ABT NR', a.name as NAME, sum(betrag) as Gesamtsumme
from abteilung as a 
join personal using(abt_nr)
join gehalt using(geh_stufe)
group by abt_nr
order by 3 desc;


/* d) Benutzen Sie bitte Unterabfragen und vermeiden Sie Joins: Geben Sie bitte Na-
me, Vorname und Personalnummer aller Mitarbeiter an, bei denen minde-
stens ein Kind im gleichen Jahr geboren ist, indem auch mindestens eine Maschine
angeschafft worden ist. */

-- mit Subquery
select name, vorname, pnr
from personal
where pnr in (
	select pnr
    from kind 
    where year(k_geb) in (
		select year(ansch_datum)
        from maschine
    )
);

-- mit join
select p.name, vorname, pnr
from personal as p 
join maschine using(pnr)
join kind using(pnr)
where year(k_geb) = year(ansch_datum);


/* e) Von allen Mitarbeitern sollen Name und Vorname und unter der Spaltenüber-
schrift Anzahl-Kinder die Zahl der Kinder angegeben werden. Sind keine Kinder
vorhanden, soll für die Anzahl die Zahl 0 ausgegeben werden. Sortiert werden
soll absteigend nach der Zahl der Kinder und bei gleicher Kinderzahl aufsteigend
nach den Familiennamen */

select p.name, p.vorname, count(k_geb) as 'Anzahl-Kinder'
from personal as p 
left join kind using(pnr)
group by pnr
order by 3 desc, p.name;


/* f) Welche Abteilungen haben mehr als 2 Mitarbeiter? Es soll der Name der Abtei-
lung und die Anzahl ihrer Mitarbeiter, sortiert nach Abteilungsname ausgegeben
werden. */

select a.name, count(*) as AnzMitarbeiter
from personal as p 
join abteilung as a using(abt_nr)
group by abt_nr
having AnzMitarbeiter > 2
order by a.name; 


/* g) Welche Mitarbeiter haben keine Prämie erhalten? */

select name, vorname, pnr
from personal 
left join praemie using(pnr)
group by pnr
having count(p_betrag) = 0; 

-- Musterloesung: 
SELECT pnr, name, vorname
FROM personal
WHERE pnr NOT IN (SELECT pnr FROM praemie);
