
# Temporal variation in transmission during the COVID-19 outbreak

*This analysis is archived - see `EpiNow` for ongoing tooling development and `CovidGlobalNow` for results.*

**Aim:** To identify changes in the reproduction number, rate of spread, and doubling time during the course of the COVID-19 outbreak whilst accounting for potential biases due to delays in case reporting.

## Usage

### Set up

Set your working directory to the home directory of this project (or use the provided Rstudio project). Install the analysis and all dependencies with: 

```r
remotes::install_github("epiforecasts/TimeVaryingNCovR0", dependencies = TRUE)
```

### Update all regional nowcasts and report

All regional nowcasts and the report can be updated by running the following from the package root directory:

```bash
Rscript inst/scripts/update_nowcasts.R
```

### Update individual nowcasts

Individual nowcasts can be updated (and their assumptions inspected) in the `inst/scripts` folder. Nowcasts are labelled as `region_nowcast.R`. Results from each nowcast are stored in `inst/results/region/nowcast_date`. It is assumed that the user is in the project root for all analysis.

### Inspect results

Use `vignettes/global-report.Rmd` to inspect the results of the analysis interactively. See `vignettes/global-report.md` for a markdown version of the analysis containing all results. See `vignettes/rendered_output` for version of the analysis rendered in other formats.

## Docker

This analysis was developed in a docker container based on the `rocker/geospatial` docker image. 

To build the docker image run (from the `TimeVaryingNCovR0` directory):

```bash
docker build . -t time_vary
```

To run the docker image run:

```bash
docker run -d -p 8787:8787 --name time_vary -e USER=time_vary -e PASSWORD=time_vary time_vary
```

The rstudio client can be found on port :8787 at your local machines ip. The default username:password is time_vary:time_vary, set the user with -e USER=username, and the password with - e PASSWORD=newpasswordhere. The default is to save the analysis files into the user directory.

To mount a folder (from your current working directory - here assumed to be `tmp`) in the docker container to your local system use the following in the above docker run command (as given mounts the whole `time_vary` directory to `tmp`).

```{bash, eval = FALSE}
--mount type=bind,source=$(pwd)/tmp,target=/home/time_vary
```

To access the command line run the following:

```{bash, eval = FALSE}
docker exec -ti wuhansvst bash
```
