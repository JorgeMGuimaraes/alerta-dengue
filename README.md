# alerta-dengue

App Alerta Dengue

## Description

Desenvolver o aplicativo Alerta Dengue, que dado o tipo de doença, cidade e data exibe os números de casos previstos e notificados. Para obter os dados deve ser utilizado a api alerta dengue para retornar os dados no formato JSON, conforme a documentação no link:
https://info.dengue.mat.br/services/api/doc

Exemplo dos filtros da API e do dicionário de dados:
https://info.dengue.mat.br/services/api

A api precisa de informação do código da cidade (geocode) e estado tabelados pelo IBGE que podem ser acessados:
https://www.ibge.gov.br/explica/codigos-dos-municipios.php

Filtros:
- Doença (Dengue, Chikungunya e Zika)
- Estado (capital)
- Data

O aplicativo possui 2 telas:
- Tela de Alerta Dengue (Tela de Home).
- Tela de Resultados.

Ao iniciar o aplicativo, a Tela de Home apresenta os filtros para o usuário informar a doença e data da consulta, uma lista de estados do Brasil. Ao selecionar um estado, deve-se navegar para a tela que apresenta o resultado da API exibindo o número de casos previstos (casos_est) e notificados (cases), nível (level - 1 à 5) e as temperaturas mínimas (tempmin) e máximas (tempmax) para cada semana.

A construção do layout do app é livre e as chamadas da api podem ser tratadas com Future classes.

Deve-se entregar o arquivo compactado contendo o projeto flutter e um print da tela rodando ele com algum simulador (android, web ou desktop).

Arquivos na pasta do projeto flutter:
- Pasta lib;
- Pastas com images (caso utilizado);
- Arquivo pubspec.yaml.