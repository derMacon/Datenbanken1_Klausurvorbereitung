-- Gruppe 48, Silas Hoffmann (inf 103088), Jan-Lucas Tschirner (minf 103058)

/* 2 SQL-Statements
Bei ALLEN Aufgaben gilt, dass in der Ausgabe sinnvolle Spaltenbezeichner und
eine sinnvolle Auswahl an Spalten getroffen werden muss. Eine Spalte mit einer
Funktion als Bezeichner ist nicht aussagekräftig!
Soweit keine bestimmten Datenbankspalten explizit gefordert werden, sind im Rah-
men der SELECT-Klausel selbstständig aussagekräftige Spalten zu wählen. */

/* 2.1 FH-Abbild
Gebe alle Studenten die ein ’A’ am Anfang und kein ’k’ im Namen haben. */
# select p.vname as vorname, p.nname as nachname
select *
from person p
inner join student s on s.pin = p.pin
where p.vname like 'A%' and p.vname not like '%k%' and p.nname not like '%k%';

/* 2.2 FH-Abbild
Finden Sie alle Postleitzahlen die es im Ort Hamburg gibt. */
SELECT distinct a.plz as PLZ_HH
FROM adresse a
WHERE a.ort = 'Hamburg';

/* 2.3 FH-Abbild
Geben Sie an wie viele Mitarbeiter einen Professortitel tragen. */
select count(m.titel) as Anzahl_Prof
from mitarbeiter as m
where m.titel like '%Prof.%';

/* 2.4 FH-Abbild
Berechne das größte und kleinste ausgezahlte Bafoeg aller Studenten. */
select min(bafoeg) as kleinstes_bafoeg, max(bafoeg) as groesstes_bafoeg
from student;

-- 3 SQL-Statements

/* 3.1 FH-Abbild
Gebt bitte die Pin, den Vornamen, den Nachnamen und die Anzahl der Veranstaltungen aus,
die die Assistenten betreuen. Die Ausgabe soll absteigend nach der Anzahl sortiert sein. */
select a.pin, p.vname as vorname, p.nname as nachname, count(b.veranstaltung_id) as anzahlDerVeranstaltungen
from assistent as a
inner join betreut as b using (pin)
inner join person as p using (pin)
group by b.pin
order by anzahlDerVeranstaltungen desc;


/* 3.2 FH-Abbild
Gebt die Krankenkassen mit den meisten versicherten Personen aus. */
select max(k.kk_name) as meistgenutzte_Krankenkasse
from krankenkasse k
inner join person p on p.krankenkasse_id = k.krankenkasse_id;


/* 3.3 FH-Abbild
Es gibt Gebäude in denen anscheinend mehrere Studenten der FH Wedel wohnen (identische
Straße, PLZ und Ort). Welche Gebäude sind das und wieviele Studenten wohnen dort jeweils? */
select x.strasse, x.plz as postleitzahl, x.ort, count(distinct x.pin) as anzahl
from adresse as x, adresse as y
where x.adresse_id <> y.adresse_id and x.strasse = y.strasse and x.plz = y.plz and x.ort = y.ort
group by strasse
order by strasse;

/* 3.4 FH-Abbild
Geben Sie alle Mitarbeiter die Sonstiger Mitarbeiter oder Assistenten sind, mit deren Pin,
Geschlecht, Namen und den jeweiligen Aufgaben. */
select p.pin, p.geschlecht, p.vname as vorname, p.nname as nachname
from person as p 
join (
	select pin, aufgabe_id
    from sonst_mit
    union
    select pin, aufgabe_id
    from assistent
) as beideArten on p.pin = beideArten.pin
order by pin desc; 

/* 3.5 FH-Abbild
Finden Sie alle Veranstaltungen, die an mindestens drei verschiedenen Wochentagen gehalten
werden. Geben Sie die Anzahl der verschiedenen Tage aus und filtern Sie alle Veranstaltungen
heraus, die an zu wenigen Tagen stattfinden. */
select v.VERANSTALTUNG_BEZ as Veranstaltung,  count(distinct termin.tag) as Anzahl_Tage
from veranstaltung v
inner join veranst_termin on v.VERANSTALTUNG_ID = veranst_termin.VERANSTALTUNG_ID
inner join termin on veranst_termin.TERMIN_ID = termin.TERMIN_ID
group by v.veranstaltung_bez
having anzahl_tage >= 3
order by anzahl_tage desc;

