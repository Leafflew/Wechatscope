
library(shiny)
library(readr)

createLink <- function(link, val) {
  l = paste0('<a href="http://wechatscope.jmsc.hku.hk:8000/html?fn=', link, '" target="_blank" class="btn btn-primary">查看全文</a>')
  sprintf(l,val)
}

# Define UI for data download app ----
ui <- function(input, output, session){
  navbarPage(
    title = 'Wechatscope',
    tabPanel('From 2018-07-06', DT::dataTableOutput('table1'))
  )
}


# Define server logic to display and download selected file ----
server <- function(input, output, session) {
  
  wechat = reactiveFileReader(10000, session, 'ceninfo.csv', read_csv)
  
  output$table1 <- DT::renderDataTable({
    we = wechat()
    
    we$archive = createLink(we$archive, we$archive)
    
    DT::datatable(we[, c(2,4,5:9)], escape = FALSE)
  })
  
}

# Create Shiny app ----
shinyApp(ui, server)
