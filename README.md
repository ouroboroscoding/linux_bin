# Linux Bin

Simple scripts to increase efficiency in daily tasks during development. Not
anything you should run in a production environment.

## Scripts
- [dig_all](#dig_all)
- [fix_gif](#fix_gif)
- [git_pull](#git_pull)
- [inotify_consumers](#inotify_consumers)
- [ping_until](#ping_until)
- [pip_clear](#pip_clear)
- [recurse_chmod](#recurse_chmod)
- [rename_mysql_db](#rename_mysql_db)
- [rotate.sh](#rotate.sh)

### dig_all
Passed a domain, it loops through the following list to find records.

```
A, AAAA, AFSDB, APL, CAA, CDNSKEY, CDS, CERT, CNAME, CSYNC, DHCID, DLV, DNAME, DNSKEY, DS, EUI48, EUI64, HINFO, HIP, HTTPS, IPSECKEY, KEY, KX, LOC, MX, NAPTR, NS, NSEC, NSEC3, NSEC3PARAM, OPENPGPKEY, PTR, RRSIG, RP, SIG, SMIMEA, SOA, SRV, SSHFP, SVCB, TA, TKEY, TLSA, TSIG, TXT, URI, ZONEMD
```

For example, if you were to dig `google.com`
```console
foo@bar:~$ dig_all google.com
Searching for all DNS records in google.com
google.com.		300 IN A 142.250.69.78
google.com.		300 IN AAAA 2607:f8b0:4020:801::200e
google.com.		21600 IN CAA 0 issue "pki.goog"
google.com.		6708 IN	HTTPS 1 . alpn="h2,h3"
google.com.		39 IN MX 10 smtp.google.com.
google.com.		18561 IN NS ns3.google.com.
google.com.		18561 IN NS ns1.google.com.
google.com.		18561 IN NS ns4.google.com.
google.com.		18561 IN NS ns2.google.com.
google.com.		28 IN SOA ns1.google.com. dns-admin.google.com. (
				737128753  ; serial
				900        ; refresh (15 minutes)
				900        ; retry (15 minutes)
				1800       ; expire (30 minutes)
				60         ; minimum (1 minute)
				)
google.com.		3600 IN	TXT "google-site-verification=4ibFUgB-wXLQ_S7vsXVomSTVamuOXBiVAzpR5IZ87D0"
google.com.		3600 IN	TXT "facebook-domain-verification=22rm551cu4k0ab0bxsw536tlds4h95"
google.com.		3600 IN	TXT "docusign=05958488-4752-4ef2-95eb-aa7ba8a3bd0e"
google.com.		3600 IN	TXT "apple-domain-verification=30afIBcvSuDV2PLX"
google.com.		3600 IN	TXT "cisco-ci-domain-verification=479146de172eb01ddee38b1a455ab9e8bb51542ddd7f1fa298557dfa7b22d963"
google.com.		3600 IN	TXT "google-site-verification=TV9-DBe4R80X4v0M4U_bd_J9cpOJM0nikft0jAgjmsQ"
google.com.		3600 IN	TXT "MS=E4A68B9AB2BB9670BCE15412F62916164C0B20BB"
google.com.		3600 IN	TXT "docusign=1b0a6754-49b1-4db5-8540-d2c12664b289"
google.com.		3600 IN	TXT "google-site-verification=wD8N7i1JTNTkezJ49swvWW48f8_9xveREV4oB-0Hf5o"
google.com.		3600 IN	TXT "onetrust-domain-verification=de01ed21f2fa4d8781cbc3ffb89cf4ef"
google.com.		3600 IN	TXT "v=spf1 include:_spf.google.com ~all"
google.com.		3600 IN	TXT "globalsign-smime-dv=CDYX+XFHUw2wml6/Gb8+59BsH31KzUr6c1l2BPvqKX8="
Done
foo@bar:~$
```

### fix_gif
A bash script used as a simple fix for gifs with issues. Not a great solution,
especially as it increases file size by running --coalesce

Requires `imagemagick`

```console
foo@bar:~$ fix_gif some_file.gif
```

### git_pull
A bash script used to pull from origin and update all submodules

```console
foo@bar:~$ cd some_git_repo
foo@bar:~/some_git_repo$ git_pull
```

### inotify_consumers
A bash script, a direct copy of Carl-Erik Kopseng's inotify-customers

@latest https://github.com/fatso83/dotfiles/blob/master/utils/scripts/inotify-consumers

```console
foo@bar:~$ inotify_consumers
```

### ping_until
A bash script that calls ping on a domain over and over again until it returns
something. Helpful for knowing when a server is up, or for dns propagation.

```console
foo@bar:~$ ping_until mydomain.com
```

### pip_clear
Removes all modules installed to the current python environment. Not recommended
unless you're working in a vm, venv, or some other sandboxed system.

Calls ```pip freeze | xargs pip uninstall -y```

```console
foo@bar:~$ pip_clear
```

### recurse_chmod
A python3 script that will recursively change the mode bits on files and
directories starting from the current working directory.

| Argument | Default | Description |
| -------- | ------- | ----------- |
| --filemode | 664 | The mode, or bits, used to set any file found. |
| --dirmode | 775 | The mode, or bits, used to set any directory found. |
| --verbose,-v | false | If set, every single `chmod` is shown. |

I found this super helpful when dealing with files, especially large software
projects, with windows style permissions set that I wanted to reset to common
unix permissions.

It could also just be used to reset permissions solely for the owner and group
members, or whatever combination works for you.

```console
foo@bar:~$ cd some_path/with_bad/bits
foo@bar:~/some_path/with_bad/bits$ recurse_chmod --filemode=660 --dirmode=770
```

The following would also be valid
```console
foo@bar:~$ recurse_chmod --filemode=0660 --dirmode=0770
```

### rename_mysql_db
A bash script that will rename a MySQL schema (uses mysqldump tp dump and then
re-add the DB)

| Argument | Optional | Description |
| -------- | -------- | ----------- |
| -u | yes | The user to run the commands under. Should have admin privileges. |
| -p | yes | The user's password. |
| -o | yes | The current name of the database. |
| -n | yes | The name to rename the database to. |

```console
foo@bar:~$ rename_mysql_db -u root -o phoenix
Please enter the password for the MariaDB/MySQL server:
Please enter the new name of the db: phoenix2
Done
foo@bar:~$
```

### rotate.sh
A bash script to rotate a video 90 degrees counter-clockwise. Useful for turning
portrait videos into landscape and vice-versa.

Requires ```ffmpeg```

```console
foo@bar:~$ rotate.sh portrait.mp3 landscape.mp3
```