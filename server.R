library(shiny)
library(ggplot2)
library(dplyr)
shinyServer(function(input, output) {
        
        output$plot1 <- renderPlot({
                typeInput <- input$distribution
                typeInput <- as.character(typeInput)
                if (typeInput=="Delivery method"){
                        g <- ggplot(aes(x=supp, y=len), data=ToothGrowth)
                        g <- g + geom_boxplot(aes(fill=supp))
                        g <- g + xlab("Delivery method") 
                        g <- g + ylab("Tooth growth")
                        g <- g + ggtitle("Tooth growth grouped by Delivery Method")
                        
                }
                else{
                        ToothGrowth$dose <- as.factor(ToothGrowth$dose)
                        g <- ggplot(aes(x=dose, y=len), data=ToothGrowth)
                        g <- g + geom_boxplot(aes(fill=dose))
                        g <- g + xlab("Dose (mg/day)") 
                        g <- g + ylab("Tooth growth")
                        g <- g + ggtitle("Tooth growth grouped by dose")
                }
                g
        })
        
        ToothGrowth05<-filter(ToothGrowth, dose==0.5)
        ToothGrowth1<-filter(ToothGrowth, dose==1)
        ToothGrowth2<-filter(ToothGrowth, dose==2)
    
        test_groups <- reactive({
                if (input$delivery=="Orange juice (OJ)")
                        method="OJ"
                else
                        method="VC"
                if (input$dose1 != input$dose2){
                        
                        if (input$dose1!=2 & input$dose2!=2 ){
                                ToothGrowth <- filter(ToothGrowth, supp==method & dose !=2)
                        }
                        else if (input$dose1!=0.5 & input$dose2!=0.5){
                                ToothGrowth <- filter(ToothGrowth, supp==method & dose !=0.5)
                        }
                        else{
                                ToothGrowth <- filter(ToothGrowth, supp=="OJ" & dose !=1)   
                        }
                        test_result <- t.test(len ~ dose, paired = FALSE, var.equal = TRUE, data = ToothGrowth)
                        tStatistic <- as.character(test_result$statistic)
                        pValue <- as.character(test_result$p.value)
                        result <- paste("T Statistic =",tStatistic,", P Value =",pValue, sep=" ")
                                        
                }
                else{
                                
                        result <- "dose 1 and dose 2 cannot be equal"            
                }

                
        })
        
        output$text1 <- renderText(test_groups())
        
})