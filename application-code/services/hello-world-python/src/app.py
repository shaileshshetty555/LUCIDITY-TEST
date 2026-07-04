from flask import Flask, jsonify
from prometheus_flask_exporter import PrometheusMetrics


def create_app() -> Flask:
    app = Flask(__name__)
    PrometheusMetrics(app)

    @app.get("/")
    def hello_world():
        return "Hello World", 200

    @app.get("/healthz")
    def healthz():
        return jsonify(status="ok"), 200

    return app


app = create_app()
