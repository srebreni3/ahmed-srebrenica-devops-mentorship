Zadatak za 12 sedmicu predavanja DevOps Mentorship programa je da kompletirate sljedece lekcije iz kursa AWS Certified Solutions Architect - Associate (SAA-C03) dostupnog na linku:
https://learn.cantrill.io/courses/enrolled/1820301

Serverless and Application Services

- [x] Architecture Deep Dive Part 1
- [x] Architecture Deep Dive Part 2
- [x] AWS Lambda Part 1
- [x] AWS Lambda Part 2
- [x] AWS Lambda Part 3
- [x] CludWatchEvents and Event Bridge
- [x] Automated EC2 Control using lambda and events Part 1 (DEMO)
- [x] Automated EC2 Control using lambda and events Part 2 (DEMO)
- [x] Serverless Architecture
- [x] Simple Notification Service (SNS)
- [x] Step Functions
- [x] API Gateway 101
- [x] Build a serverless app part 1
- [x] Build a serverless app part 2
- [x] Build a serverless app part 3
- [x] Build a serverless app part 4
- [x] Build a serverless app part 5
- [x] Build a serverless app part 6
- [x] Simple Queue Service (SQS)
- [x] SQS Stadanard vs FIFO Queus
- [x] SQS Delay Queues


# 1. Architecture Deep Dive Part 1 

Kao buduce Solution arhitekte, ne mozemo da nesto napravimo a da u potpunosti ne razumijemo arhitekturu. U zavisnosti od od zahtjeva, biramo razlicitu arhitekturu.

**Event-Driven Architecture**

**Monolitic Architecture**

U monolitic arhitekturi treba ocekivati da su generalno sve komponente na istom serveru direktno konektovane i da imaju isti codebase. Ne mozes skalirati jednu bez druge komponente, to znaci da se skaliranje odvija vertikalno. Isto tako, kada je jedna komponente failed, znaci da su i sve ostale failed. Takodjer, treba istaci da su i troskovi isti za sve komponente, jer te iste komponetne su uvijek running i zbog toga uvijek iziskuju troskove, cak iako processing engine ne radi nista. 

![monolitics](screenshots/mololitics.png)

**Tiered Architecture**

`Tiered arcitecture` - tu imamo razlicite tiere, i oni mogu biti na razlicitom ili istom serveru. Tired u odnosu na Monolitic ima odredjene prednosti, moze se skalirati vertikalno ali i horizontalno. Processing dio koristi `Load Balancer` koji radi horizontalno skaliranje, samim tim veca je dostupnost, jer ako jedna instanca padne, druga ce da preuzme. 
Ova arhitektura nije perfekta arhitektura, zbog dvije stvari, jer upload zahtijeva od processinga da postoji i potreban mu je njegov respond, te processing mora nesto running ili ce biti failure. 

![tiered](screenshots/tiered-architecture.png)

# 2. Architecture Deep Dive Part 2

`Queue` je sistem koji `prihvata poruke` koje se dodaju na njega i mogu se primiti ili povuci s njega.
`Queue se nalazi izmedju dva tiera, izmedju UPLOAD i PROCESSING`
U mnogim queue postoji `ordering`, i u mnogim slucajevima poruke se primaju iz queue u `FIFO` (First in, First out architecture), ali treba napomenuti nije uvijek ovakav slucaj. 


U ovom slucaju, arhitektura radi na malo drugaciji nacin:

- Upload ide na S3 Bucket umjesto da ide na Processing tier

- Dodaje se poruka u queue sa detaljima gdje je lokacija, koja je velicina potrebna i sl.

- Upload ne zavisi od Processinga i koristi asinhronizivanu komunikaciju gdje upload tier salje poruku nakon koje moze da ceka u pozadini ili da nastavi raditi ostale stvari dok processing odradi svoj zadatak. 

Sa druge strane Queuea postoji konfigurisana `auto scaling group`. 

