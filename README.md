# AutoSSL

**AutoSSL** fetches SSL certificates from LetsEncrypt using `dns-01` challenge.

- no external DNS server needed
	- AutoSSL also act as DNS content server
- compatible with acquiring wildcard certificates
	- ACMEv2 ready

## Requirements

- Docker

## Usage

1. Add NS record to your domain to delegate records that affects `dns-01` challenge to AutoSSL agent.
	- Ex. `type=NS` `name=_acme-challenge` `content=[your server]`
2. Edit `domains.txt` and `config` if needed.
3. Just run `./run.sh`
	- `./run.sh` can also handles certificate update.
