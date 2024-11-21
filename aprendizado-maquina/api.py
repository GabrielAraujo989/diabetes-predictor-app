from flask import Flask, request, jsonify
import numpy as np
import pandas as pd
import joblib

app = Flask(__name__)

# Caminho para o modelo treinado
MODEL_PATH = './modelos_treinados/LR.pkl'
# Caminho para o arquivo com os dados preexistentes (colunas e estrutura)
DATA_PATH = './diabetes_indicator_preprocessed_parametros.csv'

# Função para normalizar os dados
def normalizar(X, mu=None, sigma=None):
    if mu is None or sigma is None:
        mu = np.mean(X, axis=0)
        sigma = np.std(X, axis=0, ddof=1)
    X_norm = (X - mu) / sigma
    return X_norm, mu, sigma

# Carregando o modelo
lr_model = joblib.load(MODEL_PATH)

@app.route('/predict', methods=['POST'])
def predict():
    try:
        # Recebe os dados do cliente diretamente como array JSON
        entradas = request.json
        
        if not isinstance(entradas, list):
            return jsonify({"error": "Os dados enviados devem ser um array JSON"}), 400

        # Carrega os dados preexistentes para obter estrutura e normalização
        dados = pd.read_csv(DATA_PATH, sep=',')
        
        # Adiciona os dados do usuário ao DataFrame
        dados = pd.concat(
            [dados, pd.DataFrame([entradas], columns=dados.columns)],
            ignore_index=True
        )

        # Normaliza as colunas contínuas
        continuous_cols = ['BMI', 'GenHlth', 'MentHlth', 'PhysHlth', 'Age']
        X = dados[continuous_cols].values
        X_norm, mu, sigma = normalizar(X)
        dados[continuous_cols] = X_norm

        # Converte os dados em um array
        entrada_normalizada = dados.values[-1, 0:17].reshape(1, -1)  # Apenas a última entrada

        # Realiza a previsão
        previsao = lr_model.predict(entrada_normalizada)

        # Retorna o resultado
        resultado = "com diabetes" if previsao[0] == 1 else "sem diabetes"
        return jsonify({"prediction": resultado})
    
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000, debug=True)