# Description

This Docker image helps you validate your domain with Let's Encrypt, so you can create FREE certificates for your domains.

You need to create domain categories under /domains/ directory. Each category is a file containing your domains and the name of the created certificate will be the same as the name of category.
 
Example:

**/domains/mydomain.tld**

```text
mydomain.tld
sub1.mydomain.tld
sub2.mydomain.tld
```

It will be converted to the following command:

```bash
certbot certonly \
      --expand \
      --email ${LE_EMAIL} \
      --non-interactive \
      --agree-tos \
      --standalone \
      --preferred-challenges http-01 \
      --http-01-port 9080 \
      --cert-name mydomain.tld \
      -d mydomain.tld -d sub1.mydomain.tld -d sub2.mydomain.tld
```

To create categories, you can mount the directory from the host:

```bash
docker run --rm -it -e LE_EMAIL=youremail@domain.tld -v `pwd`/domains:/domains rimelek/letsencrypt-http 
```

If you want to create or renew only certain certificates, you can add the name of them at the end of the command:

```bash
docker run --rm -it -e LE_EMAIL=youremail@domain.tld -v `pwd`/domains:/domains rimelek/letsencrypt-http "mydomain.tld myotherdomain.tld"
```

Make sure the name of the categories are enclosed in quotes!

You can schedule this command with CRON to automate the process of renewing certificates.