server <- function(input, output, session) {
  
  testdata <- reactive({
    
    testdata <- c()
    
    testdata$sex10 <- ifelse(input$sex == 0, 1, 0)
    testdata$sex20 <- ifelse(input$sex == 1, 1, 0)
    testdata$HTN0 <- ifelse(input$HTN == 0, 1, 0)
    testdata$HTN1 <- ifelse(input$HTN == 1, 1, 0)
    testdata$DM0 <- ifelse(input$DM == 0, 1, 0)
    testdata$DM1 <- ifelse(input$DM == 1, 1, 0)
    testdata$CRF0 <- ifelse(input$CRF == 0, 1, 0)
    testdata$CRF1 <- ifelse(input$CRF == 1, 1, 0)
    testdata$Dyslipidemia0 <- ifelse(input$Dyslipidemia == 0, 1, 0)
    testdata$Dyslipidemia1 <- ifelse(input$Dyslipidemia == 1, 1, 0)
    testdata$Folfox0 <- ifelse(input$Folfox == 0, 1, 0)
    testdata$Folfox1 <- ifelse(input$Folfox == 1, 1, 0)
    testdata$Folfiri0 <- ifelse(input$Folfiri == 0, 1, 0)
    testdata$Folfiri1 <- ifelse(input$Folfiri == 1, 1, 0)
    testdata$Taxene0 <- ifelse(input$Taxene == 0, 1, 0)
    testdata$Taxene1 <- ifelse(input$Taxene == 1, 1, 0)
    testdata$Fluorouracil0 <- ifelse(input$Fluorouracil == 0, 1, 0)
    testdata$Fluorouracil1 <- ifelse(input$Fluorouracil == 1, 1, 0)
    testdata$Herceptin0 <- ifelse(input$Herceptin == 0, 1, 0)
    testdata$Herceptin1 <- ifelse(input$Herceptin == 1, 1, 0)
    testdata$Avastin0 <- ifelse(input$Avastin == 0, 1, 0)
    testdata$Avastin1 <- ifelse(input$Avastin == 1, 1, 0)
    testdata$Erbitux0 <- ifelse(input$Erbitux == 0, 1, 0)
    testdata$Erbitux1 <- ifelse(input$Erbitux == 1, 1, 0)
    testdata$Zaltrap0 <- ifelse(input$Zaltrap == 0, 1, 0)
    testdata$Zaltrap1 <- ifelse(input$Zaltrap == 1, 1, 0)
    testdata$otherChemo0 <- ifelse(input$otherChemo == 0, 1, 0)
    testdata$otherChemo1 <- ifelse(input$otherChemo == 1, 1, 0)
    testdata$Stage0 <- ifelse(input$Stage == 0, 1, 0)
    testdata$Stage1 <- ifelse(input$Stage == 1, 1, 0)
    testdata$Stage2 <- ifelse(input$Stage == 2, 1, 0)
    testdata$Stage3 <- ifelse(input$Stage == 3, 1, 0)
    testdata$Stage4 <- ifelse(input$Stage == 4, 1, 0)
    testdata$CAC_Total_AgatstonScore0 <- ifelse(as.numeric(input$CACS) == 0, 1, 0)
    testdata$CAC_Total_AgatstonScore1 <- ifelse(as.numeric(input$CACS) == 1, 1, 0)
    testdata$CAC_Total_AgatstonScore2 <- ifelse(as.numeric(input$CACS) == 2, 1, 0)
    testdata$CAC_Total_AgatstonScore3 <- ifelse(as.numeric(input$CACS) == 3, 1, 0)
    testdata$age <- (input$age - mean(sevAge, na.rm = T))/sd(sevAge, na.rm=T)
    
    testdata <- as.data.frame(testdata)
    
  })
  
  pred <- eventReactive(input$submit, {
    pred_xgb <- predict(fitXgbFinal, newdata=testdata(), type="prob")
    pred <- pred_xgb[,2] > threshold
  })
  
  output$pred_result <- renderText({
    if (pred())
      {"The risk of cardiovascular events is high."
    } else {
        "The risk of cardiovascular events is low."
      }})

}
