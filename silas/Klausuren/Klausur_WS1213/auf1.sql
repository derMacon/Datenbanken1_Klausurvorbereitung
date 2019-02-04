/* WS1213 - Aufg. 1
Wir betrachten die in der Vorlesung behandelte Datenbank mit den Tabellen Maschinen, Mit-
arbeiter, Gehalt, Kind. Beispieltabellen aus denen sich auch das Datenbankschema ablesen
lässt, finden sich am Anfang dieser Klausur. Diesen Zettel können Sie ruhig aus der Klausur
herauslösen. Notizen, die Sie darauf machen, werden nicht gewertet.
Schreiben Sie bitte SQL-Anweisungen, die die folgenden Informationen liefern.

a) Für jede Maschine soll das Alter (im Jahr 2013) und der bisherige j¨ ahr-
liche Wertverlust in Euro berechnet werden. Die Ausgabespalten sollen die¨
Ueberschriften ” MNR“, ” Alter“ und ” Wertverlust pro Jahr“ tragen. */

select mnr as MNR, (2013 - year(ansch_datum)) as 'Alter', 
((neuwert - zeitwert) / (2013 - year(ansch_datum))) as 'Werteverlust pro Jahr'
from maschine; 


/* b)  Ermitteln Sie bitte, welche Mitarbeiter die Gehaltsstufe it2 haben? Das Er-
gebnis soll aufsteigend nach Namen und Vornamen der Mitarbeiter sortiert
werden. */

-- mit Schluesselwort where
select *
from personal 
join gehalt using(geh_stufe)
where geh_stufe = 'it2';

-- mit Schluesselwort on 
select *
from personal as p
join gehalt as g on p.geh_stufe = g.geh_stufe and p.geh_stufe = 'it2'; 

/* c) Wieviele Praemien hat die Firma bisher gezahlt und wie hoch ist der Ge-
samtbetrag der gezahlten Prämien? Die Ausgabespalten sollen die ¨ Uberschriften
”Anzahl“ und ”Prämien (gesamt)“ tragen. */

select count(*) as Anzahl, sum(p_betrag) as 'Praemie (gesamt)'
from praemie; 


/* d) Bestimmen Sie bitte, welcher Mitarbeiter alleine oder welche Mitarbeiter ge-
meinsam die höchste Praemie erhalten haben? Wie hoch ist die höchste Prämie?
Ermittelt werden sollen Vorname und Name des/der Mitarbeiter/s sowie die
Höhe der höchsten Praemie (Ausgabespaltenüberschriften:
” Vorname“, ” Name“, ” Spitzenprämie“). */

select *
from personal
join praemie using(pnr)
where p_betrag = (
	select max(p_betrag) 
    from praemie
);

/* e) Stellen Sie bitte unter Verwendung des EXISTS-Operators die Namen und Vor-
namen derjenigen Kinder fest, deren Eltern eine Praemie von mehr als 400
Euro erhalten haben. Jedes Kind soll nur ein einziges mal erscheinen. */

-- mit Exists-Operator
select distinct k_name, k_vorname
from kind as k
where exists (
	select *
    from personal as p
    where k.pnr = p.pnr and p.pnr in (
		select pnr
        from praemie as pr
        where p_betrag > 400
    )
);

-- per Join-Operator
select distinct k_name, k_vorname
from kind 
join personal using(pnr)
join praemie using(pnr)
where p_betrag > 400; 


/*  Ist die folgende Anfrage korrekt? Ja 2 Nein 2
FROM personal as p
SELECT p.pnr; p.name; p.vorname
HAVING p.krankenkase=aok
ORDER_BY p.name DESCENDING
Wenn die Anfrage korrekt ist, dann geben Sie bitte das Ergebnis der Anfrage an.
Wenn die Anfrage Fehler enthält, dann listen Sie bitte die Fehler auf. 

Antwort: 
	- Erste Zeile: kann nicht mit Schluesselwort "From" beginnen 
    - Zweite Zeile: Semikolon kein gueltiges Trennzeichen 
    - Dritte Zeile: Having-ohne zugehoerigen Group-By-Operator
    - Vierte Zeile: Das Schluesselwort "DESCENDING" ist nicht existent 

Richtig wuerde die Anfrage folgendermassen aussehen: */

SELECT p.pnr, p.name, p.vorname
FROM personal as p
where p.krankenkase = 'aok'
ORDER BY p.name desc;
