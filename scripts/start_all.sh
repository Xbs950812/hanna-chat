#!/bin/bash

# 韩娜聊天助手 - 完整启动脚本
# 同时启动API服务器和前端HTTP服务器

echo "🚀 启动韩娜聊天助手..."
echo ""

# 停止旧的服务
echo "停止旧服务..."
pkill -f "python3.*api_server.py" 2>/dev/null
pkill -f "python3 -m http.server.*8080" 2>/dev/null
sleep 2

# 切换到项目根目录
cd /workspace/projects

# 启动API服务器（端口5001）
echo ""
echo "📡 启动API服务器（端口5001）..."
python3 src/api_server.py > /tmp/api_server.log 2>&1 &
API_PID=$!

# 等待API服务器启动
sleep 3

if ps -p $API_PID > /dev/null; then
    echo "✅ API服务器启动成功 (PID: $API_PID)"
else
    echo "❌ API服务器启动失败"
    echo "查看日志: tail -f /tmp/api_server.log"
    exit 1
fi

# 启动前端HTTP服务器（端口8080）
echo ""
echo "🌐 启动前端服务器（端口8080）..."
cd assets
python3 -m http.server 8080 --bind 0.0.0.0 > /tmp/http_server.log 2>&1 &
HTTP_PID=$!

# 等待HTTP服务器启动
sleep 2

if ps -p $HTTP_PID > /dev/null; then
    echo "✅ 前端服务器启动成功 (PID: $HTTP_PID)"
else
    echo "❌ 前端服务器启动失败"
    exit 1
fi

# 回到项目根目录
cd /workspace/projects

echo ""
echo "=================================================="
echo "✅ 所有服务已启动！"
echo "=================================================="
echo ""
echo "📡 API服务器:"
echo "   - 地址: http://localhost:5001"
echo "   - 健康检查: http://localhost:5001/health"
echo "   - 聊天接口: http://localhost:5001/api/chat"
echo ""
echo "🌐 前端界面:"
echo "   - 本地访问: http://localhost:8080/hanna_chat.html"
echo "   - GitHub访问: https://Xbs950812.github.io/hanna-chat/assets/hanna_chat.html"
echo ""
echo "📝 日志文件:"
echo "   - API日志: tail -f /tmp/api_server.log"
echo "   - HTTP日志: tail -f /tmp/http_server.log"
echo ""
echo "⚠️  注意事项:"
echo "   - 服务器运行在后台"
echo "   - 使用 'pkill -f api_server.py' 停止API服务器"
echo "   - 使用 'pkill -f http.server' 停止HTTP服务器"
echo "   - 或使用 'scripts/stop_all.sh' 停止所有服务"
echo ""
echo "=================================================="
echo ""
echo "🎉 现在可以开始使用韩娜聊天助手了！"
echo ""
