#setwd("~/Dropbox/Coursera_DataProducts/shinyProj")
library(shiny)

city_mpg <- function(cyl, eng, hp, disp, dtrain, tran, weight) {
    cyl4 = 0; cyl6 = 0; cyl8 = 0; cyl10 = 0; cyl12 = 0
    if (cyl == 4) {cyl4 = 1} 
    else if (cyl == 6) {cyl6 = 1} 
    else if (cyl == 8) {cyl8 = 1} 
    else if (cyl == 10) {cyl10 = 1} 
    else if (cyl == 12) {cyl12 = 1}
    mpg_cyl <- -3.311 * cyl4 -3.323 * cyl6 -0.041 * cyl8 -2.639 * cyl10 +1.862 * cyl12
    
    eng_diesel = 0; eng_flex = 0; eng_gas = 0; eng_hybrid = 0
    if (eng == "Diesel") {eng_diesel = 1}
    else if (eng == "Flexible Fuel") {eng_flex = 1}
    else if (eng == "Gas") {eng_gas = 1}
    else if (eng == "Hybrid") {eng_hybrid = 1}
    mpg_eng <- 47.702 * eng_diesel + 42.186 * eng_flex + 42.185 * eng_gas + 56.539 * eng_hybrid
    
    mpg_hp <- -0.0143 * hp
    mpg_disp <- -0.745 * disp
    
    dtrain_awd = 0; dtrain_fwd = 0; dtrain_rwd = 0
    if (dtrain == "AWD") {dtrain_awd = 1}
    else if (dtrain == "FWD") {dtrain_fwd = 1}
    else if (dtrain == "RWD") {dtrain_rwd = 1}
    mpg_dtrain <- 0.0039 * dtrain_awd + 0.985 * dtrain_fwd -0.292 * dtrain_rwd
    
    if (tran == "Manual") { mpg_tran <- -1.067}
    else mpg_tran <- 0
    
    mpg_wt <- -0.0030381 * weight
    
    # Return the last calc
    mpg_cyl + mpg_eng + mpg_hp + mpg_disp + mpg_dtrain + mpg_wt + mpg_tran + mpg_wt
}


hwy_mpg <- function(cyl, eng, hp, disp, dtrain, tran, weight) {
    cyl4 = 0; cyl6 = 0; cyl8 = 0; cyl10 = 0; cyl12 = 0
    if (cyl == 4) {cyl4 = 1} 
    else if (cyl == 6) {cyl6 = 1} 
    else if (cyl == 8) {cyl8 = 1} 
    else if (cyl == 10) {cyl10 = 1} 
    else if (cyl == 12) {cyl12 = 1}
    mpg_cyl <- 0.7899 * cyl4 + 1.54 * cyl6 + 4.214 * cyl8 + 2.843 * cyl10 + 4.663 * cyl12
    
    eng_diesel = 0; eng_flex = 0; eng_gas = 0; eng_hybrid = 0
    if (eng == "Diesel") {eng_diesel = 1}
    else if (eng == "Flexible Fuel") {eng_flex = 1}
    else if (eng == "Gas") {eng_gas = 1}
    else if (eng == "Hybrid") {eng_hybrid = 1}
    mpg_eng <- 54.065 * eng_diesel + 47.028 * eng_flex + 46.690 * eng_gas + 53.581 * eng_hybrid
    
    mpg_hp <- -0.0177 * hp
    mpg_disp <- -1.483 * disp
    
    dtrain_awd = 0; dtrain_fwd = 0; dtrain_rwd = 0
    if (dtrain == "AWD") {dtrain_awd = 1}
    else if (dtrain == "FWD") {dtrain_fwd = 1}
    else if (dtrain == "RWD") {dtrain_rwd = 1}
    mpg_dtrain <- 1.137 * dtrain_awd + 2.787 * dtrain_fwd + 2.279 * dtrain_rwd
    
    if (tran == "Manual") { mpg_tran <- -0.797}
    else mpg_tran <- 0
    
    mpg_wt <- -0.0035154 * weight
    
    # Return the last calc
    mpg_cyl + mpg_eng + mpg_hp + mpg_disp + mpg_dtrain + mpg_wt + mpg_tran + mpg_wt
}

shinyServer(
    function(input, output) {
        output$ocyl_id <- renderPrint({input$cyl_id})
        output$oeng_id <- renderPrint({input$eng_id})
        output$ohp_id <- renderPrint({input$hp_id})
        output$odisp_id <- renderPrint({input$disp_id})
        output$odtrain_id <- renderPrint({input$dtrain_id})
        output$otran_id <- renderPrint({input$tran_id})
        output$oweight_id <- renderPrint({input$weight_id})
        
        currCityMpg <- reactive(
            {city_mpg(input$cyl_id, input$eng_id, input$hp_id, input$disp_id, 
                      input$dtrain_id, input$tran_id,input$weight_id)}
            )
        
        currHwyMpg <- reactive(
            {hwy_mpg(input$cyl_id, input$eng_id, input$hp_id, input$disp_id, 
                     input$dtrain_id, input$tran_id,input$weight_id)},
    
        )
        output$ocitympg_id <- renderText({currCityMpg()})
        output$ohwympg_id <- renderText({currHwyMpg()})
        
    }
)