`Queue lenght` je broj itemsa u Queue dodani od strane Upload tiera. Auto Scaling grupa detektira to i povecava zeljeni kapacitet instanci sa 0 na `X` i zbog toga instance su opskrbljene Auto Scaling grupom. Te instance pocinju da `pullaju` queue i primaju poruke ispred queue. Te poruke sadrze podatke za posao ali sadrze i lokaciju S3 bucketa i lokaciju objekata u tom S3 bucketu. Kada se poslovi obrade na instancama, brisu se iz queue. Kada je queue lenght kratak, onda auto scaling grupa smanjuje zeljeni kapacitet instanci. 
Nakon sto se svi poslovi preuzmu sa queue i obrade na instancama, onda auto scaling grupa smanji kapacitet instanci na `0`. 

![queues-1](screenshots/queues1.png)

![queues-2](screenshots/queues2.png)

Postavljajuci queue izmedju dva aplikaciona tiera - time se radzvajaju ti tieri. Jedan tier dodaje poslove za queue dok drugi tier cita te poslove. 

Ovim nacinom, koristeci `Queue architecture`, komunikacija se ne odvija direktno. Komponente su razdvojene i skaliraju se samostalno ili neovisno, 
Processing koristi auto skaliranje i `moze da skalira od 0 do infinity instanci`. 

**Mikroservisna arhitektura**

To je skup mikroservisa, a mikroservisi rade individualne stvari veoma dobro kao sto je `upload, process i store and manage`

**Event-Driven Architectures**

prevedi mi ovo: Producers are things which produce events and the inverse of this are consumers - pieces of software which are ready and waiting for events to occur.

Ova arhitektura je kolekcija `event producers` koji mogu biti komponente aplikacije koje izravno ima komunikaciju sa korisnicima.
Isto tako mogu biti dijelovi infrastrukture (EC2), ili mogu biti komponente za monitoring sistema. Isto tako, to su dijelovi softvera koji generiraju ili proizvode evente kao reakciju na nesto, to moze biti kao kada korisnik klikne na submit - to je jedan primjer eventa. Kada bi odredjeni korisnik otvorio odredjenu mobilnu aplikaciju, to bi mogao biti dogadjaj koji bi se generirao i mogao bi se proslijediti drugim dijelovima sistema.
`Producers` su radnje koje proizvode evente, a inversija toga su `consumers` to su dijelovi softvera koji su spremni i cekaju da se eventi dogode.
Kod `producersa`, eventi se generiraju kada se nesto dogodi. To moze da bude kada se ucitavanje uspjesno izvrsi ili ne. Ti producersi produciraju evente. 
`Consumers` ne cekaju pasivno na te evente, vec ih dobivaju kada se pojave i tada poduzimaju akciju de obradjuju event. Poslije same obrade eventa, consumers se zaustavljaju. Na taj nacin se izbjegava nepotrebno trosenje resursa.
Na slici ispod je prikazan `Event-Router` koji stalno prosljedjuje informacije. On je visoko dostupna tacka razmjene izmedju `event producer` i `event consumer`. 
Npr. Kada se eventi generiraju od strane producera, oni se salju putem rutera ka event customer tako sto se dodaju u event bus.

![event-driven-architecture-summary](screenshots/event-driven-architecture-summary.png)

## 3. AWS Lambda - part 1

