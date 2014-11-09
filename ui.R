library(shiny)
shinyUI(pageWithSidebar(
    headerPanel("Estimate Fuel Efficiency"),
    sidebarPanel(
        selectInput("eng_id", "Engine Type",
                    list("Diesel","Flexible Fuel","Gas","Hybrid")),
        numericInput("cyl_id", "Cylinders", 4, min = 4, max = 12, step = 2),
        numericInput("hp_id", "Horsepower", 200, min = 100, max = 600, step = 25),
        numericInput("disp_id", "Engine Displacement (in Liters)", 2, min = 1, max = 8, step = 0.5),
        selectInput("dtrain_id", "Drivetrain",
                    list("All-Wheel Drive" = "AWD",
                         "Front-Wheel Drive" = "FWD",
                         "Rear-Wheel Drive" = "RWD")),
        radioButtons("tran_id", "Transmission Type",
                     list("Automatic" = "Auto",
                          "Manual" = "Manual")),
        numericInput("weight_id", "Weight (in lbs)", 3500, min = 1750, max = 6250, step = 250),
        submitButton("Submit")
    ),
    mainPanel(
        h3('How to use this calulator'),
        p("To get an estimate to your vehicle's city and highway miles-per-gallon, specify the engine type, number of cylinders, horsepower, engine displacement, drive train type, transmission type and weight on the left and click Submit."),
                
        h4('City MPG: '),
        verbatimTextOutput("ocitympg_id"),
        
        h4('Highway MPG: '),
        verbatimTextOutput("ohwympg_id"),
        
        br(),br(),
        strong("Note:"), "Predictive algorithm was created using a linear regression model on data from",
        a("Kiplinger's 2014 New Car Rankings: Compare Costs, Performance Data publication.", href = "http://www.kiplinger.com/tool/cars/T011-S001-2012-new-car-rankings-compare-costs-performance-da/index.php?table=all&mfr=&filter=all?id=all")

    )
))
