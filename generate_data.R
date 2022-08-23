library(semcloud)
library(tidyverse)
library(here)
library(cli)

lemmas <- dir(here("tokens"))

res <- map(setNames(lemmas, lemmas), function(lemma) {
  qlvl_dir <- file.path("../../qlvl/NephoVis/tokenclouds/data/", lemma)
  models <- read_tsv(sprintf("%s/%s.medoids.tsv", qlvl_dir, lemma), show_col_types = FALSE)$medoid
  
  map(setNames(models, models), summarizeHDBSCAN, lemma = lemma,
      input_dir = here("tokens", lemma),
      output_dir = qlvl_dir,
      coords_name = ".tsne.30")
})

write_rds(res, here("data.rds"))
