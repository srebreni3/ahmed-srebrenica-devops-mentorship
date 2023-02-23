Level 0: The goal of this level is for you to log into the game using SSH. The host to which you need to connect is bandit.labs.overthewire.org, on port 2220. The username is bandit0 and the password is bandit0. Once logged in, go to the Level 1 page to find out how to beat Level 1.

ssh bandit.labs.overthewire.org -l bandit0 -p2220 - #ove komande koristimo kako bi se remote preko ssh-a prikacili na udaljeni server. 

Level 1: The password for the next level is stored in a file called readme located in the home directory. Use this password to log into bandit1 using SSH. Whenever you find a password for a level, use SSH (on port 2220) to log into that level and continue the game.

ll - #ovu komandu koristimo za izlistavanje direktorija i fajlova
cat readme - #cat koristimo kada zelimo da procitamo sadrzaj odredjenog tekstualnog fajla, u ovom slucaju, fajla koji se naziva "readme"

Level 2: The password for the next level is stored in a file called spaces in this filename located in the home directory

ll - #ponovo smo koristili ovu komandu kako bi izlistali direktorije i fajlove

cat ./-  #smo koristili da otvorimo - fajl u kojem se nalazi sifra

Level 3: The password for the next level is stored in a file called spaces in this filename located in the home directory

cat spaces\ in\ this\ filename #cat komandu uz \ smo koristili kako bi otvorili fajl koji je kreiran sa razmacima u imenu 

Level 4: The password for the next level is stored in a hidden file in the inhere directory.

cd inhere/ #cd komandu smo koristili kako bi usli u direktorij inhere/ 

cat .hidden #cat .hidden smo koristili kako bi otvorili .hidden fajl

Level 5: The password for the next level is stored in the only human-readable file in the inhere directory. Tip: if your terminal is messed up, try the “reset” command.

file -- *  #koristimo file -- * komandu kako bi saznali koje sve tipove fajlova imamo u nasem direktoriju

file -m -file07 #pokrecemo file koji ima ASCII text u sebi. - m specificira alternativnu listu datoteka koje sadrze magicne brojeve. 

Level 6: The password for the next level is stored in a file somewhere under the inhere directory and has all of the following properties:

human-readable
1033 bytes in size
not executable

find . -type f -size 1033c  #ovdje "." predstavlja trenutni direktorij, "-type f" ogranicava pretrazivanje na samo regularne datoteke, a "-size 1033c" oznacava da se traze datoteke tacno 1033 bajta velike. 

Level 7: The password for the next level is stored somewhere on the server and has all of the following properties:

owned by user bandit7
owned by group bandit6
33 bytes in size

find / -user bandit7 -group bandit6 #komandom "Find / -user bandit7" smo pretrazivali samo one datoteke koje bandit7 koristi, dok komandom "-group bandit6" smo jos dodali da je on u grupi bandit6. 

cat /var/lib/dpkg/info/bandit7.password #komandom cat smo otvorili fajl sa passwordom

Level 8: The password for the next level is stored in the file data.txt next to the word millionth

grep millionth data.txt #komanda "grep" sluzi za pretrazivanje kljucne rijeci u odredjenom fileu

Level 9: The password for the next level is stored in the file data.txt and is the only line of text that occurs only once

sort data.txt | uniq -u #naredba "sort" sortira redove u datoteci po abecednom redu, a naredba "uniq" filtrira uzastopne duple retke, opcija "-u" prikazuje redove koji se pojavljuju samo jednom u datoteci

Level 10: The password for the next level is stored in the file data.txt in one of the few human-readable strings, preceded by several ‘=’ characters.

strings data.txt | grep ====  #"strings" komanda se koristi za ispisivanje znakova, konkretno iz datoteke "data.txt", te grep da pronadje "====". 



 










