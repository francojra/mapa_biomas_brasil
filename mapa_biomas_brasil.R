
# Mapa Biomas do Brasil --------------------------------------------------------------------------------------------------------------------
# Autora do script: Jeanne Franco ----------------------------------------------------------------------------------------------------------
# Data: 28/04/2024 -------------------------------------------------------------------------------------------------------------------------

# Carregar pacotes -------------------------------------------------------------------------------------------------------------------------

library(sf) # Permite ler arquivos shapefile
library(ggspatial)
library(tidyverse)
library(cols4all)

# Carregar dados shapefile -----------------------------------------------------------------------------------------------------------------

## Os dados de shapefile foram retirados do site do IBGE

## Dados biomas

my_biom <- read_sf("lm_bioma_250.shp") 

view(my_biom)

plot(st_geometry(my_biom))

## Dados regiões do Brasil

my_br <- read_sf("BR_UF_2022.shp") 

View(my_br)

# Mapa -----------------------------------------------------------------------------------------------------------------

## Selecionar cores

c4a_table(n = 12, type = "cat")
c4a_types()

## Criar mapa

ggplot() + 
  geom_sf(data = my_br) +
  geom_sf(data = my_biom, aes(fill = Bioma), color = "#f7fcb9") +
  geom_sf_text(data = my_br, aes(label = SIGLA_UF), 
               size = 1.5, fontface = "bold") +
  scale_fill_manual(values = c("#1E5A46", "#B38711", "#AF4F2F", 
                               "#1E395F", "#59385C", "#732F30")) +
  annotation_north_arrow(style = north_arrow_nautical(text_size = 7.5,
                                                      text_face = "bold"),
                         width = unit(1, "cm"),
                         height = unit(1, "cm")) +
  annotation_scale(location = "br", text_face = "bold",
                   height = unit(0.15, "cm")) +
  labs(x = "Longitude", y = "Latitude") +
  theme_minimal() +
  theme(axis.text = element_text(color = "black", 
                                 face = "bold", size = 8),
        axis.title = element_text(color = "black", 
                                  size = 9))