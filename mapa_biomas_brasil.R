
# Mapa Biomas do Brasil --------------------------------------------------------------------------------------------------------------------
# Autora do script: Jeanne Franco ----------------------------------------------------------------------------------------------------------
# Data: 28/04/2024 -------------------------------------------------------------------------------------------------------------------------

# Carregar pacotes -------------------------------------------------------------------------------------------------------------------------

library(sf) # Permite ler arquivos shapefile
library(ggspatial) # Adicionar símbolo de orientação e escala
library(tidyverse) # Produzir mapa com ggplot2
library(cols4all) # Selecionar cores do mapa

# Carregar dados shapefile -----------------------------------------------------------------------------------------------------------------

## Os dados de shapefile foram retirados do site do IBGE

## Dados biomas

my_biom <- read_sf("lm_bioma_250.shp") 
view(my_biom)
plot(st_geometry(my_biom))

## Dados regiões do Brasil

my_br <- read_sf("BR_UF_2022.shp") 
view(my_br)
plot(st_geometry(my_br))

# Mapa -----------------------------------------------------------------------------------------------------------------

## Selecionar cores

c4a_table(n = 12, type = "cat")
c4a_types()

"#04A3BD"
"#F0BE3D"
"#931E18"
"#DA7901"
"#247D3F"
"#20235B"

## Criar mapa

m <- ggplot() + 
  geom_sf(data = my_br) +
  geom_sf(data = my_biom, aes(fill = Bioma), color = "#f7fcb9") +
  geom_sf_text(data = my_br, aes(label = SIGLA_UF), 
               size = 2.2, fontface = "bold", color = "#f7fcb9") +
  scale_fill_manual(values = c("#1E5A46", "#B38711", "#AF4F2F", 
                               "#1E395F", "#59385C", "#732F30")) +
  annotation_north_arrow(style = 
                north_arrow_nautical(text_size = 7.5,
                          text_face = "bold"),
                         width = unit(1, "cm"),
                         height = unit(1, "cm")) +
  annotation_scale(location = "br", text_face = "bold",
                   height = unit(0.15, "cm")) +
  labs(x = "Longitude", y = "Latitude", fill = "") +
  ggtitle("Biomas do Brasil") +
  theme_minimal() +
  theme(axis.text = element_text(color = "black", 
                          face = "bold", size = 8.5,
                          family = "serif"),
        axis.title = element_text(color = "black", 
                           face = "bold", size = 10,
                           family = "serif"),
        title = element_text(color = "black", 
                           face = "bold", size = 10,
                           family = "serif"),
        legend.position = c(0.88, 0.24),
        legend.text = element_text(family = "serif",
                        face = "bold", size = 10))
m

# Salvar mapa ------------------------------------------------------------------------------------------------------------------------------

ggsave("m.jpg", dpi = 300,
       width = 35, height = 15, 
       units = "cm", m)

ggsave("m.pdf", dpi = 300,
       width = 35, height = 15, 
       units = "cm", m)

