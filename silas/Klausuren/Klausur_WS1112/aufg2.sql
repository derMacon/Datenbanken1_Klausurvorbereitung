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

-- Ohne Praemien
select a.abt_nr as 'ABT NR', a.name as NAME, sum(g.betrag) as Gesamtsumme
from personal as p 
join gehalt as g using(geh_stufe)
join abteilung as a using(abt_nr)
group by abt_nr
order by Gesamtsumme desc; 

-- Mit Praemien (funktioniert mit Null-Werten leider nicht)
select a.abt_nr as 'ABT NR', a.name as NAME, 
(sum(g.betrag) + sum(pr.p_betrag)) as Gesamtsumme
from personal as p 
join gehalt as g using(geh_stufe)
join abteilung as a using(abt_nr)
left join praemie as pr using(pnr)
group by abt_nr; 

/* d) Geben Sie fuer alle Kinder, deren Muetter oder Vaeter mehr als 3000 Euro verdienen
und Mitglied der AOK oder DAK sind, den Kindernachnamen, Kindervornamen,
Nachnamen der Mutter oder des Vaters, die Hoehe des Gehaltes und die Krankenkasse 
aufsteigend sortiert nach der H¨ohe des Gehaltes aus. */

select k.k_name, k.k_vorname, p.name, g.betrag, p.krankenkasse
from kind as k 
join personal as p using(pnr)
join gehalt as g using(geh_stufe)
where 3000 < g.betrag and p.krankenkasse in ('AOK', 'DAK')
order by g.betrag; 


/* e) Ist die folgende Anfrage korrekt? Ja 2 Nein 2
select Name, Vorname, sum(p_betrag)"Praemien" FROm
Praemie p, PERSONaL
WHERE p.PNR=Personal.pnr GROUP BY Name, personal.Vorname
HAVING Count(p.PNR)>1;
Wenn die Anfrage korrekt ist, dann geben Sie das Ergebnis der Anfrage an.
Wenn die Anfrage syntaktische Fehler enthält, dann listen Sie die Fehler auf.

Nicht korrekte Anfrage, da die Bezeichner der Tabellen (Tabellennamen) 
case-sensitiv sind. */

select Name, Vorname, sum(p_betrag)"Praemien" FROm
praemie p, personal
WHERE p.PNR=personal.pnr GROUP BY Name, personal.Vorname
HAVING Count(p.PNR)>1;
