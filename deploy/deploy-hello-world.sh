#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
APP_DIR="$ROOT_DIR/application-code/services/hello-world-python"
CHART_DIR="$ROOT_DIR/application-helm-charts/hello-world"

AWS_REGION="${AWS_REGION:-us-east-1}"
IMAGE_TAG="${IMAGE_TAG:-1.0.0}"
ENVIRONMENT="${ENVIRONMENT:-dev}"

case "$ENVIRONMENT" in
  dev|staging|prod) ;;
  *)
    echo "ENVIRONMENT must be one of: dev, staging, prod"
    exit 1
    ;;
esac

VALUES_FILE="$CHART_DIR/values-${ENVIRONMENT}.yaml"
RELEASE_NAME="hello-world-${ENVIRONMENT}"
NAMESPACE="hello-world-${ENVIRONMENT}"
REPO_NAME="hello-world-python"

ACCOUNT_ID="$(aws sts get-caller-identity --query Account --output text)"
IMAGE_REPO="$ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPO_NAME"

aws ecr create-repository --repository-name "$REPO_NAME" --region "$AWS_REGION" >/dev/null 2>&1 || true

aws ecr get-login-password --region "$AWS_REGION" \
  | docker login --username AWS --password-stdin "$ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com"

docker build -t "$REPO_NAME:$IMAGE_TAG" "$APP_DIR"
docker tag "$REPO_NAME:$IMAGE_TAG" "$IMAGE_REPO:$IMAGE_TAG"
docker push "$IMAGE_REPO:$IMAGE_TAG"

helm upgrade --install "$RELEASE_NAME" "$CHART_DIR" \
  --namespace "$NAMESPACE" --create-namespace \
  -f "$CHART_DIR/values.yaml" \
  -f "$VALUES_FILE" \
  --set image.repository="$IMAGE_REPO" \
  --set image.tag="$IMAGE_TAG" \
  --wait --timeout 10m

DEPLOYMENT_NAME="$(kubectl get deploy -n "$NAMESPACE" -l app.kubernetes.io/instance="$RELEASE_NAME" -o jsonpath='{.items[0].metadata.name}')"
if [[ -z "$DEPLOYMENT_NAME" ]]; then
  echo "Unable to determine deployment name for release $RELEASE_NAME in namespace $NAMESPACE"
  exit 1
fi

kubectl rollout status deployment/"$DEPLOYMENT_NAME" -n "$NAMESPACE" --timeout=5m

echo "Deployment completed."
echo "Release: $RELEASE_NAME"
echo "Namespace: $NAMESPACE"
echo "Image: $IMAGE_REPO:$IMAGE_TAG"
echo "To test locally: kubectl port-forward -n $NAMESPACE svc/$DEPLOYMENT_NAME 8080:80"
