#!/bin/bash

# 启动容器
docker-compose up -d

# 等待容器启动
echo "Waiting for the container to start..."
sleep 5

# 检查容器状态
if docker-compose ps | grep -q "Up"; then
    echo "Container is up, entering shell..."
    docker-compose exec env bash
else
    echo "Container failed to start."
fi