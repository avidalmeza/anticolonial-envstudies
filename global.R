library(shiny)
library(shinydashboard)
library(googlesheets4)
library(markdown)
library(DT)
library(here)
library(tidyverse)
library(janitor)

email <- Sys.getenv("email")
id <- Sys.getenv("id")

options(gargle_oauth_cache = ".secrets")
gs4_auth(cache = ".secrets", email = email)
sheet <- read_sheet(id)

entries <- sheet |>
  janitor::clean_names() |> 
  mutate(year = as.numeric(year),
         type = as.factor(type),
         type = str_to_sentence(type),
         name = str_trim(name, side = c("both")),
         author = str_trim(author, side = c("both")),
         tags = str_trim(tags, side = c("both"))) |> 
  arrange(name)