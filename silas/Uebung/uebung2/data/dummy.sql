-- 2.1
-- Gebe alle Studenten die ein 'A' am Anfang und kein 'k' im Namen haben.

-- 2.2
-- Finden Sie alle Postleitzahlen die es im Ort Hamburg gibt.

-- 2.3
-- Geben Sie an wie viele Mitarbeiter einen Professortitel tragen.


-- 2.4
-- Berechne das größte und kleinste ausgezahlte Bafoeg aller Studenten.

-- 3.1
-- Gebt bitte die Pin, den Vornamen, den Nachnamen und die Anzahl der Veranstaltungen aus, die die Assistenten betreuen. Die Ausgabe soll absteigend nach der Anzahl sortiert sein.

-- 3.2
-- Gebt die Krankenkassen mit den meisten versicherten Personen aus.

-- 3.3
-- Es gibt Gebäude in denen anscheinend mehrere Studenten der FH Wedel
-- wohnen (identische Straße, PLZ und Ort). Welche Gebäude sind das und
-- wieviele Studenten wohnen dort jeweils?


-- 3.4
-- Geben Sie alle Mitarbeiter die Sonstiger Mitarbeiter oder Assistenten sind, mit deren Pin, Geschlecht, Namen und den jeweiligen Aufgaben.


-- 3.5
-- Finden Sie alle Veranstaltungen, die an mindestens drei verschiedenen Wochentagen
-- gehalten werden. Geben Sie die Anzahl der verschiedenen Tage aus und filtern
-- Sie alle Veranstaltungen heraus, die an zu wenigen Tagen stattfinden.


-- 3.6
-- Geben Sie alle bestandenen Leistungen (teilgenommen und Note kleiner 5) von
-- Studenten aus, deren Vorname den Namen "Alex" enthält.

-- 3.7
-- Welche Veranstaltungen werden bzw. wurden von mehreren Dozenten gelesen?
-- Die Ausgabe soll mindestens die Veranstaltungsbezeichnung und die Anzahl der lesenden
-- Dozenten beinhalten.


-- 3.8
-- Gebt bitte die Wochentage mit der Anzahl der jeweils stattfindenden Veranstaltungstermine aus.
-- Die Ausgabe soll absteigend nach der Anzahl sortiert sein.
-- Hinweis: Räume können mehrfach belegt sein. Berücksichtigt daher bitte jede Kombination aus Raum und Zeitslot nur einfach. 


-- 4.1
-- Gebt bitte das Durschnittsalter (Berechnung auf Jahreszahlen reicht. Es muss kein Tagesaktuelles Jahr sein) aller Studenten aus.
-- Tipp: Schaut euch die MySQL-Funktionen YEAR und CURDATE an.

-- 4.2
-- Finden Sie alle Räume, die mehr als 30% Auslastung innerhalb einer Woche haben
-- (gemessen an der Belegungen von Zeitslots). Die Ausgabe soll die Raumbezeichnung
-- und die Auslastung in Prozent beinhalten.
-- Hinweis: Räume können zu einem Zeitpunkt mehrfach belegt sein, was bei Nichtberücksichtigung
-- zu Auslastungen > 100% führen kann. Berücksichtigen Sie jeden Zeitpunkt daher nur einmalig.


-- 4.3
-- Was ist das höchst mögliche Gehalt, was ist das höchst gezahlte Gehalt,
-- Was ist das geringste Gehalt, was ist das geringste ausgezahlte Gehalt.

-- 4.4
-- Wie viele Studenten bekommen mehr BAföG als das durchschnittliche BAföG?
-- Das durchschnittliche BAföG ergibt sich dabei aus den Beträgen, die an 
-- Studenten und Schüler der FH bzw. PTL Wedel gezahlt werden.

-- 4.5
-- Für die FH Wedel soll eine Singlebörse eingerichtet werden. Dafür braucht man eine Liste von allen möglichen Paaren. Für Testzwecke werden zuerst alle Paare von Assistenten gebildet.
-- Geben Sie Name und Nachname an, und eine extra Spalte ob diese Kombination Gleichgeschlechtlich ist oder nicht.

-- 4.6
-- Geben Sie die folgenden Informationen über Dozenten heraus: 
-- Vorname
-- Nachname
-- Titel, sollte kein Titel eingetragen sein stattdessen der String "keiner"
-- Hinweis: Informieren Sie sich über die MySQL Funktion COALESCE, diese
-- hat oberflächlich betrachtet einen ähnlichen Zweck wie WENN in Excel.


-- 4.7
-- Nennen sie die Bezeichnung der Fachschaften denen ein Dozent zugeteilt ist, der schon ein Buch veröffentlicht hat.

-- 4.8
-- Berechnet die Durchschnittsnote des Studenten mit der Pinnummer '3117' auf eine Nachkommastelle gerundet.

-- 4.9
-- Gebt bitte alle Mitarbeiter aus die mehr als 10 unterschiedliche Prüfungen gestellt haben.


-- 4.10
-- Berechnen sie wie hoch der prozentuale Frauenanteil in den Fachrichtungen Wirtschaftsinformatik und technischer Informatik ist.


-- Bestimmen Sie bevor Sie die folgenden drei SQL Statement lösen, wieviele Zeilen rauskommen sollten, und beschreiben Sie mit einem Kommentar wie Sie auf diese Lösung kommen.


-- 4.11
-- Listen Sie alle verschiedenen Länder mit der Anzahl Studierenden, die diesem Land zugeordnet sind, auf.

-- Antwort auf Zusatzfrage: __________


-- 4.12
-- Zählen Sie wieviele Räume es von jeder Raumart gibt. Geben sie Raumart, raumart_bez und die Anzahl an

-- Antwort auf Zusatzfrage: __________


-- 4.13
-- Finden Sie heraus wie viele Bücher jeder Dozenten geschrieben
-- hat. Ordnen Sie ihr Ergebnis zunächst absteigend nach der Anzahl der
-- Bücher und dann aufsteigend nach dem Vornamen des Verfassers.

-- Antwort auf Zusatzfrage: __________
