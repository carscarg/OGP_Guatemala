# Serve Presupuesto

#SearchTree----

output$Hierarchy <- renderUI({
  Hierarchy=names(formulacion2018)
  Hierarchy=head(Hierarchy,-1)
  selectizeInput("Hierarchy","Tree Hierarchy",
                 choices = Hierarchy,multiple=T,selected = Hierarchy,
                 options=list(plugins=list('drag_drop','remove_button')))
})

network <- reactiveValues()

observeEvent(input$d3_update,{
  network$nodes <- unlist(input$d3_update$.nodesData)
  activeNode<-input$d3_update$.activeNode
  if(!is.null(activeNode)) network$click <- jsonlite::fromJSON(activeNode)
})

observeEvent(network$click,{
  output$clickView<-renderTable({
    as.data.frame(network$click)},
    caption='Last Clicked Node',caption.placement='top')
})


TreeStruct=eventReactive(network$nodes,{
  df=formulacion2018
  if(is.null(network$nodes)){
    df=formulacion2018
  }else{
    
    x.filter=tree.filter(network$nodes,m)
    df=ddply(x.filter,.(ID),function(a.x){formulacion2018%>%filter_(.dots = list(a.x$FILTER))%>%distinct})
  }
  df
})

observeEvent(input$Hierarchy,{
  output$d3 <- renderD3tree({
    if(is.null(input$Hierarchy)){
      p <- formulacion2018
    }else{
      p=formulacion2018%>%select(one_of(c(input$Hierarchy,"NEWCOL")))%>%unique
      #p <- select_(m, c(input$Hierarchy),"NEWCOL") %>% distinct(.keep_all=TRUE)
    }
    
    d3tree(data = list(root = df2tree(struct = p,rootname = 'Presupuestos'), layout = 'collapse', linkLength=1000),
           activeReturn = c('name','value','depth','id'),
           height = 18)
  })
})

observeEvent(network$nodes,{
  output$results <- renderPrint({
    str.out=''
    if(!is.null(network$nodes)) str.out=tree.filter(network$nodes,formulacion2018)
    return(str.out)
  })    
})

output$tableTree <- renderDataTable(expr = {
  datatable(TreeStruct() %>% select(-NEWCOL), extensions = c('Scroller','FixedColumns'),
            options = list(dom='ft',
                           pageLength = 20, 
                           autoWidth = TRUE,
                           deferRender = TRUE,
                           scrollY = 650,
                           scrollX = TRUE,
                           fixedColumns = list(leftColumns = 1),
                           scroller = TRUE,
                           initComplete = JS("function(settings, json) {","$(this.api().table().header()).css({'background-color': '#99ccff', 'color': '#003366', 'font-size': '11px'});","}")), 
            rownames = FALSE) %>%
    formatStyle(0, target = 'row', fontSize = '60%', lineHeight = '80%')
})

