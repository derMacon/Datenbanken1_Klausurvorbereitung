/* SS16, Aufg. 2
a) Welche Kinder der Mitarbeiter sind seit dem Jahr 2000 geboren worden? Bitte
geben sie Vorname und Nachname der Kinder, sowie ihr Geburtsjahr aus. */

select k_vorname, k_name, k_geb
from kind 
where k_geb >= 2000; 

/* Erwartete Ausgabe: 
k_vorn | k_name | k_geb
Sven, Lehmann, 2002
Karl, Lehmann, 2004
Susi, Meier, 2002
Dirk, Meier, 2004


/* Welche Mitarbeiter sind verantwortlich für Hobel- bzw. Bohrmaschinen? Geben
Sie bitte Namen und Vornamen der Mitarbeiter, die Maschinennummer MNR
und den Namen der Maschine aus.
Sortieren Sie die Ergebniszeilen bitte nach Name und Vorname des Mitarbeiters,
bei gleichem Mitarbeiter nach Maschinennummer. Verwenden Sie bitte den IN-
Operator. Achten Sie auf mögliche Konflikte in den Spaltennamen. */

select p.name, p.vorname, m.mnr, m.name
from personal as p
join maschine as m using(pnr)
where m.name in ('Hobelmaschine', 'Bohrmaschine')
order by p.name, p.vorname, m.mnr; 

/* Erwartete Ausgabe:
name | vorname | mnr | name
Ehlert, Siegried, 11, hobelmaschine
Ehlert, Siegried, 17, hobelmaschine
Lehmann, Karl, 1, bohrmaschine
Lehmann, Karl, 2, bohrmaschine
Lehmann, Karl, 14, hobelmaschine */


/* Benutzen Sie bitte Unterabfragen und vermeiden Sie Joins: Welche Mitarbeiter
(Personalnummer, Vorname, Nachname) haben das geringste Gehalt? */

select pnr, vorname, name
from personal
where geh_stufe = (
	select geh_stufe
    from gehalt 
    where betrag = (
		select min(betrag) 
        from gehalt
    )
);

/* Erwartete Ausgabe: 
In der online Version sind die Eintraege nach PNR sortiert, daher dort andere 
Reihenfolge als bei der gegebenen DB der Klausur. 
pnr | vorname | name 
133, Harry, Schulz
156, Juergen Hartmann
127, Siegfried, Ehlert
157, Hans, Schultze
137, Gert, Haase 

------

Welche konkrete Antwort liefert dabei Ihre (innerste) Unterabfrage?

A: Den geringsten Betrag saemtlicher Gehaltsstufen (Wert = 2523 GE)

------

Sind Ihre Unterabfragen korreliert oder unkorrelliert? Bitte begründen Sie Ihre Antwort.

A: Unkorreliert, es wird in den Unterabfragen auf keine Relation der uebergeordneten 
Anfragen zugegriffen. 

------

d) Stellen Sie bitte unter Verwendung des EXISTS-Operators mit Unterabfrage die
Vornamen und Nachnamen derjenigen Kinder fest, deren Eltern in der Abteilung
Projektierung arbeiten. */

select k_vorname, k_name
from kind as k
where exists (
	select p.pnr 
	from personal as p 
	where exists (
		select *
		from abteilung as a
		where name = 'Projektierung' 
			and p.abt_nr = a.abt_nr
            and k.pnr = p.pnr
	)
); 

/* Erwartete Ausgabe: 
k_vorn | k_name 
Fritz, Krause
Ida, Krause

------

Ist Ihre Unterabfragen korreliert oder unkorrelliert? Bitte begründen Sie Ihre Antwort.

A: Korreliert, es wird innerhalb der innersten Unterabfrage auf die beiden aeusseren per 
Punktnotation Bezug genommen. 

------

e) Welche Abteilungen haben mehr als 2 Mitarbeiter? Es soll der Name der Abtei-
lung und die Anzahl ihrer Mitarbeiter, sortiert nach Abteilungsname ausgegeben
werden. */

select a.name, count(*) as anzahl 
from personal as p 
join abteilung as a using (abt_nr)
group by a.abt_nr
having anzahl > 2
order by a.name; 

/* Erwartete Anfragen 
name | anzahl 
Produktion, 8
Verwaltung, 3

f) Wie hoch ist der monatliche Durchschnittstverdienst der Mitarbeiter, die
in der Abteilung Verwaltung arbeiten? Die Ausgabe soll die Ueberschrift
Durchschnittsgehalt/Monat haben */

select avg(betrag) as 'Durchschnittsgehalt/Monat'
from personal as p 
join abteilung as a using(abt_nr)
join gehalt as g using(geh_stufe)
where a.name = 'Verwaltung'; 

/* 
g) Wieviele Kinder haben die Mitarbeiter der Firma jeweils? Geben Sie bitte für
jeden Mitarbeiter (Personalnummer, Vorname, Nachname) unter der Ueberschrift
Anz-Kinder an, wie viele Kinder er oder sie hat. Für kinderlose Mitarbeiter, soll
0 ausgegeben werden. Sortierung absteigend nach Anzahl der Kinder bei gleicher
Kinderzahl aufsteigend nach Name und Vorname des Mitarbeiters */

select p.pnr, p.vorname, p.name, count(k.pnr) as 'Anz-Kinder'
from personal as p 
left join kind as k using(pnr)
group by pnr
order by 'Anz-Kinder' desc, p.name, p.vorname; 