/* 3.6 FH-Abbild
Geben Sie alle bestandenen Leistungen (teilgenommen und Note kleiner 5) von Studenten aus,
deren Vorname den Namen Alex enthaelt. */
select p.vname as vorname, p.nname as nachname, st.sl_name as studienleistung, pr.note
from student as s
join pruefung as pr on s.pin = pr.pin 
join studienleistung as st on pr.studienleistung_id = st.studienleistung_id
join person as p on s.pin = p.pin
where p.vname like '%Alex%' and pr.note < 5; 

/* 3.7 FH-Abbild
Welche Veranstaltungen werden bzw. wurden von mehreren Dozenten gelesen? Die Ausgabe soll
mindestens die Veranstaltungsbezeichnung und die Anzahl der lesenden Dozenten beinhalten. */
select  v.veranstaltung_bez as veranstaltung, count(v.veranstaltung_id) as profAnzahl
from liest as l
join veranstaltung as v on l.veranstaltung_id = v.veranstaltung_id
group by l.veranstaltung_id
order by profAnzahl desc;

/* 3.8 FH-Abbild
Gebt bitte die Wochentage mit der Anzahl der jeweils stattfindenden Veranstaltungstermine
aus.
Die Ausgabe soll absteigend nach der Anzahl sortiert sein.
Hinweis: Räume können mehrfach belegt sein. Berücksichtigt daher bitte jede Kombination
aus Raum und Zeitslot nur einfach. */
select ta.wochentag, count(t.tag) as veranstaltungsanzahl
from termin as t
join veranst_termin as v using(termin_id)
join tag as ta using(tag)
group by t.tag
order by veranstaltungsanzahl desc;

/* 4 SQL-Statements
4.1 FH-Abbild
Gebt bitte das Durschnittsalter (Berechnung auf Jahreszahlen reicht. Es muss kein Tagesaktu-
elles Jahr sein) aller Studenten aus.
Tipp: Schaut euch die MySQL-Funktionen YEAR und CURDATE an. */
select round(year(curdate()) - avg(year(p.gebdat)), 0) as durchschnittsalter
from person as p 
join student as s on p.pin = s.pin; 

/* 4.2 FH-Abbild
Finden Sie alle Räume, die mehr als 30% Auslastung innerhalb einer Woche haben (gemessen
an der Belegungen von Zeitslots). Die Ausgabe soll die Raumbezeichnung und die Auslastung
in Prozent beinhalten.
Hinweis: Räume können zu einem Zeitpunkt mehrfach belegt sein, was bei Nichtberücksich-
tigung zu Auslastungen > 100% führen kann. Berücksichtigen Sie jeden Zeitpunkt daher nur
einmalig. */
select distinct r.raum_bez as raumbezeichnung, round((count(*) * 100 / (select count(*) from termin)), 0) as prozentualerAnteil
from veranst_termin v
join raum as r on v.raum_id = r.raum_id
group by v.veranstaltung_id
having prozentualerAnteil >= 30;


/* 4.3 FH-Abbild
Was ist das höchst mögliche Gehalt, was ist das höchst gezahlte Gehalt, Was ist das geringste
Gehalt, was ist das geringste ausgezahlte Gehalt. */
select max(g.gehalt) as maxAusgezahltesGehalt, min(g.gehalt) as minAusgezahltesGehalt,
max(ge.gehalt) as maxMoeglichesGehalt, min(ge.gehalt) as minMoeglichesGehalt
from gehaltsstufe as ge, mitarbeiter as m 
join gehaltsstufe as g on m.gehaltsstufe_id = g.gehaltsstufe_id;

/* 4.4 FH-Abbild
Wie viele Studenten bekommen mehr BAföG als das durchschnittliche BAföG? Das durchschnittliche
BAföG ergibt sich dabei aus den Beträgen, die an Studenten und Schüler der FH
bzw. PTL Wedel gezahlt werden. */
select count(pin) as anzahl
from student 
where bafoeg > (
    select avg(bafoeg)
    from student
);

/* 4.5 FH-Abbild
Für die FH Wedel soll eine Singlebörse eingerichtet werden. Dafür braucht man eine Liste von
allen möglichen Paaren. Für Testzwecke werden zuerst alle Paare von Assistenten gebildet.
Geben Sie Name und Nachname an, und eine extra Spalte ob diese Kombination Gleichgeschlechtlich
ist oder nicht. */
select p.vname as P1_Vorname, p.nname as P1_Nachname, pb.vname as P2_Vorname, pb.nname as P2_Nachname,
case when p.geschlecht = pb.geschlecht then 'Gleich' else 'Unterschiedlich' end as Geschlecht_Kombination
from assistent as aa
inner join person as p on p.pin = aa.pin
inner join person as pb on p.pin <> pb.pin;

