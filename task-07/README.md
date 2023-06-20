IAM User 1 ce svoje resurse da kreira unutar eu-central-1 regiona.
IAM User 2 ce svoje resurse da kreira unutar us-east-1 regiona.
IAM User 3 ce svoje resurse da kreira unutar eu-west-1 regiona

Svaki do AWS resursa koje kreirate pored taga Name mora sadrzavati i tagove CreatedBy: Ime Prezime i Email:vas@email.com
NOTE: Ako nije explicitno navedeno AWS Account Owners / IAM User 1 / IAM User 2 / IAM User 3 zadatak se odnosi na sviju.

- [x] AWS Account Owners / IAM User 1 azurirajte permsije za IAM 2 User-a na nacin da cete ga dodati u grupu Administrators
- [x] Kreirajte AMI image od instance ec2-ime-prezime-web-server, AMI image nazovite ami-ime-prezime-web-server
- [x] Kreirajte Application Load Balancer pod nazivom alb-web-servers koji ce da bude povezan sa Target Group tg-web-servers
- [x] Kreirajte Auto Scaling group sa MIN 2 i MAX 4 instance. Tip instance koji cete koristiti unutar ASG je t2.micro ili t3.micro gdje cete koristiti alb-web-servers Load Balancer. AutoScaling group bi trebala da skalira prema gore (scale-up) kad god CPU predje 18% i da skalira prema dole (scale-down) kad god CPU Utilisation padne ispod 18%
- [x] Voditite racuna da security grups koje budete koristili nakon sto zavrsite sa zadatakom dozvoljavaju namanje potrebne otvorene portove.
- [x] Kreirajte free account na draw.io ili lucidchart.com stranicama i napravite dijagram infrastrukture iz ovog onako kako je vi vidite/razumijete.
- [x] Pokusajte simulirati visoku dostupnost vase aplikacije na nacin da terminirate instance.
- [x] Pokusajte simulirati CPU load prateci sljedeci tutorijal

Kada zavrsite zadatak napravite Pull Request u kojem cete minimalno postaviti DNS record vaseg Load Balancera i dijagram infrastrukture koji ste kreirali i postavite link na PR kao komentar na ovaj task.

Kada dobijete approval na pull request neophodo je da terminirate / ocistite resurse koje ste keirali.