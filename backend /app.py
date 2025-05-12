#health_llm_flask_api.py

from flask import Flask, request, jsonify
from transformers import AutoTokenizer, AutoModelForCausalLM
import torch

#Load the model and tokenizer at startup
model_name = "gpt2"
tokenizer = AutoTokenizer.from_pretrained(model_name)
model = AutoModelForCausalLM.from_pretrained(model_name)

#Move to GPU if available (optional)
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
model.to(device)

#Create Flask app
app = Flask(__name__)

@app.route('/generate', methods=['POST'])
def generate():
    data = request.json
    prompt = data.get("prompt", "")
    max_length = data.get("max_length", 50)

    #Encode input and generate
    inputs = tokenizer(prompt, return_tensors="pt").to(device)
    outputs = model.generate(**inputs, max_length=max_length)

    text = tokenizer.decode(outputs[0], skip_special_tokens=True)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)
