# Obtendo as bases de dados

# Querys:
# Scopus: TITLE ( water  AND governance )
# WOS: TÍTULO: (water governance)

# instalação de pacotes ----
install.packages("bibliometrix")

library(ggplot2)

library(dplyr)
knitr
htmltools
kableExtra

glimpse(dados)

# Attaching package: 'dplyr'
# The following objects are masked from 'package:stats':
# 	filter, lag
#
# The following objects are masked from 'package:base':
# 	intersect, setdiff, setequal, union

library(bibliometrix)
# To cite bibliometrix in publications, please use:

# Aria, M. & Cuccurullo, C. (2017) bibliometrix: An R-tool for comprehensive science mapping analysis, Journal of Informetrics, 11(4), pp 959-975, Elsevier.

# https://www.bibliometrix.org

# For information and bug reports:
# - Send an email to info@bibliometrix.org
# - Write a post on https://github.com/massimoaria/bibliometrix/issues

# Help us to keep Bibliometrix free to download and use by contributing with a small donation to support our research team (https://bibliometrix.org/donate.html)

# To start with the shiny web-interface, please digit:

biblioshiny()

# Importar os dados ----
# A próxima etapa é importar os dados. A função para importar é bibliometrix::convert2df(), sendo importante informar como argumento: o caminho até o arquivo a ser aberto, a fonte dos dados (dbsource) e o formato do arquivo.

CARREGAR O BANCO DE DADOS

# Os dados exportados do scopus são mais simples, pois é apenas um arquivo:
dados_scopus <- bibliometrix::convert2df("dados/scopus.bib", dbsource = "scopus", format = "bibtex")

dados_eric <- bibliometrix::convert2df("dados/eric.bib", dbsource = "pubmed", format = "bibtex")

# Para importar os dados do Wos, utilizei os passos abaixo:
# listar arquivos que preciso abrir:
# todos eles começam com o padrão "savedrecs_"
arquivos_wos <- list.files("dados", pattern = "^savedrecs_", full.names = TRUE)

arquivos_wos

# Utilizando esse vetor de caminhos até os arquivos, utilizamos a função convert2df para importá-los

dados_wos <- bibliometrix::convert2df(arquivos_wos, dbsource = "wos", format = "bibtex")

# ERIC
# dados_wos <- bibliometrix::convert2df(arquivos_eric, dbsource = "wos", format = "bibtex")

# união dos dados e exclusão das duplicatas ----
dados_brutos <- bibliometrix::mergeDbSources(dados_scopus, dados_eric, dados_wos, remove.duplicated = TRUE)

# Análise Bíbliométrica
results <- bibliometrix::biblioAnalysis(dados_brutos, sep = ";")


# resumo: resume os principais resultados da análise
options(width=100)
S <- bibliometrix::sumary(object = results, k = 10, pause = FALSE)


glimpse(dados)

library(knitr)
kable(head(dados, 10), col.names =  c("nome"))

# tabela do pacote padrão
library(rmarkdown)
paged_table(dados)

kableExtra
