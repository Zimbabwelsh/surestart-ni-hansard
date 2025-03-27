library(tidyverse)
library(sf)
library(viridis)

df <- read.csv("data/sure start coverage (hansard 2006) (checked).csv")

df$bestMatch <- stringr::str_to_upper(df$bestMatch)

## Match to shapefiles from 1993 electoral wards (from https://www.opendatani.gov.uk/@land-property/osni-open-data-largescale-boundaries-wards-1993)

geom <- read_sf("data/geometry/OSNI_Open_Data_-_Largescale_Boundaries_-_Wards_(1993).shp")

fulldf <- left_join(geom, df, 
                    join_by(NAME==bestMatch))

write_sf( fulldf, "data/geometry/geom_data_hansard.shp")




uptake2006 <- ggplot(fulldf)+
       geom_sf(aes(fill = hansard_2006_coverage), color = "lightgrey" ,linewidth =0.2)+ 
  theme_bw()+
  scale_fill_viridis_c(na.value = "#ECECEC", name = "2006 Uptake")
  
uptake2006

ggsave("uptake2006.png", uptake2006, dpi = 600, width = 6, height = 6)
