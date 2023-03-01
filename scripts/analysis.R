library(brms)
library(dplyr)
library(magrittr)
library(glue)
library(here)
library(ggplot2)


# Table of R-squared values
list.files(
  path = here("models"),
  pattern = "^mortality_.*\\.rds"
) %>%
  tibble::as_tibble_col(column_name  = "ModelName") %>%
  rowwise() %>%
  mutate(
    R2 = bayes_R2(readRDS(glue("{here('models')}/{ModelName}")))[[1]],
    ModelName = stringr::str_remove_all(ModelName, pattern = "^mortality_|\\.rds$")
  ) %>%
  mutate(R2 = format(round(R2, 8), nsmall = 8)) %>%
  knitr::kable()


# Plot splines
model_cluster <- readRDS(here("models/mortality_cluster_R4_1_1.rds"))
model_ubuntu <- readRDS(here("models/mortality_ubuntu_R4_1_1.rds"))

plot(conditional_smooths(model_cluster))[[1]] +
  ggtitle("Cluster model on Ubuntu")

ggsave(here::here("plots", "mu_cluster_on_ubuntu.png"), width = 15, height = 12, units = "cm")

plot(conditional_smooths(model_ubuntu))[[1]] +
  ggtitle("Ubuntu model on Ubuntu")

ggsave(here::here("plots", "mu_ubuntu_on_ubuntu.png"), width = 15, height = 12, units = "cm")


# Posterior predictive checks
pp_check(model_cluster, ndraws = 100) +
  ggtitle("Cluster model on Ubuntu")

ggsave(here::here("plots", "pcc_cluster_on_ubuntu.png"), width = 15, height = 12, units = "cm")

pp_check(model_ubuntu, ndraws = 100) +
  ggtitle("Ubuntu model on Ubuntu")

ggsave(here::here("plots", "pcc_ubuntu_on_ubuntu.png"), width = 15, height = 12, units = "cm")
