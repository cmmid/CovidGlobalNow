#!bin/bash

declare -a countries=("spain"
                      "france"
                      "italy"
                      "austria"
                      "norway"
                      "sweden"
                      "united-kingdom"
                      "switzerland"
                      "united-states"
                      "belgium"
                      "netherlands"
                      "iran"
                      "czechia"
                      "portugal"
                      "qatar")

for country in ${countries[@]}; do
  cp man/region-specific-methods/template/europe.md man/region-specific-methods/$country.md
done

