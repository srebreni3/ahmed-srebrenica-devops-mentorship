Level 0: The goal of this level is for you to log into the game using SSH. The host to which you need to connect is bandit.labs.overthewire.org, on port 2220. The username is bandit0 and the password is bandit0. Once logged in, go to the Level 1 page to find out how to beat Level 1.!

[0level1](https://user-images.githubusercontent.com/59295000/221196917-42bda4d1-81c9-4a1e-8ada-203730b6060d.png)


![0level2](https://user-images.githubusercontent.com/59295000/221197146-3a223e72-4525-48a9-afba-86d50cfed3cf.png)


ssh bandit.labs.overthewire.org -l bandit0 -p2220 - #ove komande koristimo kako bi se remote preko ssh-a prikacili na udaljeni server. 

Level 1: The password for the next level is stored in a file called readme located in the home directory. Use this password to log into bandit1 using SSH. Whenever you find a password for a level, use SSH (on port 2220) to log into that level and continue the game.

![1level1](https://user-images.githubusercontent.com/59295000/221197195-25adba10-e180-4a20-b16e-400855342d57.png)

![1level2](https://user-images.githubusercontent.com/59295000/221197221-e1895f1e-a9e8-43ba-a65f-ea7b277b5be2.png)


ll - #ovu komandu koristimo za izlistavanje direktorija i fajlova
cat readme - #cat koristimo kada zelimo da procitamo sadrzaj odredjenog tekstualnog fajla, u ovom slucaju, fajla koji se naziva "readme"

Level 2: The password for the next level is stored in a file called spaces in this filename located in the home directory

![2level1](https://user-images.githubusercontent.com/59295000/221197310-b611df03-7f8b-4f56-9a4f-a5f513be6326.png)


ll - #ponovo smo koristili ovu komandu kako bi izlistali direktorije i fajlove

cat ./-  #smo koristili da otvorimo - fajl u kojem se nalazi sifra

Level 3: The password for the next level is stored in a file called spaces in this filename located in the home directory

![3level1](https://user-images.githubusercontent.com/59295000/221197371-f3a83af9-ec67-4aea-be34-c3ff3638de0c.png)

cat spaces\ in\ this\ filename #cat komandu uz \ smo koristili kako bi otvorili fajl koji je kreiran sa razmacima u imenu 

Level 4: The password for the next level is stored in a hidden file in the inhere directory.

![4level1](https://user-images.githubusercontent.com/59295000/221197449-5a948fa9-7023-44b6-a1fb-9f03f080f7b2.png)

cd inhere/ #cd komandu smo koristili kako bi usli u direktorij inhere/ 

cat .hidden #cat .hidden smo koristili kako bi otvorili .hidden fajl

Level 5: The password for the next level is stored in the only human-readable file in the inhere directory. Tip: if your terminal is messed up, try the “reset” command.

![5level1](https://user-images.githubusercontent.com/59295000/221197503-d301bdf1-84fd-478d-9854-10023c9cce36.png)

file -- *  #koristimo file -- * komandu kako bi saznali koje sve tipove fajlova imamo u nasem direktoriju

file -m -file07 #pokrecemo file koji ima ASCII text u sebi. - m specificira alternativnu listu datoteka koje sadrze magicne brojeve. 

Level 6: The password for the next level is stored in a file somewhere under the inhere directory and has all of the following properties:

![6level1](https://user-images.githubusercontent.com/59295000/221197539-d4a980ba-ea25-4072-94d4-b37a365238b2.png)

human-readable
1033 bytes in size
not executable

find . -type f -size 1033c  #ovdje "." predstavlja trenutni direktorij, "-type f" ogranicava pretrazivanje na samo regularne datoteke, a "-size 1033c" oznacava da se traze datoteke tacno 1033 bajta velike. 

Level 7: The password for the next level is stored somewhere on the server and has all of the following properties:

owned by user bandit7
owned by group bandit6
33 bytes in size

![7level1](https://user-images.githubusercontent.com/59295000/221197610-f114e727-cdfc-42c7-9e9b-050a1414e48b.png)

![7level2](https://user-images.githubusercontent.com/59295000/221197669-da887278-d0d4-4067-ae0d-8de930f841b9.png)


find / -user bandit7 -group bandit6 #komandom "Find / -user bandit7" smo pretrazivali samo one datoteke koje bandit7 koristi, dok komandom "-group bandit6" smo jos dodali da je on u grupi bandit6. 

cat /var/lib/dpkg/info/bandit7.password #komandom cat smo otvorili fajl sa passwordom

Level 8: The password for the next level is stored in the file data.txt next to the word millionth

![8level1](https://user-images.githubusercontent.com/59295000/221197694-5373c280-33d6-4989-adae-f2913fe5bd6f.png)

grep millionth data.txt #komanda "grep" sluzi za pretrazivanje kljucne rijeci u odredjenom fileu

Level 9: The password for the next level is stored in the file data.txt and is the only line of text that occurs only once

![9level1](https://user-images.githubusercontent.com/59295000/221197733-1c33eba2-f2a1-42f0-864e-f3e94bd1183c.png)

sort data.txt | uniq -u #naredba "sort" sortira redove u datoteci po abecednom redu, a naredba "uniq" filtrira uzastopne duple retke, opcija "-u" prikazuje redove koji se pojavljuju samo jednom u datoteci

Level 10: The password for the next level is stored in the file data.txt in one of the few human-readable strings, preceded by several ‘=’ characters.

![10level1](https://user-images.githubusercontent.com/59295000/221197780-dabbf547-183f-4a6e-af10-638337d02d3e.png)

strings data.txt | grep ====  #"strings" komanda se koristi za ispisivanje znakova, konkretno iz datoteke "data.txt", te grep da pronadje "====". 

Level 11: The password for the next level is stored in the file data.txt, which contains base64 encoded data

![11level1](https://user-images.githubusercontent.com/59295000/221290780-917653dc-d85f-4073-ba13-1ee5b030bd53.png)

base64 -d data.txt #"base64 -d" koristi se kako bi se uradio decode texta u base64 formatu 







 
