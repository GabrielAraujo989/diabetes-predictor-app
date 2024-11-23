# Diabetes Predictor App

![Diabetes Predictor Logo](https://github.com/GabrielAraujo989/diabetes-predictor-app/raw/main/assets/logo.png)

## 📋 Visão Geral

O **Diabetes Predictor App** é uma aplicação completa que integra um **frontend desenvolvido em Flutter** e um **backend em Flask**. Este aplicativo tem como objetivo ajudar os usuários a preverem suas chances de desenvolver diabetes através de um questionário interativo. As respostas são processadas por um modelo de machine learning treinado, retornando previsões personalizadas.

## 🔍 Funcionalidades

- **Interface Intuitiva:** Desenvolvida com Flutter para oferecer uma experiência de usuário fluida e responsiva em dispositivos móveis.
- **Questionário Personalizado:** Coleta informações relevantes sobre a saúde do usuário de forma interativa.
- **Predição de Diabetes:** Utiliza um modelo de Random Forest treinado para prever as chances de desenvolver diabetes com base nas respostas fornecidas.
- **Armazenamento Seguro:** Utiliza `SharedPreferences` para armazenar resultados e feedbacks dos usuários de forma local e segura.
- **Pesquisa de Satisfação:** Permite aos usuários avaliarem a aplicação, contribuindo para melhorias contínuas.

## 🛠 Tecnologias Utilizadas

### Frontend

- **Flutter:** Framework open-source para desenvolvimento de interfaces nativas para mobile.
- **Dart:** Linguagem de programação utilizada pelo Flutter para criar aplicações eficientes e de alto desempenho.
- **Shared Preferences:** Biblioteca para armazenamento local de dados no dispositivo, garantindo que as informações do usuário sejam salvas de forma segura e acessível.

### Backend

- **Flask:** Framework web leve e flexível para construção da API de predição.
- **Scikit-learn:** Biblioteca de machine learning para treinar e utilizar o modelo de predição de diabetes.
- **Pandas & NumPy:** Bibliotecas para manipulação e processamento de dados, essenciais para preparar os dados de entrada para o modelo.
- **Pickle:** Biblioteca para serialização e desserialização do modelo treinado, permitindo que ele seja carregado e utilizado pela API.

## 📂 Estrutura do Projeto
```plaintext
diabetes-predictor-app/
├── backend/
│   ├── FlaskApi/
│   │   ├── DiabeticApi.py
│   │   ├── models/
│   │   │   ├── scaler.pkl
│   │   │   └── pca_model.pkl
│   ├── requirements.txt
│   └── README.md
├── frontend_diabetic/
│   ├── lib/
│   │   ├── main.dart
│   │   ├── main_navigation.dart
│   │   ├── pages/
│   │   │   ├── home_page.dart
│   │   │   ├── questionnaire_page.dart
│   │   │   ├── resultquestion_page.dart
│   │   │   └── satisfactionsurvey_page.dart
│   │   └── themes.dart
│   ├── pubspec.yaml
│   └── README.md
├── .gitignore
└── README.md
```
## ⚙️ Instalação

### 📦 Requisitos

- **Backend:**
  - Python 3.7 ou superior
  - Pip
- **Frontend:**
  - Flutter SDK
  - Dart SDK

### 🖥️ Configuração do Backend

1. **Clone o Repositório:**

   ```bash
   git clone https://github.com/GabrielAraujo989/diabetes-predictor-app.git
   cd diabetes-predictor-app/backend
   ```

2. **Criar e Ativar um Ambiente Virtual (Opcional, mas Recomendado):**
```bash
python -m venv venv
```
- **Ativar o Ambiente Virtual:**
  - No Windows:
```bash
venv\Scripts\activate
````
   -  No macOS/Linux:
```bash
source venv/bin/activate
```
 - **Instalar Dependências:**
```bash
pip install -r requirements.txt
```
 - **Configurar Variáveis de Ambiente:**
   - Crie um arquivo .env na raiz do diretório backend e adicione as seguintes variáveis:
```bash
MODEL_PATH=models/RandomForest_model.pkl
SCALER_PATH=models/scaler.pkl
PCA_PATH=models/pca_model.pkl
```
 - **Configurar Variáveis de Ambiente:**
```bash
cd ../frontend_diabetic
```
 - **Instalar Dependências:**
```bash
flutter pub get
```
- **Executar a Aplicação Flutter:**
 - **Instalar Dependências:**
```bash
flutter run
```


### **Explicações Adicionais:**

1. **Passo 2: Criar e Ativar um Ambiente Virtual**
   
   - **Ambientes Virtuais:** Utilizar um ambiente virtual é uma prática recomendada para isolar as dependências do projeto, evitando conflitos com outras versões de pacotes instalados globalmente.
   - **Comandos de Ativação:** Dependendo do sistema operacional, o comando para ativar o ambiente virtual difere. No Windows, você utiliza `venv\Scripts\activate`, enquanto no macOS/Linux, utiliza `source venv/bin/activate`.

2. **Passo 3: Instalar Dependências**
   
   - **`requirements.txt`:** Este arquivo contém todas as dependências necessárias para o backend do projeto. A instalação garante que todas as bibliotecas requeridas estejam disponíveis no ambiente virtual.

3. **Passo 4: Configurar Variáveis de Ambiente**
   
   - **Arquivo `.env`:** Armazenar variáveis de ambiente em um arquivo `.env` facilita a configuração do projeto sem a necessidade de modificar o código-fonte. As variáveis definidas apontam para os caminhos dos modelos treinados e outros objetos necessários para a API Flask.

4. **Passo 5: Executar a API Flask**
   
   - **Iniciando o Servidor Flask:** Este comando inicia a API Flask, tornando os endpoints disponíveis para consumo pelo frontend desenvolvido em Flutter.
   - **Verificação:** Após a execução, acesse `http://0.0.0.0:5000/predict` para verificar se a API está funcionando corretamente.

5. **Configuração do Frontend**
   
   - **Navegação para o Diretório:** Certifique-se de estar no diretório correto ([frontend_diabetic](http://_vscodecontentref_/0)) antes de executar os comandos do Flutter.
   - **Instalação de Dependências e Execução:** Os comandos `flutter pub get` e `flutter run` instalam as dependências necessárias e iniciam a aplicação Flutter, respectivamente.

### **Dicas Adicionais:**

- **Manutenção do Ambiente Virtual:**
  - Sempre que iniciar um novo terminal para trabalhar no projeto, lembre-se de ativar o ambiente virtual.
  
- **Gerenciamento de Dependências:**
  - Utilize `pip freeze > requirements.txt` para atualizar o arquivo de dependências sempre que adicionar ou atualizar pacotes no ambiente virtual.

- **Versionamento de Variáveis de Ambiente:**
  - **Segurança:** Evite versionar o arquivo `.env` para proteger informações sensíveis. Adicione-o ao `.gitignore` se ainda não estiver incluído.

- **Verificação da API:**
  - Utilize ferramentas como `Postman` ou `curl` para testar os endpoints da API Flask e garantir que estão respondendo conforme esperado.
