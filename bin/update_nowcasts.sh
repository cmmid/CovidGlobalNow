#!/bin/bash

## Check repo is up to date
git pull

## Reset data cache
Rscript -e "NCoVUtils::reset_cache()"

## Update man
bash bin/copy_europe_man.sh

## Run nowcasts
Rscript utils/update_nowcasts.R

## Update report
Rscript utils/update_report.R

## Push new casts to GitHub
git add --all
git commit -m "Updated nowcasts"
git push
