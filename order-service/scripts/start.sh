#!/bin/bash

[ -z "$JAVA_XMS" ] && JAVA_XMS=512m
[ -z "$JAVA_XMX" ] && JAVA_XMX=512m

# 스크립트 실행 위치 확인 및 경로 설정
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$SCRIPT_DIR"

# scripts 디렉토리에서 실행된 경우 상위 디렉토리로 이동
if [[ "$SCRIPT_DIR" == */scripts ]]; then
  PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
fi

set -e

 JAVA_OPTS="${JAVA_OPTS} \
   -Xms${JAVA_XMS} \
   -Xmx${JAVA_XMX} \
   -Dapplication.name=order-service-java \
   -Dotel.metrics.exporter=none \
   -Dotel.traces.exporter=otlp \
   -Dotel.resource.attributes=service.name=order-service-java \
   -Dotel.exporter.otlp.traces.endpoint=http://localhost:4317 \
   -Dotel.service.name=order-service-java \
   -Dotel.javaagent.debug=false \
   -javaagent:$PROJECT_ROOT/agents/opentelemetry-javaagent.jar"



exec java ${JAVA_OPTS} \
  -jar "$PROJECT_ROOT/target/order-service-0.0.1-SNAPSHOT.jar" \
