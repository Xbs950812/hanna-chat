# 🎯 韩娜聊天助手 - 快速启动指南

## 🚀 快速开始

### 方式1：本地完整运行（推荐）

```bash
# 启动所有服务（API + 前端）
/workspace/projects/scripts/start_all.sh
```

然后访问：
- 前端界面：http://localhost:8080/hanna_chat.html
- API健康检查：http://localhost:5001/health

### 方式2：GitHub Pages + 本地API

```bash
# 只启动API服务器
cd /workspace/projects
python3 src/api_server.py
```

然后访问GitHub Pages：
- 前端界面：https://Xbs950812.github.io/hanna-chat/assets/hanna_chat.html

**注意**：需要修改前端HTML中的API_URL为你的API服务器地址。

### 方式3：只启动前端（离线模式）

```bash
cd /workspace/projects/assets
python3 -m http.server 8080
```

访问：http://localhost:8080/hanna_chat.html

**注意**：此模式下使用模拟回复。

---

## 📡 API服务器

### 启动
```bash
cd /workspace/projects
python3 src/api_server.py
```

### 测试
```bash
# 健康检查
curl http://localhost:5001/health

# 聊天测试
curl -X POST http://localhost:5001/api/chat \
  -H "Content-Type: application/json" \
  -d '{"message": "你好，韩娜！"}'
```

### API端点
- `GET /health` - 健康检查
- `POST /api/chat` - 聊天接口
- `GET /api/config` - 配置信息
- `POST /api/reset` - 重置会话

---

## 🌐 前端界面

### 本地访问
```
http://localhost:8080/hanna_chat.html
```

### GitHub Pages访问
```
https://Xbs950812.github.io/hanna-chat/assets/hanna_chat.html
```

---

## 🔧 停止服务

```bash
# 停止所有服务
/workspace/projects/scripts/stop_all.sh

# 或手动停止
pkill -f api_server.py
pkill -f "python3 -m http.server"
```

---

## 📝 日志

- API日志：`tail -f /tmp/api_server.log`
- HTTP日志：`tail -f /tmp/http_server.log`

---

## 🎉 测试

打开前端界面，发送消息：
- "你好"
- "什么是夫妻肺片？"
- "推荐一些中国美食"

韩娜会智能回复！✨
