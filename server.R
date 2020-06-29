
# Loading libraries
library(mlbench)
data('BreastCancer')
library(caret)
library(randomForest)
library(dplyr)
library(reshape2)
library(ggplot2)

# Loading data
BreastCancer <- BreastCancer[!is.na(BreastCancer$Bare.nuclei),]
BreastCancer <- BreastCancer[,2:11]

library(shiny)

# Define server logic required to predict the tumor class and draw a histogram
shinyServer(function(input, output) {
  output$in_Text <- renderText({
    results()
  })
  
  results <- reactive({
    p1 <- input$cl_thickness
    p2 <- input$cell_size
    p3 <- input$cell_shape
    p4 <- input$marg_adhesion
    p5 <- input$epith_c_size
    p6 <- input$epith_c_size
    p7 <- input$bare_nuclei
    p8 <- input$bl_cromatin
    p9 <- input$mitoses
    
    r_in <- c(p1,p2,p3,p4,p5,p6,p7,p8,p9)
    r_in
  })
  
  output$pred <- renderText({
    df <- data.frame(Cl.thickness=ordered(input$cl_thickness, levels=levels(BreastCancer$Cl.thickness)), 
                     Cell.size=ordered(input$cell_size, levels=levels(BreastCancer$Cell.size)),
                     Cell.shape=ordered(input$cell_shape, levels = levels(BreastCancer$Cell.shape)),
                     Marg.adhesion=ordered(input$marg_adhesion, levels=levels(BreastCancer$Marg.adhesion)),
                     Epith.c.size=ordered(input$epith_c_size,levels=levels(BreastCancer$Epith.c.size)),
                     Bare.nuclei=factor(input$bare_nuclei,levels=levels(BreastCancer$Bare.nuclei)),
                     Bl.cromatin=factor(input$bl_cromatin,levels=levels(BreastCancer$Bl.cromatin)),
                     Normal.nucleoli=factor(input$normal_nuclei,levels=levels(BreastCancer$Normal.nucleoli)),
                     Mitoses=factor(input$mitoses,levels=levels(BreastCancer$Mitoses)))
                     
    nT <- as.integer(input$inGen)
    
    model_rf <- randomForest(Class ~ ., data = BreastCancer, importance=TRUE, ntree = nT)
    
    ch <- predict(model_rf, newdata=df)
    
    paste0("Model predicted type of tumour to be:",
           em(strong(ch))
           
    )
  })
  
  output$plt <- renderPlot({
    bucket <- list(Cl.thickness=BreastCancer$Cl.thickness,Cell.size=BreastCancer$Cell.size, Cell.shape=BreastCancer$Cell.shape,
                   Marg.adhesion=BreastCancer$Marg.adhesion, Epith.c.size=BreastCancer$Bare.nuclei,Bare.nuclei=BreastCancer$Bare.nuclei,
                   Bl.cromatin=BreastCancer$Bl.cromatin, Normal.nucleoli=BreastCancer$Normal.nucleoli, Mitoses=BreastCancer$Mitoses)
    ggplot(melt(bucket), aes(value, fill = L1)) + geom_histogram(position = "stack", stat = 'count')
  })
   

  
})
