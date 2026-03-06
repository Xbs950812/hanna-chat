#!/bin/bash

# 启动韩娜聊天API服务器

echo "🚀 启动韩娜聊天API服务器..."
echo ""

# 停止旧的服务
pkill -f "python3.*api_server.py" 2>/dev/null
sleep 1

# 切换到项目根目录
cd /workspace/projects

# 启动API服务器
echo "启动API服务器（端口5000）..."
python3 src/api_server.py > /tmp/api_server.log 2>&1 &
API_PID=$!

echo "API服务器已启动 (PID: $API_PID)"
echo ""

# 等待服务器启动
sleep 3

# 检查服务状态
if ps -p $API_PID > /dev/null; then
    echo "✅ API服务器运行正常"
    echo ""
    echo "📡 API端点:"
    echo "   - 健康检查: http://localhost:5000/health"
    echo "   - 聊天接口: http://localhost:5000/api/chat"
    echo ""
    echo "📝 日志文件: /tmp/api_server.log"
    echo ""
    echo "🔍 查看日志:"
    echo "   tail -f /tmp/api_server.log"
    echo ""
    echo "⚠️  注意："
    echo "   - 服务器运行在后台"
    echo "   - 使用 'pkill -f api_server.py' 停止服务"
    echo "   - 前端HTML中的API_URL需要指向 http://localhost:5000"
else
    echo "❌ API服务器启动失败"
    echo ""
    echo "查看错误日志:"
    cat /tmp/api_server.log
    exit 1
fi
