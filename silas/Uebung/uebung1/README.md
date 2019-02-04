# Datenbanken 1, ueb01 
**Jan-Lucas Tschirner (minf 103058), Silas Hoffmann (inf 103088), Gruppe 48**

## ER-Diagramm (Draw.io)
![ER-Diagramm](https://github.com/derMacon/Datenbanken1Uebung/blob/master/uebung1/bilder/aktuellerStand/db1Ueb01_DrawIO.png)

### ID-Anfaenge der Entities
- Fahrzeuge = 1
- Kunden = 2
- Modelle = 3
- Ausstattung = 4
- Kategeorie = 5

### Befehle
* Es wird ein neues Fahrzeug mit der Fahrzeug-ID "11" sowie der Modell-ID "31" hinzugefuegt.
    * `INSERT INTO Fahrzeug (Fahrzeug-ID, Modell-ID) VALUES (11, 31)`
* Es wird ein Kunde mit der Kunden-ID "21" hinzugefuegt. Dieser Kunde heisst Juergen Drews und er erwartet eine Rueckmeldung, seine Kanal-ID laesst sich mit der Zahl 42 beschreiben.
    * `INSERT INTO Kunden (Kunden-ID, Vorname, Nachname, Rückmeldung, Kanaele-ID) VALUES (21, "Juergen", "Drews", 1, 42)`
* Es wird eine neues Automodell hinzugefuegt. Hierzu wird eine Modell-ID mit der Zahl 3123 angegeben, ausserdem handelt es sich um ein Modell der A-Klasse. Das Modelljahr ist das Jahr 2017 und der Einsatzzeitraum beginnt am 1. Januar 2018 und endet am 1. Januar 2023. Der Name der Modellreihe ist 280.
    * `INSERT INTO Auto-Modell (Modell-ID, Klasse, Modell-Jahr, Einsatzzeitraum-Anfang, Einsatzzeitraum-Ende, Modell-Reihe) VALUES (3123, "A", 2017, '01-01-2018', '01-01-2023', "280")`
* Es wird eine neue Ausstattung hinzugefuegt. Sie besitzt die Ausstattungs-ID 41, sowie den Einsatzzeitraum vom 1. Januar 2018 bis zum 1. Januar 2028. Ausserdem besitzt sie noch die Kategorie-ID "51". 
    * `INSERT INTO Ausstattung (Ausstattungs-ID, Einsatzzeitraum-Anfang, Einsatzzeitraum-Ende, Kategorie-ID) VALUES (41, '01-01-2018', '01-01-2028', 51)`
* Es wird eine neue Kategorie hinzugefuegt, welche die Kategorie-ID "51" besitzt und durch den Kategorie-Bezeichner "Marketing" beschrieben wird.
    * `INSERT INTO Kategorie (Kategeorie-ID, Kategorie-Bezeichner) VALUES (51, "Marketing")`
