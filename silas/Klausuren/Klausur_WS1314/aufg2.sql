-- WS1314, Aufg. 2
/* a) Wer sind die Mitarbeiter der Firma? Geben Sie bitte die Personalnummer, den
Vor- und den Nachnamen der Mitarbeiter aus. */

select pnr, vorname, name
from personal; 

/* b) Welches sind die Mitarbeiter der Firma, die in der Barmer Ersatzkasse (bek)
versichert sind? Bitte geben sie wiederum die Personalnummer, den Vor- und den
Nachnamen aus. */

select pnr, vorname, name
from personal
where krankenkasse = 'bek'; 

/* Welche konkrete Antwort liefert diese Anfrage? 

pnr | vorname | name
168, Hahn, Egon
156, Hartmann, Juergen


c) Wie hoch ist das jeweilige Monatsgehalt der Mitarbeiter, die in den Abteilungen
d12 und d15 arbeiten? Geben Sie bitte den monatlichen Betrag unter der Spal-
tenüberschrift Monatsgehalt, die Personalnummer, sowie Vorname und Nachna-
me an. Sortieren Sie bitte das Ergebnis absteigend nach Höhe des Gehalts, bei
gleichen Gehältern aufsteigend nach Nachname und Vorname des Mitarbeiters.
Verwenden Sie bitte den IN-Operator. */

select betrag as Monatsgehalt, pnr, name, vorname, abt_nr
from personal
join gehalt using(geh_stufe)
where abt_nr in ('d12', 'd15')
order by Monatsgehalt desc, name, vorname; 

/* Welche konkrete Antwort liefert diese Anfrage? 
Monatsgehalt | pnr | name | vorname | abt_nr
3027, 167, Krause, Gustav, d12
159, Osswald, Petra, d15
2523, 127, Ehlert, Siegfried, d15


d) Unter der Ueberschrift Gesamtsumme soll der Betrag ausgegeben werden, den un-
sere Firma insgesamt an Gehalt auszahlen muss. */

select sum(betrag) as Gesamtsumme
from personal join gehalt using (geh_stufe); 

-- Musterloesung
SELECT sum(betrag)"Gesamtsumme"
FROM personal p, gehalt g
WHERE p.geh_stufe=g.geh_stufe;


/* e) Für wie viele Maschinen sind die Mitarbeiter verantwortlich?
Geben Sie bitte für jeden Mitarbeiter (Personalnummer, Vorname, Nachname)
unter der Ueberschrift Anz-Maschinen an, für wie viele Maschinen er oder sie
verantwortlich ist. Für Mitarbeiter, die für keine Maschine verantwortlich sind,
soll 0 ausgegeben werden. Sortierung aufsteigend nach Anzahl der Maschinen-
Verantwortlichkeiten. */

select count(mnr) as 'Anz-Maschine', pnr, vorname, p.name
from personal as p
left join maschine as m using(pnr)
group by pnr
order by 1; 


/* f) Benutzen Sie bitte Unterabfragen und vermeiden Sie Joins: Welche Mitarbeiter
(Personalnummer, Vorname, Nachname) haben die höchste Einzelprämie erhal-
ten? */

select pnr, vorname, name 
from personal 
where pnr = (
	select pnr
	from praemie 
	where p_betrag = (
		select max(p_betrag) 
		from praemie
	)
);


/* Welche konkrete Antwort liefert diese Anfrage? 

pnr | vorname | name
168, Egon, Hahn


/* Sind Ihre Unterabfragen korreliert oder unkorrelliert? Bitte begründen Sie Ihre
Antwort. 

Die Unterabfragen sind unkorreliert, da von den inneren kein Bezug auf die aeusseren 
genommen wird. 


g) Welche Mitarbeiter (Personalnummer, Vorname, Nachname) haben Prämien er-
halten? Jeder Mitarbeiter soll nur einmal genannt werden, selbst wenn er mehrere
Prämien erhalten hat. */

select distinct pnr, vorname, name 
from personal
join praemie using (pnr); 


/* Welche konkrete Antwort liefert diese Anfrage? 

pnr | vorname | name 
227, Walter, Wagner
124, Richard, Meier
234, August, Krohn
168, Egon, Hahn

Tragen Sie bitte die Antwort auf die folgenden Anfrage in die Tabelle ein: */

SELECT DISTINCT pnr , vorname , name
FROM personal JOIN kind USING ( pnr )
WHERE abt nr='d13';

/* Welche Frage wird mit der oberen Anfrage beantwortet? 

Welche Mitarbeiter der Abteilung d13 haben Kinder? */
