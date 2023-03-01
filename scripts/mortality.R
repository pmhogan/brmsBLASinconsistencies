library(brms)

data <- tibble::tibble(Age = 0:110, Deaths = MortalityLaws::ahmd$Dx$`2010`, Exposure = MortalityLaws::ahmd$Ex$`2010`)

brm(
  Deaths | rate(Exposure) ~ s(Age),
  data = data,
  family = poisson(link = "log"),
  prior = prior(normal(-5, 1), class = Intercept),
  init = 0,
  cores = 4,
  control = list(adapt_delta = 0.9, max_treedepth = 15),
  seed = 221207,
  file = here::here("models", "mortality")
)
