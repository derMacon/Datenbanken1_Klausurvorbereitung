-- 2.1
-- Gebe alle Studenten die ein 'A' am Anfang und kein 'k' im Namen haben.
SELECT p.VNAME AS Vorname, p.NNAME AS Nachname
FROM fh_abbild.person P
       JOIN fh_abbild.student s ON p.PIN = s.PIN
WHERE VNAME LIKE 'a%'
  AND VNAME NOT LIKE '%k%'
  AND NNAME LIKE 'a%'
  AND NNAME NOT LIKE '%k%'

-- 2.2
-- Finden Sie alle Postleitzahlen die es im Ort Hamburg gibt.
SELECT DISTINCT A.PLZ AS Postleitzahl
FROM fh_abbild.adresse A
WHERE ORT = 'Hamburg'

-- 2.3
-- Geben Sie an wie viele Mitarbeiter einen Professortitel tragen.
SELECT COUNT(*) AS Anzahl
FROM fh_abbild.person P
       JOIN fh_abbild.mitarbeiter M ON P.PIN = M.PIN
WHERE M.TITEL LIKE '%Prof%'

-- 2.4
-- Berechne das größte und kleinste ausgezahlte Bafoeg aller Studenten.
SELECT MIN(BAFOEG), MAX(BAFOEG)
FROM fh_abbild.student
WHERE BAFOEG IS NOT NULL

-- 3.1
-- Gebt bitte die Pin, den Vornamen, den Nachnamen und die Anzahl der Veranstaltungen aus, die die Assistenten betreuen. Die Ausgabe soll absteigend nach der Anzahl sortiert sein.
SELECT p.PIN AS Pin, p.VNAME AS Vorname, p.NNAME AS Nachname, COUNT(*) AS anzahl
FROM fh_abbild.person P
       JOIN fh_abbild.assistent a ON p.PIN = a.PIN
       JOIN fh_abbild.betreut b ON a.PIN = b.PIN
GROUP BY a.PIN
ORDER BY anzahl DESC 

-- 3.2
-- Gebt die Krankenkassen mit den meisten versicherten Personen aus.
SELECT count(p.KRANKENKASSE_ID) AS Anzahl, kk.KK_NAME AS Krankenkasse
FROM fh_abbild.person P
       JOIN fh_abbild.krankenkasse kk ON p.KRANKENKASSE_ID = kk.KRANKENKASSE_ID
       -- WHERE kk.KK_NAME NOT LIKE '* privat%'
GROUP BY p.KRANKENKASSE_ID
ORDER BY anz DESC

-- 3.3
-- Es gibt Gebäude in denen anscheinend mehrere Studenten der FH Wedel
-- wohnen (identische Straße, PLZ und Ort). Welche Gebäude sind das und
-- wieviele Studenten wohnen dort jeweils?
SELECT adr.PLZ, adr.ORT, adr.STRASSE, COUNT(*) AS anz
FROM adresse adr
       INNER JOIN adresse adr2
WHERE adr.PLZ = adr2.PLZ
  AND adr.STRASSE = adr2.STRASSE
  AND adr.ORT = adr2.ORT
GROUP BY adr.STRASSE
HAVING anz > 1
ORDER BY anz DESC

-- 3.4
-- Geben Sie alle Mitarbeiter die Sonstiger Mitarbeiter oder Assistenten sind, mit deren Pin, Geschlecht, Namen und den jeweiligen Aufgaben.
SELECT p.PIN AS Pin, p.GESCHLECHT AS Geschlecht, p.VNAME AS Vorname, p.NNAME AS Nachname
FROM fh_abbild.person P
       JOIN fh_abbild.assistent ass
       JOIN fh_abbild.sonst_mit sm
WHERE ass.PIN = p.PIN
   OR sm.PIN = p.PIN
GROUP BY p.PIN
ORDER BY p.PIN DESC

