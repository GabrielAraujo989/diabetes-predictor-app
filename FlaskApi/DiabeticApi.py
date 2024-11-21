from flask import Flask, request, jsonify
import pickle
import numpy as np
import pandas as pd
from sklearn.preprocessing import StandardScaler
from sklearn.decomposition import PCA
import os

app = Flask(__name__)

# Caminho para o modelo treinado e outros objetos necessários
MODEL_PATH = os.getenv('MODEL_PATH', 'models/RandomForest_model.pkl')
SCALER_PATH = 'models/scaler.pkl'
PCA_PATH = 'models/pca_model.pkl'

# Carregar modelo, scaler e PCA
with open(MODEL_PATH, 'rb') as model_file:
    model = pickle.load(model_file)

with open(SCALER_PATH, 'rb') as scaler_file:
    scaler = pickle.load(scaler_file)

with open(PCA_PATH, 'rb') as pca_file:
    pca = pickle.load(pca_file)

# Definir os nomes das características
FEATURE_NAMES = [
    'HighBP', 'HighChol', 'CholCheck', 'BMI', 'Smoker', 'Stroke',
    'HeartDiseaseorAttack', 'PhysActivity', 'Fruits', 'Veggies',
    'HvyAlcoholConsump', 'GenHlth', 'MentHlth', 'PhysHlth',
    'DiffWalk', 'Sex', 'Age'
]

@app.route('/predict', methods=['POST'])
def predict():
    try:
        # Obter os dados do JSON recebido
        data = request.get_json(force=True)

        # Função para processar e prever a partir de um DataFrame
        def process_prediction(input_df):
            # Aplicar padronização e PCA
            scaled_data = scaler.transform(input_df)
            reduced_data = pca.transform(scaled_data)

            # Fazer a predição
            prediction = model.predict(reduced_data)

            # Interpretar a previsão
            resultado = ['com diabetes' if pred == 1 else 'sem diabetes' for pred in prediction]
            return resultado

        # Verificar se a entrada é uma lista de listas ou uma única lista
        if isinstance(data, list):
            if all(isinstance(item, list) for item in data):
                # Múltiplos conjuntos de dados
                if not all(len(item) == len(FEATURE_NAMES) for item in data):
                    return jsonify({"error": f"Todos os conjuntos de entrada devem ter {len(FEATURE_NAMES)} valores numéricos."}), 400

                input_df = pd.DataFrame(data, columns=FEATURE_NAMES)
                resultados = process_prediction(input_df)
                return jsonify({"predictions": resultados}), 200

            else:
                # Único conjunto de dados
                if len(data) != len(FEATURE_NAMES):
                    return jsonify({"error": f"Dados de entrada inválidos. Deve ser uma lista com {len(FEATURE_NAMES)} valores numéricos."}), 400

                input_df = pd.DataFrame([data], columns=FEATURE_NAMES)
                resultado = process_prediction(input_df)[0]
                return jsonify({"prediction": resultado}), 200

        else:
            return jsonify({"error": "Formato de dados inválido. Envie uma lista ou uma lista de listas."}), 400

    except Exception as e:
        return jsonify({'error': str(e)}), 500

# Rota de teste para verificar se a API está funcionando
@app.route('/', methods=['GET'])
def home():
    return "API Diabetic Predictor está funcionando!"

#if __name__ == '__main__':
#    app.run(debug=False)
# Iniciar o servidor
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.getenv("FLASK_PORT", 8085)))