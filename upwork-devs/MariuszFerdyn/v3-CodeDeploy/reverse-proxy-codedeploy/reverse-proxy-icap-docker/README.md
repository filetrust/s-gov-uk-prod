## Usage:

1. Tweak subfilter.sh to replace URLs in backend response in the following format

```
SUBFILTER=( PATTERN_TO_MATCH1,PATTERN_REPLACE1 PATTERN_TO_MATCH2,PATTERN_REPLACE2 )
```

2. Tweak gwproxy.env 

```
# Allowed requested domains, comma separated
ALLOWED_DOMAINS=gov.uk.glasswall-icap.com,www.gov.uk.glasswall-icap.com,assets.publishing.service.gov.uk.glasswall-icap.com
# ICAP server url
ICAP_URL=icap://20.54.179.61:1344/gw_rebuild
# Root domain, the domain appended to the backend website domain
ROOT_DOMAIN=glasswall-icap.com
```

3. Install [docker](https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script) and [docker-compose](https://docs.docker.com/compose/install/#install-compose-on-linux-systems) : 

4. Clone the repo and change working directory into this project folder 

5. Execute the following `docker-compose up -d`