-- 3.5
-- Finden Sie alle Veranstaltungen, die an mindestens drei verschiedenen Wochentagen
-- gehalten werden. Geben Sie die Anzahl der verschiedenen Tage aus und filtern
-- Sie alle Veranstaltungen heraus, die an zu wenigen Tagen stattfinden.
SELECT V.VERANSTALTUNG_BEZ as Bezeichnung, COUNT(DISTINCT TERMIN.TAG) as Anzahl
FROM fh_abbild.veranstaltung V
       JOIN fh_abbild.veranst_termin T on V.VERANSTALTUNG_ID = T.VERANSTALTUNG_ID
       JOIN fh_abbild.termin TERMIN on T.TERMIN_ID = TERMIN.TERMIN_ID
GROUP BY Bezeichnung
HAVING COUNT(DISTINCT TERMIN.TAG) > 3

-- 3.6
-- Geben Sie alle bestandenen Leistungen (teilgenommen und Note kleiner 5) von
-- Studenten aus, deren Vorname den Namen "Alex" enthält.
SELECT pruefung.STUDIENLEISTUNG_ID
FROM fh_abbild.pruefung AS Pruefung
       JOIN fh_abbild.person Person ON pruefung.PIN = person.PIN
WHERE pruefung.NOTE < 5
  AND person.VNAME LIKE '%Alex%'
  AND pruefung.TEILNAHME = 'J'
ORDER BY person.PIN ASC

-- 3.7
-- Welche Veranstaltungen werden bzw. wurden von mehreren Dozenten gelesen?
-- Die Ausgabe soll mindestens die Veranstaltungsbezeichnung und die Anzahl der lesenden
-- Dozenten beinhalten.
SELECT l.VERANSTALTUNG_ID        AS Veranstaltung,
       ver.VERANSTALTUNG_BEZ     AS Veranstaltungsbezeichnung,
       COUNT(l.VERANSTALTUNG_ID) AS Anzahl
FROM fh_abbild.liest AS l
       JOIN fh_abbild.veranstaltung ver ON l.VERANSTALTUNG_ID = ver.VERANSTALTUNG_ID
GROUP BY l.VERANSTALTUNG_ID
HAVING anz > 1
ORDER BY anz DESC

-- 3.8
-- Gebt bitte die Wochentage mit der Anzahl der jeweils stattfindenden Veranstaltungstermine aus.
-- Die Ausgabe soll absteigend nach der Anzahl sortiert sein.
-- Hinweis: Räume können mehrfach belegt sein. Berücksichtigt daher bitte jede Kombination aus Raum und Zeitslot nur einfach. 
SELECT tag.WOCHENTAG AS Wochentag, COUNT(verTermin.VERANSTALTUNG_ID) AS AnzahlVeranstaltungen
FROM fh_abbild.tag AS tag
       JOIN fh_abbild.termin termin ON tag.TAG = termin.TAG
       JOIN fh_abbild.veranst_termin verTermin ON termin.TERMIN_ID = verTermin.TERMIN_ID
GROUP BY tag.TAG
ORDER BY AnzahlVeranstaltungen DESC

-- 4.1
-- Gebt bitte das Durschnittsalter (Berechnung auf Jahreszahlen reicht. Es muss kein Tagesaktuelles Jahr sein) aller Studenten aus.
-- Tipp: Schaut euch die MySQL-Funktionen YEAR und CURDATE an.
SELECT AVG(YEAR(CURDATE()) - YEAR(person.GEBDAT)) AS Durchschnittsalter
FROM fh_abbild.person AS person
       INNER JOIN fh_abbild.student student ON person.PIN = student.PIN

-- 4.2
-- Finden Sie alle Räume, die mehr als 30% Auslastung innerhalb einer Woche haben
-- (gemessen an der Belegungen von Zeitslots). Die Ausgabe soll die Raumbezeichnung
-- und die Auslastung in Prozent beinhalten.
-- Hinweis: Räume können zu einem Zeitpunkt mehrfach belegt sein, was bei Nichtberücksichtigung
-- zu Auslastungen > 100% führen kann. Berücksichtigen Sie jeden Zeitpunkt daher nur einmalig.
SELECT R.RAUM_BEZ AS Name,
       (Round(count(R.RAUM_ID) / (SELECT COUNT(*) AS Gesamt FROM fh_abbild.termin) * 100, 2)) AS Prozentual
