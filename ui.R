#
# For the developing Data Products course project a Shiny Application has been created 
# which will predict the class of breast cancer on the basis of chosen parameters. 

# Breast Cancer dataset has been taken from the 'mlbench' R package. 


library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Breast Tumour Classification - Benign or Malignant"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      h4("This Shiny Application has been created which will predict the class of breast
         cancer on the basis of chosen parameters.Breast Cancer dataset has been taken from
         the mlbench R. To reproduce the shiny application on your local system, you need to
         install the relevent packages (mlbench, caret, ggplot2 and randomForest) and download Breast Cancer dataset,
         server.R and ui.R from github repository."),
      h5("Prediction of type of tumour based on 9 parameters:"),
      sliderInput("cl_thickness",
                  "CL. THICKNESS:",
                  min = 1,
                  max = 10,
                  value = 8),
      sliderInput("cell_size",
                  "CELL SIZE:",
                  min = 1,
                  max = 10,
                  value = 10),
      sliderInput("cell_shape",
                  "CELL SHAPE:",
                  min = 1,
                  max = 10,
                  value = 10),
      sliderInput("marg_adhesion",
                  "MARG ADHESION:",
                  min = 1,
                  max = 10,
                  value = 8),
      sliderInput("epith_c_size",
                  "EPITH C SIZE:",
                  min = 1,
                  max = 10,
                  value = 7),
      sliderInput("bare_nuclei",
                  "BARE NUCLEI:",
                  min = 1,
                  max = 10,
                  value = 10),
      sliderInput("bl_cromatin",
                  "BL CROMATIN:",
                  min = 1,
                  max = 10,
                  value = 9),
      sliderInput("normal_nuclei",
                  "NORMAL NUCLEI:",
                  min = 1,
                  max = 10,
                  value = 7),
      sliderInput("mitoses",
                  "MITOSES:",
                  min = 1,
                  max = 9,
                  value = 1),
      
      radioButtons(inputId = "inGen",
                   label = "no of trees",
                   choices = c("5"=5, "10"=10),
                   inline = TRUE)
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h5('Parameter values are:'),
      htmlOutput("in_Text"),
      htmlOutput("pred"),
      plotOutput('plt')
    )
  )
))
