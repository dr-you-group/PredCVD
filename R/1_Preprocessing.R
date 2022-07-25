library(dplyr)
library(tidyverse)
library(readxl)

'%!in%' <- Negate('%in%')

#### sev #### 
sev <- read.csv("./data/sev_cacs_final_unpseudo.csv")

#### MI ####
outcomeMI <- read_xlsx("./data/outcome_MI.xlsx")
historyMI <- read_xlsx("./data/history_MI.xlsx")

outcomeMI <- outcomeMI %>%
  filter(.data$`(실명)등록번호` %!in% historyMI$`(실명)등록번호` ) %>%
  distinct(`(실명)등록번호`) %>%
  rename(new_unit = `(실명)등록번호`)

historyMI <- historyMI %>%
  select(`(실명)등록번호`) %>%
  rename(new_unit = `(실명)등록번호`) %>%
  distinct(new_unit)

#### stroke #### 

outcomeStroke <- read_xlsx("./data/outcome_stroke.xlsx")

historyStroke <- sev %>%
  filter(CVD == 1) %>%
  select(new_unit)

outcomeStroke <- outcomeStroke %>%
  filter(.data$`(실명)등록번호` %!in% historyStroke$new_unit) %>%
  distinct(`(실명)등록번호`) %>%
  rename(new_unit = `(실명)등록번호`)

#### Cardiovascular death ####

death <- read.csv("./data/causeOfDeath.csv")

cvdDeath <- death %>%
  filter(substr(causeOfDeath,1,1) == "I") %>%
  distinct(new_unit)

#### Remove PCI, CABG, MI, CVD, CAD patients diagnosed before baseline CT date ####
sev <- sev %>%
  filter(.data$new_unit %!in% historyMI$new_unit) %>%
  filter(CVD == 0) %>%
  filter(CAD == 0) %>%
  filter(PCI == 0) %>%
  filter(CABG == 0) %>%
  filter(HF == 0) %>%
  filter(AF == 0) %>%
  filter(!is.na(Stage))
# patients : 3293 -> 2640

sev <- sev %>%
  mutate(outcomeCVD = ifelse(.data$new_unit %in% outcomeMI$new_unit | .data$new_unit %in% outcomeStroke$new_unit | .data$new_unit %in% cvdDeath$new_unit, 1, 0))

# outcomeCVD : 79

myvar <- colnames(sev)[c(5:6,8,10:12,14,20:32,46,49)]