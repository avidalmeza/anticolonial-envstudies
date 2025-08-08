library(shiny)
library(shinydashboard)
library(here)
library(tidyverse)
library(janitor)
library(googlesheets4)
library(markdown)
library(DT)

email <- Sys.getenv("email")
id <- Sys.getenv("id")

options(gargle_oauth_cache = ".secrets")
googlesheets4::gs4_auth(cache = ".secrets", email = email)
sheet <- googlesheets4::read_sheet(id)

entries <- sheet %>% janitor::clean_names() %>%
  dplyr::mutate(year = as.numeric(year),
                type = as.factor(type),
                name = stringr::str_to_title(name),
                name = stringr::str_replace_all(name, "Us", "US"), 
                type = stringr::str_to_title(type),
                name = stringr::str_trim(name, side = c("both")),
                author = stringr::str_trim(author, side = c("both")),
                tags = stringr::str_trim(tags, side = c("both"))) %>%
  dplyr::arrange(name)