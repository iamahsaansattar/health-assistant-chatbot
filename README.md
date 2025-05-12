# Health Assistant LLM Flutter App with Flask API

This project is a Flutter application that communicates with a Flask-based backend to interact with a large language model (LLM). 

## Backend Setup (Flask API)
1. Clone the repository:
    ```bash
    git clone https://github.com/username/flutter_llm_app.git
    cd flutter_llm_app/backend
    ```

2. Install dependencies:
    ```bash
    pip install -r requirements.txt
    ```

3. Run the Flask API:
    ```bash
    python app.py
    ```

## Frontend Setup (Flutter App)
1. Clone the repository:
    ```bash
    git clone https://github.com/username/flutter_llm_app.git
    cd flutter_llm_app/frontend
    ```

2. Install dependencies:
    ```bash
    flutter pub get
    ```

3. Run the app:
    ```bash
    flutter run
    ```

## Communication
The Flutter app sends POST requests to the Flask API at `http://127.0.0.1:8000/generate` with a prompt to generate text using the LLM.