`Lambda` je funkcija kao servis (`FaaS`) ili brzi produkt. Kratko receno to je dio koda koji Lambda pokrece. To znaci da pruzamo Lambdi specijalni `short-running` i `focused code` a Lambda se brine o tom kodu i naplacuje samo ono sto koristimo. 
Kada se kreira nova Lambda funkciju, mora se odabrati `runtime` koji zelimo koristiti. `Runtime` odredjuje okruzenje koje se koristi za izvrsavanje koda kada se Lambda funkcija pozove. Npr. Ako odaberemo `Python` kao `runtime`, Lambda ce automatski pokrenuti Python kod u odgovarajucem izvrsnom okruzenju. Lambda podrzava razlicite `runtimeove` (Python, Ruby, Java, Go, C#).
`CPU resursi` se dodjeljuju automatski i dinamicki od strane Lambde, ovisno o kolicini memorije koju smo konfigurirali za Lambda funkciju. Kada Lambda funkcija koristi vise memorije, automatski ce se dodijeliti vise CPU resursa kako bi se osiguralo brze izvodjenje odredjene funkcije.

```bash 

VAZNO: ako vidimo ili cujemo pojam Docker, to nije Lambda, jer je Docker antipattern za Lambda funkcije.
DOCKER na ispitu se odnosi na tradicionalnu kontejnirizaciju - koriscenje odredjene Docker slike za pokretanje kontejnera i upotrebu u kontejnerizovanom okruzenju kao sto je ECS.

```

![lambda-key-thing](screenshots/lambda-key-thing.png)

Lambda funkcije mogu se izvrsavati do 900 sekundi ili 15 minuta.

![lambda-part-1](screenshots/lambda-part-1.png)

Upotreba Lambde:

![lambda-common-uses](screenshots/lambda-common-uses.png)


# 4. AWS Lambda - part 2

Lambda ima dva networking moda: `public` - koji je ujedno i default, i `VPC` 

Po defaultu Lambda koristi public networking- to znaci da ima network konekciju `public space AWS servisima` i `public internetu`. Moze da se konektuje na oba, sve dok koristi metode autentifikacije i autorizacije. 

**Public Lambda**

![public-lambda](screenshots/public-lambda.png)

**Private Lambda**

![private-lambda](screenshots/private-lambda.png)

```bash

VAZNO: Lambdu unutar naseg VPC-a moramo da posmatramo kao i sve druge resurse unutar VPC-a!

```

**Security** - `Lambda execution roles` su IAM role koje su pridruzene Lambda funkcijama i kontroliraju permisije koje Lambda funkcija prima. `Lambda resource policy` kontrolira koje usluge i accounti mogu pozvati Lambda funkcije.

![lambda-security](screenshots/lambda-security.png)

Lambda koristi `CloudWatch, CloudWatch Logs i X-Ray` a razlicite aspekte `logging` i `monitoringa`.

![lambda-logging](screenshots/lambda-logging.png)

```bash

EXAM Scenario: Pokusaj uspostavljanja dijagnoze zasto Lambda funkcija ne radi i ne postoji nista u CloudWatch Logsu. ANSWER: Ne postoje required permissions via Execution role

```

# 5. AWS Lambda - part 3

Imamo tri razlicite verzije invoking (pozivanja) Lambda funkcija: `Synchronous invocation`, `Asynchronous invocation`, `Event Source mappings`.

**Synchronous invocation**


`Synchronous invocation` je pozivanje gdje klijent salje zahtjev funkciji i ceka na odgovor dok funkcija ne zavrsi izvodjenje i vrati rezultat. To znaci da ce klijent biti blokiran dok funkcija ne dovrsi svoje izvrsavanje i vrati rezultat.

![syn](screenshots/lambda-invocation-synchrounous.png)

**Asynchronous invocation**

`Asynchronous invocation` je pozivanje gdje klijent salje zahtjev funkciji, ali ne ceka na rezultat. Umjesto toga, funkcija odmah vraca potvrdni odgovor klijentu i nastavlja s izvrsavanjem asinkrono. Klijent moze kasnije provjeriti rezultat poziva funkcije putem drugog mehanizma kao sto je `checking the invocation status`.

![asyn](screenshots/lambda-invocation-async.png)

**Event source mapping**

`Event source mapping` je konfiguracija koja omogucava Lambda funkciji automatsko konzumiranje eventa s odrefjenog izvora dogadjaja. Ono uspostavlja vezu izmedju event source i Lambda funkcije, omogucavajuci funkciji da obradjuje evente kako se desavaju. Event source mapping se cesto koristi prilikom integracije Lambda funkcija s uslugama koje su orijentisane na evente, poput `Amazon S3, Amazon DynamoDB Streams, Amazon Kinesis Data Streams ili Amazon Simple Notification Service (SNS)`. Kreiranjem event source mappinga, definise se vrsta event source i odredjuje koja Lambda funkcija ce biti triggerovana svaki put kad se desi novi dogadjaj.

![event-source-mapping](screenshots/event-source-mapping.png)

**Versions**

![lambda-versions](screenshots/lambda-versions.png)

**Lambda function handler**

U AWS Lambda, "cold start" i "warm start" se odnose na dvije razlicite situacije u kojima se moze pozvati Lambda funkcija.

`Cold Start` se desava kada se Lambda funkcija poziva prvi put ili nakon nekog perioda neaktivnosti. U ovoj situaciji, AWS mora alocirati potrebne racunarske resurse za izvrsavanje funkcije. 

`Warm Start` start se desava kada se Lambda funkcija poziva nakon sto je vec inicijalizovana i jos uvijek je aktivna u okruzenju koje se izvrsava, odnosno koje je aktivno. Prednost warm starta je sto Lambda funkcija moze odmah poceti s izvrsavanjem jer su resursi vec alocirani i inicijalizirani. To smanjuje latenciju i poboljsava vrijeme odziva za naredne pozive.

# 6. CloudWatchEvents and EventBridge

`CloudWatch Events` je servis koja pruza gotovo u real-timeu tok sistemskim eventa koji se javljaju u AWS okruzenju. Omogucava monitoring dogadjaja iz razlicitih AWS servisa, kao sto su EC2 instance, Lambda funkcije, S3 bucketi i sl.. CloudWatch Events omogucava definisanje pravila koja odgovaraju odredjenim event patternima i trigeruje akcije u odgovoru na te evente. Te akcije mogu ukljucivati pozivanje AWS Lambda funkcija, pokretanje ECS taskova, slanje notifikacija putem SNS-a i jos mnogo toga. CloudWatch Events se uglavnom fokusira na evente unutar AWS ekosistema.

EventBridge is a serverless event bus service that allows you to build event-driven architectures and integrate various event sources and targets, both within and outside the AWS ecosystem. It provides a central event bus that acts as a hub for routing events between different services and applications. EventBridge supports both AWS services and third-party SaaS (Software-as-a-Service) applications as event sources and targets. It allows you to define rules to filter and transform events and route them to specific targets. EventBridge supports a wide range of integrations and offers more flexibility in connecting events from different sources and sending them to different targets.

`EventBridge` je serverless servis za event bus koji omogucava izgradnju event-driven arhitekture i integraciju razlicitih izvora i ciljeva dogadjaja, kako unutar, tako i izvan AWS ekosistema. EventBridge podrzava kako AWS usluge, tako i aplikacije trecih strana `SaaS (Software-as-a-Service)`. Omogucava definisanje pravila za filtriranje i transformaciju eventa i rutira ih ka odredjenim ciljevima. EventBridge podrzava sirok spektar integracija i pruza vecu fleksibilnost u povezivanju eventa iz razlicitih izvora i slanju ka razlicitim targetima.

![cloudwatch-eventbridge-key-concept](screenshots/cloudwatch-eventbridge-key-concepts.png)

![eb-cloudwatch](screenshots/eb-cloudwatch.png)

# 7. Automated EC2 Control using Lambda and Events - part 1

![1](screenshots/Automated-EC2-Control-using-Lambda-and-Events-1.png)

![2](screenshots/Automated-EC2-Control-using-Lambda-and-Events-2.png)

![3](screenshots/Automated-EC2-Control-using-Lambda-and-Events-3.png)

![4](screenshots/Automated-EC2-Control-using-Lambda-and-Events-4.png)

![5](screenshots/Automated-EC2-Control-using-Lambda-and-Events-5.png)

![6](screenshots/Automated-EC2-Control-using-Lambda-and-Events-6.png)

![7](screenshots/Automated-EC2-Control-using-Lambda-and-Events-7.png)

![8](screenshots/Automated-EC2-Control-using-Lambda-and-Events-8.png)

![9](screenshots/Automated-EC2-Control-using-Lambda-and-Events-9.png)

![10](screenshots/Automated-EC2-Control-using-Lambda-and-Events-10.png)

![11](screenshots/Automated-EC2-Control-using-Lambda-and-Events-11.png)

![12](screenshots/Automated-EC2-Control-using-Lambda-and-Events-12.png)

![13](screenshots/Automated-EC2-Control-using-Lambda-and-Events-13.png)

![14](screenshots/Automated-EC2-Control-using-Lambda-and-Events-14.png)


# 8. Automated EC2 Control using Lambda and Events - part 2

![1](screenshots/Automated-EC2-Control-using-Lambda-and-Events-PART2-1.png)

![2](screenshots/Automated-EC2-Control-using-Lambda-and-Events-PART2-2.png)

![3](screenshots/Automated-EC2-Control-using-Lambda-and-Events-PART2-3.png)

![4](screenshots/Automated-EC2-Control-using-Lambda-and-Events-PART2-4.png)

![5](screenshots/Automated-EC2-Control-using-Lambda-and-Events-PART2-5.png)

![6](screenshots/Automated-EC2-Control-using-Lambda-and-Events-PART2-6.png)

![7](screenshots/Automated-EC2-Control-using-Lambda-and-Events-PART2-7.png)

![8](screenshots/Automated-EC2-Control-using-Lambda-and-Events-PART2-8.png)

![9](screenshots/Automated-EC2-Control-using-Lambda-and-Events-PART2-9.png)

![10](screenshots/Automated-EC2-Control-using-Lambda-and-Events-PART2-10.png)


# 9. Serverless Architecture

![what-is-serverless](screenshots/what-is-serverless.png)

![serverless-architecture-example](screenshots/serverless-architecture-example.png)

# 10. Simple Notification Service

`SNS` je usluga koja omogucuje jednostavno slanje poruka i obavjestenja putem razlicitih kanala kao sto su `e-mail, SMS, mobilne push notifikacije, HTTP endpointovi i Lambda`. SNS omogucuje komunikaciju izmedju aplikacija, sistema i korisnika putem brzih i skalabilnih metoda.

![sns](screenshots/SNS.png)

![sns-example](screenshots/SNS-example.png)

![sns-2](screenshots/SNS-2.png)

# 11. Step Functions

`Step Functions` olaksava izgradnju, upravljanje i skaliranje kompleksnih poslovnih procesa.

![some-problems-with-lambda](screenshots/some-problems-with-lambda.png)

![state-machines](screenshots/state-machines.png)

![states](screenshots/states.png)

![step-functions](screenshots/step-functions.png)

# 12. API Gateway 101

`API Gateway `je servis koji nam omogucava kreiranje i upravljanje API - to je nacin na koji aplikacije komuniciraju jedna s drugom. 

```bash

NPR. Ako koristimo Netflix aplikaciju na nasem tv-u, koristimo API da komuniciramo sa Netflix backend servisima

```

![api-gateway-101](screenshots/api-gateway-101.png)

![api-gateway-overview](screenshots/api-gateway-overview.png)

![api-gateway-auth](screenshots/api-gateway-authentication.png)

![api-gateway-endpoint-types](screenshots/api-gateway-endpoint-types.png)

![api-gateway-stages](screenshots/api-gateway-stages.png)

![api-gateway-errors](screenshots/api-gateway-errors.png)

![api-gateway-caching](screenshots/api-gateway-caching.png)

**Kolegica Alma je uradila super predavanje na ovu temu: https://www.youtube.com/watch?v=xysv_eSb1tQ**

# 13. Build A Serverless App - Pet-Cuddle-o-Tron - PART1

`Serverless app` koja koristi `Step funtions, Lambda, API Gateway i S3 Static website hosting.` 

![serverless-app-stage-1](screenshots/serverless-app-stage-1.png)

![serverless-app-verified-indentities-1](screenshots/serverless-app-verified-identities-1.png)

![serverless-app-verified-indentities-2](screenshots/serverless-app-verified-identities-2.png)

![serverless-app-verified-indentities-3](screenshots/serverless-app-verified-identities-3.png)

# 14. Build A Serverless App - Pet-Cuddle-o-Tron - PART2

![serverless-app-quick-create-stack](screenshots/serverless-app-quick-create-stack.png)

![serverless-app-create-lambda](screenshots/serverless-app-create-lambda.png)

![serverless-app-deploy-lambda](screenshots/serverless-app-deploy-lambda.png)

![serverless-app-stage-2](screenshots/serverless-app-stage-2.png)

# 15. Build A Serverless App - Pet-Cuddle-o-Tron - PART3

![serverless-app-stage-3-main-component](screenshots/serverless-app-stage-3.png)

![serverless-app-create-stack-part-3](screenshots/serverless-app-create-stack-part3.png)

![serverless-app-state-machine-1](screenshots/serverless-app-state-machine.png)

![serverless-app-state-machine-2](screenshots/serverless-app-json-state-machine.png)

![serverless-app-state-machine-3](screenshots/serverless-app-state-machine-name.png)

![serverless-app-created-state-machine](screenshots/serverless-app-created-state-machine.png)

# 16. Build A Serverless App - Pet-Cuddle-o-Tron - PART4

![serverless-app-stage-4](screenshots/serverless-app-stage-4.png)

![serverless-app-create-lambda-function](screenshots/serverless-app-create-lambda-function.png)

![serverless-app-json-lambda](screenshots/serverless-app-json-lambda.png)

![serverless-app-api-gateway-rest-api](screenshots/serverless-app-api-gateway-rest-api.png)

![serverless-app-create-rest-api](screenshots/serverless-app-create-rest-api.png)

![serverless-app-create-resource](screenshots/serverless-app-create-resource.png)

![serverless-app-configure-resource](screenshots/serverless-app-configure-resource.png)

![serverless-app-create-method](screenshots/serverless-app-create-method.png)

![serverless-app-post-setup](screenshots/serverless-app-post-setup.png)

![serverless-app-deploy-api](screenshots/serverless-app-deploy-api.png)

![serverless-app-deploy-api-2](screenshots/serverless-app-deploy-api-2.png)

# 17. Build A Serverless App - Pet-Cuddle-o-Tron - PART5

![serverless-app-stage-5](screenshots/serverless-app-stage-5.png)

![serverless-app-s3](screenshots/serverless-app-s3.png)

![serverless-app-s3-bucket-policy](screenshots/serverless-app-s3-bucket-policy.png)

![serverless-app-s3-edit-static-website-hosting](screenshots/serverless-app-s3-edit-static-website-hosting.png)

![serverless-app-s3-bucket](screenshots/serverless-app-s3-buckets.png)

![serverless-app-app-endpoint](screenshots/serverless-app-app-endpoint.png)

# 18. Simple Queue Service

![sqs-1](screenshots/sqs-1.png)

![sqs-2](screenshots/sqs-2.png)

![sqs-3](screenshots/sqs-3.png)

![sqs-4](screenshots/sqs-4.png)

# 19. SQS Standard vs FIFO Queues

![standard-vs-tifo](screenshots/sqs-standard-vs-fifo.png)

# 20. SQS Delay Queues

![sqs-delay-queues](screenshots/sqs-delay-queues.png)

