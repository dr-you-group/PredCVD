linebreaks <- function(n){HTML(strrep(br(), n))}

body <- dashboardBody(
  tabItems(
    
    ## introducion
    tabItem(
      tabName = "intro",
      h2("Introduction"),
      h4("This application was developed to predict cancer survivor's cardiovascular events using machine learning."),
      linebreaks(1),
      h4("In this project, Cardiovascular Events were defined as : "),
      h4("1. Stroke"),
      h4("2. Myocardial Infarction"),
      h4("3. Cardiovascular Mortality"),
      linebreaks(1),
      h2("FAQs"),
      h4("Principal Investigator : Iksung Cho"),
      h4("Affiliation : Division of Cardiology, Severance Cardiovascular Hospital, Yonsei University College of Medicine"),
      h4("E-mail : iksungcho@yuhs.ac")
      
    ),
    
    ## dashboard
    tabItem(
      tabName = "dashboard",
      fluidRow(
        box(width = 8,
            title = "Set parameters",
            
            column(6, numericInput("sex", "Sex (male=0, female=1)", 0, min = 0, max = 1),
                   numericInput("age", "Age", 18, min = 18, max = 100),
                   numericInput("HTN", "History of HTN (yes=1, no=0)", 0, min = 0, max = 1),
                   numericInput("DM", "History of DM (yes=1, no=0)", 0, min = 0, max = 1),
                   numericInput("CRF", "History of CRF (yes=1, no=0)", 0, min = 0, max = 1),
                   numericInput("Dyslipidemia", "History of Dyslipidemia (yes=1, no=0)", 0, min = 0, max = 1),
                   numericInput('Stage', 'Cancer Stage', 0, min = 0, max = 4),
                   selectInput("CACS", "CACS",  c("CACS = 0" = "0",
                                                  "0 < CACS < = 100" = "1",
                                                  "100 < CACS <= 400" = "2",
                                                  "CACS > 400" = "3")),
                   numericInput("chemo", "Chemotherapy (yes=1, no=0)", 0, min = 0, max = 1)
            ),
            column(6, numericInput("Folfox", "FOLFOX (yes=1, no=0)", 0, min = 0, max = 1),
                   numericInput("Folfiri", "FOLFIRI (yes=1, no=0)", 0, min = 0, max = 1),
                   numericInput("Taxene", "Taxene (yes=1, no=0)", 0, min = 0, max = 1),
                   numericInput("Fluorouracil", "Fluorouracil (yes=1, no=0)", 0, min = 0, max = 1),
                   numericInput("Herceptin", "Herceptin (yes=1, no=0)", 0, min = 0, max = 1),
                   numericInput("Avastin", "Avastin (yes=1, no=0)", 0, min = 0, max = 1),
                   numericInput("Erbitux", "Erbitux (yes=1, no=0)", 0, min = 0, max = 1),
                   numericInput("Zaltrap", "Zaltrap (yes=1, no=0)", 0, min = 0, max = 1),
                   numericInput("otherChemo", "Other Chemotherapy (yes=1, no=0)", 0, min = 0, max = 1)
            ),
            
            column(12, actionButton(
              inputId = "submit",
              label = "Submit"),
              align = "right",
              style = "margin-top: 10px; margin-right: 10px;"
            )
        ),
        box(width = 8,
            h4(textOutput("pred_result",inline = T))
        )
      )
    )
  )
)