/* 4.6 FH-Abbild
Geben Sie die folgenden Informationen über Dozenten heraus:
• Vorname
• Nachname
• Titel, sollte kein Titel eingetragen sein stattdessen der String "keiner"
Hinweis: Informieren Sie sich über die MySQL Funktion COALESCE, diese hat oberflächlich
betrachtet einen ähnlichen Zweck wie WENN in Excel. */
select p.vname as Vorname, p.nname as Nachname, coalesce(m.titel, 'Keiner') as Titel
from dozent d
join person p on d.pin = p.pin
join mitarbeiter m on d.pin = m.pin

/* 4.7 FH-Abbild
Nennen sie die Bezeichnung der Fachschaften denen ein Dozent zugeteilt ist, der schon ein Buch
veröffentlicht hat. */
select distinct fachschaft_bez as Bezeichnung
from dozent as d
join fachschaft as f on d.fachschaft_id = f.fachschaft_id
join veroeffentlichung as v on v.pin = d.pin;

/* 4.8 FH-Abbild
Berechnet die Durchschnittsnote des Studenten mit der Pinnummer ’3117’ auf eine Nachkommastelle
gerundet. */
select round(avg(note), 1) as Durschnittsnote
from pruefung
where pin = 3117;

/* 4.9 FH-Abbild
Gebt bitte alle Mitarbeiter aus die mehr als 10 unterschiedliche Prüfungen gestellt haben. */
select p.vname as vorname, p.nname as nachname, count(distinct studienleistung_id) as anzahl
from pruefung as pr
join person as p on pr.mit_pin = p.pin
group by mit_pin
having anzahl > 10
order by anzahl;

/* 4.10 FH-Abbild
Berechnen sie wie hoch der prozentuale Frauenanteil in den Fachrichtungen Wirtschaftsinformatik
und technischer Informatik ist. */
select fr.fr_bez as frachrichtung, round(count(p.frauenPin) * 100 / count(*), 0) as prozentualeFrauenquote
from student as st
left join (
    select pin as frauenPin
    from person
    where geschlecht = 'w'
) as p on st.pin = p.frauenPin
join fachrichtung as fr on st.fachrichtung_id = fr.fachrichtung_id
where fr.fr_bez like 'Technische Informatik%'
union
select fr.fr_bez as frachrichtung, round(count(p.frauenPin) * 100 / count(*), 0) as prozentualeFrauenquote
from student as st
left join (
    select pin as frauenPin
    from person
    where geschlecht = 'w'
) as p on st.pin = p.frauenPin
join fachrichtung as fr on st.fachrichtung_id = fr.fachrichtung_id
where fr.fr_bez like 'Wirtschaftsinformatik%';

/* 4.11 Aufgaben mit Extra
Bestimmen Sie bevor Sie die folgenden drei SQL Statement lösen, wieviele Zeilen rauskommen
sollten, und beschreiben Sie mit einem Kommentar wie Sie auf diese Lösung kommen. */

/* 4.11.1 FH-Abbild
Listen Sie alle verschiedenen Länder mit der Anzahl Studierenden, die diesem Land zugeordnet
sind, auf. */
select l.land, count(s.pin) as anzahl
from lkz as l 
join adresse as a on a.lkz = l.lkz
join student as s on a.pin = s.pin
group by l.land;

/* 4.11.2 FH-Abbild
Zählen Sie wieviele Räume es von jeder Raumart gibt. Geben sie Raumart, raumart_bez und
die Anzahl an */
select r.raumart, a.RAUMART_BEZ, count(r.raumart) as anzahl
from raum as r
join raumart as a on r.raumart = a.raumart
group by raumart
order by anzahl desc;

/* 4.11.3 FH-Abbild
Finden Sie heraus wie viele Bücher jeder Dozenten geschrieben hat. Ordnen Sie ihr Ergebnis
zunächst absteigend nach der Anzahl der Bücher und dann aufsteigend nach dem Vornamen
des Verfassers. */
select count(v.buchtitel) as anzahlDerBuecher, p.vname as vorname, p.nname as nachname
from veroeffentlichung as v 
join dozent as d on d.pin = v.pin
join person as p on p.pin = d.pin
group by p.pin
order by anzahlDerBuecher desc, vorname asc;
