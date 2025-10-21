from flask import Flask, jsonify, request
from prometheus_client import Counter, generate_latest, CollectorRegistry, CONTENT_TYPE_LATEST, start_http_server

app = Flask(__name__)
requests_total = Counter('accounts_requests_total', 'Total Accounts Requests')

@app.route("/")
def home():
    requests_total.inc()
    return jsonify({"service":"accounts","status":"ok"})

@app.route("/accounts/<id>")
def account(id):
    requests_total.inc()
    # simulate DB read
    return jsonify({"id": id, "balance": 1000})

@app.route("/metrics")
def metrics():
    return generate_latest(), 200, {'Content-Type': CONTENT_TYPE_LATEST}

if __name__ == "__main__":
    # optional: expose metrics on different port if needed
    app.run(host="0.0.0.0", port=5000)

    
