library(mgcv)
library(magrittr)
library(here)

data <- tibble::tibble(Age = 0:110, Deaths = MortalityLaws::ahmd$Dx$`2010`, Exposure = MortalityLaws::ahmd$Ex$`2010`)

gam(
  Deaths ~ s(Age) + offset(log(Exposure)),
  family = poisson(link = "log"),
  data = data
) %>%
  saveRDS(here("models/mgcv.rds"))


# Plot mgcv splines
mgcv_cluster <- readRDS(here("models/mgcv_cluster_R4_1_1.rds"))
mgcv_ubuntu <- readRDS(here("models/mgcv_ubuntu_R4_1_1.rds"))

mgcv_cluster %>% plot(main = "Cluster on Ubuntu (mgcv)")
mgcv_ubuntu %>% plot(main = "Ubuntu on Ubuntu (mgcv)")
