#!/bin/bash

# 停止韩娜聊天助手的所有服务

echo "🛑 停止韩娜聊天助手..."
echo ""

# 停止API服务器
echo "停止API服务器..."
pkill -f "python3.*api_server.py"
echo "✅ API服务器已停止"

# 停止HTTP服务器
echo "停止前端HTTP服务器..."
pkill -f "python3 -m http.server.*8080"
echo "✅ HTTP服务器已停止"

# 停止ngrok隧道（如果有）
echo "停止ngrok隧道..."
pkill -f ngrok
echo "✅ ngrok隧道已停止"

echo ""
echo "✅ 所有服务已停止！"
echo ""
