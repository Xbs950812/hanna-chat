#!/usr/bin/env python3
"""
启动韩娜聊天服务的简单脚本
"""
import os
import sys
import subprocess
import time
from http.server import HTTPServer, SimpleHTTPRequestHandler

# 切换到assets目录
os.chdir('/workspace/projects/assets')

# 启动HTTP服务器
print("=== 启动韩娜聊天服务 ===")
print()

# 停止旧的服务
try:
    subprocess.run(['pkill', '-f', 'python3 -m http.server'], check=False)
    subprocess.run(['pkill', '-f', 'lt --port'], check=False)
    time.sleep(1)
except:
    pass

# 启动HTTP服务器
print("启动HTTP服务器...")
httpd = HTTPServer(('0.0.0.0', 8080), SimpleHTTPRequestHandler)
print(f"✅ HTTP服务器已启动 (端口: 8080)")

# 启动ngrok隧道
print()
print("启动ngrok隧道...")
try:
    from pyngrok import ngrok

    # 连接ngrok（使用免费账户）
    tunnel = ngrok.connect(8080, proto='http', options={'bind_tls': True})

    print()
    print("🎉 服务启动成功！")
    print()
    print("=" * 60)
    print("🌐 公网访问地址（无需密码）：")
    print(f"   {tunnel.public_url}/hanna_chat.html")
    print("=" * 60)
    print()
    print("✅ 这个链接可以直接在浏览器中打开，无需密码！")
    print("✅ 支持电脑和手机访问！")
    print()
    print("提示：按 Ctrl+C 停止服务")
    print()

    # 保持服务运行
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        print()
        print("正在停止服务...")
        ngrok.disconnect(tunnel)
        httpd.shutdown()
        print("✅ 服务已停止")

except Exception as e:
    print(f"❌ 启动ngrok失败: {e}")
    print()
    print("本地访问地址：")
    print("   http://localhost:8080/hanna_chat.html")
    print()
    print("尝试在本地打开文件：")
    print("   /workspace/projects/assets/hanna_chat.html")
    httpd.serve_forever()