FROM (SELECT * FROM veranst_termin GROUP BY TERMIN_ID, RAUM_ID) AS v
       JOIN fh_abbild.raum R ON R.RAUM_ID = v.RAUM_ID
GROUP BY R.RAUM_ID
HAVING count(R.RAUM_ID) / (SELECT COUNT(*) AS Gesamt FROM fh_abbild.termin) * 100 > 30

-- 4.3
-- Was ist das höchst mögliche Gehalt, was ist das höchst gezahlte Gehalt,
-- Was ist das geringste Gehalt, was ist das geringste ausgezahlte Gehalt.
SELECT MAX(gs.GEHALT) AS hoechstesGehalt,
       MIN(gs.GEHALT) AS geringstesGehalt,
       gs2.GEHALT     AS hoechstesGezahltesGehalt,
       gs3.GEHALT     AS geringstesGezahltesGehalt
FROM fh_abbild.gehaltsstufe AS gs
       JOIN fh_abbild.gehaltsstufe gs2
       JOIN fh_abbild.gehaltsstufe gs3
WHERE gs2.GEHALTSSTUFE_ID = (SELECT MAX(m.GEHALTSSTUFE_ID) FROM fh_abbild.mitarbeiter AS m)
  AND gs3.GEHALTSSTUFE_ID = (SELECT MIN(m2.GEHALTSSTUFE_ID) FROM fh_abbild.mitarbeiter AS m2)
  
-- 4.4
-- Wie viele Studenten bekommen mehr BAföG als das durchschnittliche BAföG?
-- Das durchschnittliche BAföG ergibt sich dabei aus den Beträgen, die an 
-- Studenten und Schüler der FH bzw. PTL Wedel gezahlt werden.
SELECT COUNT(BAFOEG) AS "Anzahl Studenten, die mehr als das Durchschnittsbafoeg bekommen"
FROM fh_abbild.student
WHERE BAFOEG > (SELECT AVG(BAFOEG) FROM fh_abbild.student)

-- 4.5
-- Für die FH Wedel soll eine Singlebörse eingerichtet werden. Dafür braucht man eine Liste von allen möglichen Paaren. Für Testzwecke werden zuerst alle Paare von Assistenten gebildet.
-- Geben Sie Name und Nachname an, und eine extra Spalte ob diese Kombination Gleichgeschlechtlich ist oder nicht.
SELECT pa.VNAME                        AS Vorname,
       pa.NNAME                        AS Nachname,
       pb.VNAME                        AS Vorname2,
       pb.NNAME                        AS Nachname2,
       (pa.GESCHLECHT = pb.GESCHLECHT) AS Gleichgeschlechtlich
FROM fh_abbild.assistent AS A
       CROSS JOIN fh_abbild.assistent AS B
       JOIN fh_abbild.person Pa ON pa.PIN = A.PIN
       JOIN fh_abbild.person Pb ON pb.PIN = B.PIN
WHERE A.PIN != B.PIN
  AND A.PIN < B.PIN

-- 4.6
-- Geben Sie die folgenden Informationen über Dozenten heraus: 
-- Vorname
-- Nachname
-- Titel, sollte kein Titel eingetragen sein stattdessen der String "keiner"
-- Hinweis: Informieren Sie sich über die MySQL Funktion COALESCE, diese
-- hat oberflächlich betrachtet einen ähnlichen Zweck wie WENN in Excel.
SELECT COALESCE(M.TITEL, "keiner") AS Titel, P.VNAME AS Vorname, P.NNAME AS Nachname
FROM fh_abbild.dozent AS D
       INNER JOIN fh_abbild.mitarbeiter M ON D.PIN = M.PIN
       INNER JOIN fh_abbild.person P ON P.PIN = D.PIN

-- 4.7
-- Nennen sie die Bezeichnung der Fachschaften denen ein Dozent zugeteilt ist, der schon ein Buch veröffentlicht hat.
SELECT DISTINCT F.FACHSCHAFT_BEZ AS Fachschaft
FROM fh_abbild.fachschaft AS F
       INNER JOIN fh_abbild.dozent D ON D.FACHSCHAFT_ID = F.FACHSCHAFT_ID
WHERE (SELECT Count(*) FROM fh_abbild.veroeffentlichung AS V WHERE V.PIN = D.PIN)

