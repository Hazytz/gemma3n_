from flask import Flask, request, jsonify
from ollama import chat

app = Flask(__name__)

@app.route("/chat", methods=["POST"])
def npc_chat():
    data = request.get_json(force=True)

    npc_context = data.get("context", "")
    user_prompt = data.get("prompt", "")

    response = chat(model='gemma3n:e2b', messages=[
        {"role": "system",  "content": npc_context},
        {"role": "user",    "content": user_prompt}
    ])

    try:
        reply = response.message.content.strip()
    except AttributeError:
        reply = response['message']['content'].strip()

    return jsonify({"reply": reply})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)