# slickR -------------
library(svglite)
library(lattice)
library(ggplot2)
library(rvest) 
library(reshape2)
library(dplyr)
library(htmlwidgets)
library(slickR)
library(xml2)

#NBA Team Logos
nbaTeams=c("ATL","BOS","BKN","CHA","CHI","CLE","DAL","DEN","DET","GSW",
           "HOU","IND","LAC","LAL","MEM","MIA","MIL","MIN","NOP","NYK",
           "OKC","ORL","PHI","PHX","POR","SAC","SAS","TOR","UTA","WAS")
teamImg=sprintf("https://i.cdn.turner.com/nba/nba/.element/img/4.0/global/logos/512x512/bg.white/svg/%s.svg",nbaTeams)

#Player Images
a1=read_html('http://www.espn.com/nba/depth')%>%html_nodes(css = '#my-teams-table a')
a2=a1%>%html_attr('href')
a3=a1%>%html_text()
team_table=read_html('http://www.espn.com/nba/depth')%>%html_table()
team_table=team_table[[1]][-c(1,2),]
playerTable=team_table%>%melt(,id='X1')%>%arrange(X1,variable)
playerName=a2[grepl('[0-9]',a2)]
playerId=do.call('rbind',lapply(strsplit(playerName,'[/]'),function(x) x[c(8,9)]))
playerId=playerId[playerId[,1]!='phi',]
playerTable$img=sprintf('http://a.espncdn.com/combiner/i?img=/i/headshots/nba/players/full/%s.png&w=350&h=254',playerId[,1])

slickR(
  obj = playerTable$img,
  slideId = c('ex2'),
  slickOpts = list(
    initialSlide = 0,
    slidesToShow = 5,
    slidesToScroll = 5,
    focusOnSelect = T,
    autoplay = T,
    autoplaySpeed = 300,
    dots = T
  ),
  height = 100,width='100%'
)

