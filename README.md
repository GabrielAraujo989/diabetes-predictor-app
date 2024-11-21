# Diabetes Predictor App

## Descrição do Projeto

Este projeto tem como objetivo desenvolver um aplicativo para prever o diagnóstico de diabetes com base em indicadores de saúde. Ele utiliza o "Diabetes Health Indicators Dataset" disponível no Kaggle.

**Conjunto de Dados:** [https://www.kaggle.com/datasets/alexteboul/diabetes-health-indicators-dataset](https://www.kaggle.com/datasets/alexteboul/diabetes-health-indicators-dataset)

**Nome do arquivo:** diabetes_binary_health_indicators_BRFSS2015.csv


## Equipe do Projeto

- Gabriel Araujo de Padua
- Marlon Vinicius de Souza
- Matheus Oliveira Mancio


## Informações sobre o Conjunto de Dados

- **Qtde de Atributos:** 22
- **Qtde de exemplos:** 253.680
- **Valores Ausentes:** Não
- **Classes:**
    - 0: Ausência de diabetes
    - 1: Presença de diabetes
- **Distribuição de Classe:**
    - Classe 0: 86,06%
    - Classe 1: 13,94%

## Rodando o aplicativo

- Clonar o projeto
- Abrir um terminal da pasta raiz
- Entrar na pasta do aplicativo

```
cd app
```
- Abrir seu emulador de celular e depois rodar o comando no terminal
```
flutter run
```

## Rodando a API

- Usar o mesmo projeto clonado anteriormente
- Abrir um novo terminal da pasta raiz
- Entrar na pasta da api
```
cd aprendizado-maquina
```
- Rodar a API
```
python api.py
```