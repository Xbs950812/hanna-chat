#!/bin/bash

# 启动带ngrok的HTTP服务器

echo "=== 启动韩娜聊天服务 ==="
echo ""

# 停止旧的服务
pkill -f "python3 -m http.server" 2>/dev/null
pkill -f "lt --port" 2>/dev/null
sleep 1

# 启动HTTP服务器
echo "启动HTTP服务器..."
cd /workspace/projects/assets
python3 -m http.server 8080 --bind 0.0.0.0 > /tmp/http_server.log 2>&1 &
HTTP_PID=$!
echo "HTTP服务器已启动 (PID: $HTTP_PID)"
sleep 2

# 测试HTTP服务器
if curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/hanna_chat.html | grep -q "200"; then
    echo "✅ HTTP服务器运行正常"
else
    echo "❌ HTTP服务器启动失败"
    exit 1
fi

# 启动ngrok
echo ""
echo "启动ngrok隧道..."
python3 <<'EOF'
from pyngrok import ngrok
import time

# 打开ngrok隧道
public_url = ngrok.connect(8080)
print(f"✅ ngrok隧道已创建")
print(f"")
print(f"🌐 公网访问地址：")
print(f"   {public_url}/hanna_chat.html")
print(f"")
print(f"这个链接不需要密码，可以直接访问！")
print(f"")
print(f"提示：按 Ctrl+C 停止服务")

try:
    # 保持运行
    while True:
        time.sleep(1)
except KeyboardInterrupt:
    print("\n正在停止服务...")
    ngrok.disconnect(public_url)
    print("✅ 服务已停止")
EOF

echo ""
echo "服务已停止"
