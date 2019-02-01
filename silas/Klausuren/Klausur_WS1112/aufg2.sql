/* WS1112 - Aufg. 2
Wir betrachten die in der Vorlesung behandelte Datenbank mit den Tabellen Maschinen, Mitar-
beiter, Gehalt, Kind. Beispieltabellen aus denen sich auch das Datenbankschema ablesen lässt,
finden sich sich am Anfang dieser Klausur.
Schreiben Sie bitte SQL-Anweisungen, um die folgenden
” Fragen“ zu beantworten.

a) Unter der Ueberschrift Gesamtsumme soll der Betrag ausgegeben werden, den un-
sere Firma insgesamt an Gehalt auszahlen muss. */

select sum(betrag)
from personal 
join gehalt using (geh_stufe); 

/* b) Von allen Mitarbeitern sollen Name und Vorname des Mitarbeiters und unter der
Spaltenüberschrift Anzahl-Kinder die Zahl der Kinder angegeben werden. Sind
keine Kinder vorhanden, soll für die Anzahl die Zahl 0 ausgegeben werden. Sor-
tiert werden soll absteigend nach der Zahl der Kinder und bei gleicher Kinderzahl
aufsteigend nach den Familiennamen. */ 

select name, vorname, count(k_name) as 'Anzahl-Kinder'
from personal
left join kind using(pnr)
group by (pnr)
order by 3 desc, 2; 

/* c) Die zu zahlende Gesamtsumme pro Abteilung soll absteigend sortiert nach Ab-
teilungsname in einer Tabelle mit der Ueberschrift ABT NR, NAME, Gesamtsumme
ausgegeben werden. */

select a.abt_nr as 'ABT NR', a.name as NAME, (sum(pr.p_betrag)) as Gesamtsumme
from personal as p 
join gehalt as g using(geh_stufe)
join abteilung as a using(abt_nr)
left join praemie as pr using(pnr)
group by abt_nr; 




