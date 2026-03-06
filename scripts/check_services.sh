#!/bin/bash

# 检查服务状态脚本

echo "=== 服务状态检查 ==="
echo ""

# 检查HTTP服务器
HTTP_PID=$(pgrep -f "python3 -m http.server 8080")
if [ -n "$HTTP_PID" ]; then
    echo "✅ HTTP服务器运行中 (PID: $HTTP_PID)"
else
    echo "❌ HTTP服务器未运行"
    echo "   启动中..."
    cd /workspace/projects && python3 -m http.server 8080 --directory assets --bind 0.0.0.0 > /tmp/server.log 2>&1 &
    sleep 2
    echo "   ✅ HTTP服务器已启动"
fi

# 检查隧道服务
TUNNEL_PID=$(pgrep -f "lt --port 8080")
if [ -n "$TUNNEL_PID" ]; then
    echo "✅ 隧道服务运行中 (PID: $TUNNEL_PID)"
else
    echo "❌ 隧道服务未运行"
    echo "   启动中..."
    lt --port 8080 --subdomain hanna-chat-test > /tmp/tunnel.log 2>&1 &
    sleep 5
    echo "   ✅ 隧道服务已启动"
fi

# 测试访问
echo ""
echo "=== 访问测试 ==="
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/hanna_chat.html)
echo "本地访问: http://localhost:8080/hanna_chat.html - $HTTP_CODE"

TUNNEL_CODE=$(curl -s -o /dev/null -w "%{http_code}" https://hanna-chat-test.loca.lt/hanna_chat.html)
echo "公网访问: https://hanna-chat-test.loca.lt/hanna_chat.html - $TUNNEL_CODE"

echo ""
echo "=== 服务信息 ==="
cat /tmp/tunnel.log 2>/dev/null | grep "your url" || echo "隧道地址获取中..."
echo ""
echo "✅ 所有服务检查完成！"
