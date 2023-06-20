- [x] U tasku 9 je zadatak napraviti .html file koji ce prikazivati Vaše ime i prezime, kratki Vaš opis, te DevOps image koji koristimo od početka programa. HTML file uredite kako god želite (text, colors, fonts, etc.), nije bitno, ali da je preglednost u najmanju ruku okey.

![index.html](screenshots/html-error-image.png)

- [x] Potrebno je kreirati S3 bucket u formatu: ime-prezime-devops-mentorship-program-week-11, te omogućiti static website: Dodati .html i error.html file, Podesiti bucket na public access, te dodati bucket policy koji će omogućiti samo minimalne access permissions nad bucketom.

![files-inside-bucket](screenshots/files-inside-bucket.png)

- [x] Drugi dio zadatka jeste objaviti tu statičku web stranicu kroz CloudFront distribuciju. Prilikom kreiranja CloudFront distribucije potrebno je samo sljedeće opcije modifikovati:

- [x] Origin domain,
- [x] Name,
- [x] Viewer protocol policy (Redirect HTTP to HTTPS),
- [x] Custom SSL certificate,

Nakon podesavanja ovih opcija, potrebno je kreirati kroz ACM certifikat tako sto cemo ici na 
`request certificate` i ukucat cemo ime domene `www.ahmed-srebrenica.awsbosnia.com`

Nakon kreiranja certifikata u ACM-u, u nasem terminalu potrebno je uraditi aktivaciju certifikata
```bash 
aws route53 change-resource-record-sets --hosted-zone-id Z3LHP8UIUC8CDK --change-batch '{"Changes":[{"Action":"CREATE","ResourceRecordSet":{"Name":"CNAME -NAME","Typ
e":"CNAME","TTL":60,"ResourceRecords":[{"Value":"CNAME-VALUE"}]}}]}'
```
![route53](screenshots/R53-load-distribution-command.png)

Certifikat bi trebao da bude `issued` nakon odredjenog vremena (nekoliko minuta)

![acm-console](screenshots/acm-console.png)

Sve sto je preostalo jeste da kroz nas terminal, konfigurisemo `route53` koristeci value iz ACM-a.

```bash
`aws route53 change-resource-record-sets --hosted-zone-id Z3LHP8UIUC8CDK --change-batch '{"Changes":[{"Action":"CREATE","ResourceRecordSet":{"Name":"www.ahmed-srebrenica.awsbosnia.com","Type":"CNAME","TTL":60,"ResourceRecords":[{"Value":"_d9beb7f6c60488ed355eda64d8132bb3.tctzzymbbs.acm-validations.aws."}]}}]}'` 
```

![acm-value-terminal](screenshots/acm-value-terminal.png)

Nakon odredjenog vremena, nas site bi trebao da je dostupan u browseru u kojem ce se vidjeti organizacija `amazon̨` koja nam je izdala SSL certifikat. 

![webpage-with-cert](screenshots/webpage-with-cert.png)

S3 website endpoint: `http://ahmed-srebrenica-devops-mentorship-program-week-11.s3-website-us-east-1.amazonaws.com/`
Primjer distribution endpointa: `https://d3ixra1auy1k81.cloudfront.net`
Primjer R53 recorda: `www.ahmed-srebrenica.awsbosnia.com`




