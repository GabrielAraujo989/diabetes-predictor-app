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
        # Verificar o formato da entrada
        data = request.get_json()
        if not isinstance(data, list) or len(data) != len(FEATURE_NAMES):
            return jsonify({"error": f"Dados de entrada inválidos. Deve ser uma lista com {len(FEATURE_NAMES)} valores numéricos."}), 400

        # Converter para DataFrame
        input_df = pd.DataFrame([data], columns=FEATURE_NAMES)

        # Aplicar padronização e PCA
        scaled_data = scaler.transform(input_df)
        reduced_data = pca.transform(scaled_data)

        # Fazer a predição
        prediction = model.predict(reduced_data)[0]

        # Converter o resultado para uma mensagem legível
        result = "com diabetes" if prediction == 1 else "sem diabetes"

        return jsonify({"prediction": result}), 200

    except Exception as e:
        return jsonify({"error": f"Erro ao processar a solicitação: {e}"}), 500

# Iniciar o servidor
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.getenv("FLASK_PORT", 8085)))