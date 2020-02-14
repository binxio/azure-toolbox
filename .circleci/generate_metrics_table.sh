#!/usr/bin/env sh

# $1 - Input file to read from
# $2 - Output file to append to

cat <<EOF >>$2
### Vulnerability Scanning Report
This image has been scanned using Clair by Core OS. The most recent scan has reported:

| Vulnerability Severity | Amount Detected |
| --- | --- |
| *Defcon1* | $(cat $1 | jq '.vulnerabilities[].severity' | grep Defcon1 | wc -l) |
| *Critical* | $(cat $1 | jq '.vulnerabilities[].severity' | grep Critical | wc -l) |
| *High* | $(cat $1 | jq '.vulnerabilities[].severity' | grep High | wc -l) |
| *Medium* | $(cat $1 | jq '.vulnerabilities[].severity' | grep Medium | wc -l) |
| *Low* | $(cat $1 | jq '.vulnerabilities[].severity' | grep Low | wc -l) |
| *Negligible* | $(cat $1 | jq '.vulnerabilities[].severity' | grep Negligible | wc -l) |
| *Unknown* | $(cat $1 | jq '.vulnerabilities[].severity' | grep Unknown | wc -l) |

EOF
