#!/usr/bin/env python3
"""
简单的HTTP代理服务器，自动绕过localtunnel验证
"""
import http.server
import socketserver
import requests
import urllib.parse

PORT = 8080

class ProxyHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        # 获取隧道密码
        if self.path == '/tunnel-password':
            password = requests.get('https://loca.lt/mytunnelpassword').text.strip()
            self.send_response(200)
            self.send_header('Content-Type', 'text/plain')
            self.end_headers()
            self.wfile.write(password.encode())
            return

        # 对于其他请求，正常处理
        return super().do_GET()

if __name__ == "__main__":
    with socketserver.TCPServer(("", PORT), ProxyHTTPRequestHandler) as httpd:
        print(f"服务器运行在端口 {PORT}")
        print("隧道密码端点: http://localhost:8080/tunnel-password")
        httpd.serve_forever()
