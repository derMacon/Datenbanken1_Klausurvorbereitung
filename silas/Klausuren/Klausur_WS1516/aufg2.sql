/* 2 a)
Welche Maschinen besitzt die Firma, die vor 2000 angeschafft wurden? Geben
Sie bitte jeweils die Maschinen-Nummer, den Namen der Maschine und das An-
schaffungsjahr aus. Sortieren Sie die Ausgabe absteigend nach Anschaffungsjahr.*/

select mnr, name, ansch_datum
from maschine 
where year(ansch_datum) < 2000
order by ansch_datum DESC;


/* 2 b)
Welche MitarbeiterInnen arbeiten in den Abteilungen Verwaltung und Projektie-
rung? Geben Sie bitte den Abteilungsnamen (Spaltenüberschrift Abteilung) und
den Namen und Vornamen der MitarbeiterInnen aus.
Sortieren Sie die Ergebniszeilen bitte aufsteigend nach Abteilungsname und bei
gleicher Abteilung aufsteigend nach Name und Vorname des Mitarbeiters/der
Mitarbeiterin. */

select a.name as Abteilung, p.name as Name, p.vorname as Vorname
from personal as p 
join abteilung as a using(abt_nr)
where a.name in ('Verwaltung', 'Projektierung')
order by a.name, p.name, p.vorname;


/* 2 c)
 Für jeden Mitarbeiter (Name, Vorname) und jede Mitarbeiterin soll ermittelt wer-
den, wieviele Prämien er oder sie bekommen hat (Spaltenname Prämienanzahl).
MitarbeiterInnen ohne Prämie sollen dabei mit Prämienanzahl 0 auftreten. Das
Ergebnis soll absteigend nach Anzahl der Prämien sortiert sein, bei gleicher An-
zahl alphabetisch aufsteigend nach Name und Vorname. */

select name as Name, vorname as Vorname, coalesce(count(pr.pnr), 0) as Praemienanzahl
from personal as p
left join praemie as pr using(pnr)
group by p.pnr
order by count(pr.pnr) desc, name, vorname; 


/* 2 d)
Beantworten Sie zunächst die Fragen nach den konkreten Werten:

1. Wie hoch ist konkret das höchste Gehalt? (Zahlenwert als Antwort erwartet)
Antwort: 3782

2. In welche konkreten Gehaltstufe wird dieses höchste Gehalt gezahlt?
(Gehaltsstufen-Kürzel als Antwort erwartet)
Antwort: it5

3. An welche konkreten Mitarbeiter wird diese Gehaltsstufe gezahlt? (Perso-
nalnummern als Antwort erwartet)
Antwort: 124, 134

4. In welchen konkreten Abteilungen arbeiten diese Mitarbeiter? (Abteilungs-
namen als Antworten erwartet)
Antwort: Verwaltung, Produktion

Erstellen Sie nun eine Datenbankabfrage hierzu: Benutzen Sie dabei bitte Unterabfragen und
vermeiden Sie Joins (auch keine Join-Bedingungen in WHERE):
In welchen Abteilungen wird das höchste Gehalt gezahlt?
Antwort: 
*/
   
select name as Abteilungsname
from abteilung 
where abt_nr in (
	select abt_nr
	from personal as p
	where geh_stufe = (
		select geh_stufe
		from gehalt
		where betrag = (
			select max(betrag)
			from gehalt as g
		)
	)
);

-- Sind Ihre Unterabfragen korreliert oder unkorrelliert? Bitte begründen Sie Ihre Antwort.
-- Antwort: Unkorreliert, da innerhalb keiner Subquerie auf eine der Aeusseren per Punktnotation 
-- zugegriffen wird.


/* Wie würde die Abfrage
” In welchen Abteilungen wird das höchste Gehalt ge-
zahlt?“ aus d) mit Joins aussehen? */

select *
from gehalt as x
-- join gehalt as y on x.geh_stufe = y.geh_stufe
join personal as p on x.geh_stufe = p.geh_stufe
join abteilung as a on p.abt_nr = a.abt_nr
where x.betrag = max(x.betrag);