-- 4.8
-- Berechnet die Durchschnittsnote des Studenten mit der Pinnummer '3117' auf eine Nachkommastelle gerundet.
SELECT ROUND(AVG(P.NOTE), 1) as "Ø Note"
FROM fh_abbild.pruefung AS P
WHERE P.PIN = '3117'
  AND P.NOTE !='5.0'

-- 4.9
-- Gebt bitte alle Mitarbeiter aus die mehr als 10 unterschiedliche Prüfungen gestellt haben.
SELECT DISTINCT M.PIN as MitarbeiterID
FROM fh_abbild.mitarbeiter M
       INNER JOIN fh_abbild.pruefung P ON M.PIN = P.MIT_PIN
WHERE (
       SELECT COUNT(DISTINCT pk.STUDIENLEISTUNG_ID)
       FROM fh_abbild.pruefung pk
       WHERE pk.MIT_PIN = M.PIN
) > 10

-- 4.10
-- Berechnen sie wie hoch der prozentuale Frauenanteil in den Fachrichtungen Wirtschaftsinformatik und technischer Informatik ist.
SELECT ROUND((WeiblicheStudenten.Anzahl / COUNT(AlleStudenten.PIN) * 100), 2) as "Prozentualer Frauenanteil"
FROM fh_abbild.student AlleStudenten
       JOIN fh_abbild.person P on AlleStudenten.PIN = P.PIN
       JOIN (SELECT COUNT(S.PIN) as Anzahl
             FROM fh_abbild.student as S
                    JOIN fh_abbild.person PS on PS.PIN = S.PIN
                    JOIN fh_abbild.student SS on PS.PIN = SS.PIN
             WHERE PS.GESCHLECHT = 'W'
               AND (SS.FACHRICHTUNG_ID = 23
                      OR SS.FACHRICHTUNG_ID = 9
                      OR SS.FACHRICHTUNG_ID = 19
                      OR SS.FACHRICHTUNG_ID = 4)) as WeiblicheStudenten
WHERE AlleStudenten.FACHRICHTUNG_ID = 23
   OR AlleStudenten.FACHRICHTUNG_ID = 9
   OR AlleStudenten.FACHRICHTUNG_ID = 19
   OR AlleStudenten.FACHRICHTUNG_ID = 4
-- Bestimmen Sie bevor Sie die folgenden drei SQL Statement lösen, wieviele Zeilen rauskommen sollten, und beschreiben Sie mit einem Kommentar wie Sie auf diese Lösung kommen.


-- 4.11
-- Listen Sie alle verschiedenen Länder mit der Anzahl Studierenden, die diesem Land zugeordnet sind, auf.
select L.LAND, count(L.LAND)
from fh_abbild.student S
       JOIN fh_abbild.person P on S.PIN = P.PIN
       JOIN fh_abbild.adresse A on P.PIN = A.PIN
       JOIN fh_abbild.lkz L on A.LKZ = L.LKZ
-- Antwort auf Zusatzfrage: __________

-- 4.12
-- Zählen Sie wieviele Räume es von jeder Raumart gibt. Geben sie Raumart, raumart_bez und die Anzahl an
SELECT r.RAUMART AS 'Raumart', ra.RAUMART_BEZ, count(*) AS 'Anzahl'
FROM raum AS r
       JOIN raumart ra ON r.RAUMART = ra.RAUMART
GROUP BY ra.RAUMART;

-- Antwort auf Zusatzfrage: __________ 


-- 4.13
-- Finden Sie heraus wie viele Bücher jeder Dozenten geschrieben
-- hat. Ordnen Sie ihr Ergebnis zunächst absteigend nach der Anzahl der
-- Bücher und dann aufsteigend nach dem Vornamen des Verfassers.
SELECT P.VNAME as Vorname, P.NNAME as Nachname, COUNT(*) as Anzahl
FROM fh_abbild.veroeffentlichung V
       JOIN fh_abbild.person P on V.PIN = P.PIN
GROUP BY P.PIN
ORDER BY Anzahl DESC, Vorname ASC

-- Antwort auf Zusatzfrage: __________
