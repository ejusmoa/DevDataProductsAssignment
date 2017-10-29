library(shiny)
shinyUI(fluidPage(
        titlePanel("Tooth growth of guinea pigs"),
        h5("This application allows to carry out different tests on the dataset
           ToothGrowth, that contains the response of 60 guinea pigs to vitmine C.
           Each animal received one of three dose levels of vitamin C (0.5, 1, 
           and 2 mg/day) by one of two delivery methods, (orange juice or ascorbic 
           acid (a form of vitamin C and coded as VC)."),
        h5("First of all, the user can take a look at the distribution of tooth growth
           grouped by either delivery method or dose."),
        h5("Then, A delivery method has to be selected."),
        h5("Finally, two different doses have to be selected to compare the tooth growth
           between different doses with same delivery method."),
        h5("The T statistic and P-value for the test with the parameters entered are displayed."),
        sidebarLayout(
                sidebarPanel(
                        selectInput("distribution", "Tooth growth distribution grouped by",
                                    c("Delivery method","Dose")),
                        selectInput("delivery", "Select a delivery method",
                                    c("Orange juice (OJ)","Ascorbic acid (VC)")),
                        radioButtons("dose1", "Select the first dose:",
                                     c(0.5,1,2)),
                        radioButtons("dose2", "Select the second dose:",
                                     c(0.5,1,2))
                ),
                mainPanel(
                        h3("Tooth growth distribution"),
                        plotOutput("plot1"),
                        h3("Test outputs"),
                        textOutput("text1")
                )
        )
))