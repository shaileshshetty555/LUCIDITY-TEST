from src.app import create_app


def test_hello_world_endpoint():
    app = create_app()
    client = app.test_client()

    response = client.get("/")

    assert response.status_code == 200
    assert response.get_data(as_text=True) == "Hello World"


def test_healthz_endpoint():
    app = create_app()
    client = app.test_client()

    response = client.get("/healthz")

    assert response.status_code == 200
    assert response.get_json() == {"status": "ok"}


def test_metrics_endpoint():
    app = create_app()
    client = app.test_client()

    response = client.get("/metrics")

    assert response.status_code == 200
    assert "python_info" in response.get_data(as_text=True)
