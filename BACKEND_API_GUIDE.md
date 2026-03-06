# 🚀 后端API使用指南

## ✅ API服务器已部署！

韩娜聊天助手的后端API服务器已经创建并成功运行！

---

## 📡 API端点

### 基础信息
- **服务器地址**：`http://localhost:5001`
- **服务状态**：✅ 运行中
- **Agent状态**：✅ 已初始化

### 可用接口

#### 1. 健康检查
```
GET /health
```

**响应示例：**
```json
{
  "status": "healthy",
  "service": "Hanna Chat API",
  "version": "1.0.0"
}
```

---

#### 2. 聊天接口
```
POST /api/chat
```

**请求格式：**
```json
{
  "message": "用户消息",
  "session_id": "会话ID（可选，默认为'default'）"
}
```

**响应示例：**
```json
{
  "reply": "韩娜的回复内容",
  "session_id": "default"
}
```

**测试命令：**
```bash
curl -X POST http://localhost:5001/api/chat \
  -H "Content-Type: application/json" \
  -d '{"message": "你好，韩娜！"}'
```

---

#### 3. 配置信息
```
GET /api/config
```

**响应示例：**
```json
{
  "model": "deepseek-v3-2-251201",
  "temperature": 0.5,
  "service": "Hanna Chat API"
}
```

---

#### 4. 重置会话
```
POST /api/reset
```

**请求格式：**
```json
{
  "session_id": "default"
}
```

---

## 🎯 如何使用

### 方式1：前端自动调用

前端HTML文件已经配置好，会自动调用API：

1. **启动API服务器**（见下方）
2. **打开前端页面**：`https://Xbs950812.github.io/hanna-chat/assets/hanna_chat.html`
3. **发送消息**，韩娜会真实回复！

---

### 方式2：手动测试

#### 测试健康检查：
```bash
curl http://localhost:5001/health
```

#### 测试聊天功能：
```bash
curl -X POST http://localhost:5001/api/chat \
  -H "Content-Type: application/json" \
  -d '{"message": "推荐一些中国美食"}'
```

---

## 🚀 启动API服务器

### 在本地启动

```bash
cd /workspace/projects
python3 src/api_server.py
```

或使用启动脚本：
```bash
/workspace/projects/scripts/start_api.sh
```

### 服务器信息
- **端口**：5001
- **地址**：http://localhost:5001
- **调试模式**：已启用
- **日志文件**：/tmp/api_server.log

---

## 🔄 前端配置

前端HTML中的API地址已配置为：
```javascript
const API_URL = 'http://localhost:5001/api/chat';
```

**注意事项：**
- 如果API服务器地址不同，需要修改这个URL
- 确保API服务器正在运行
- 确保浏览器能访问到该地址

---

## 📱 完整使用流程

### 第1步：启动API服务器

在容器中执行：
```bash
cd /workspace/projects
python3 src/api_server.py
```

### 第2步：打开前端界面

在浏览器中打开：
```
https://Xbs950812.github.io/hanna-chat/assets/hanna_chat.html
```

### 第3步：开始聊天

发送消息，韩娜会实时回复！

**示例对话：**
- 你："你好"
- 韩娜："你好呀！😊 很高兴认识你～"

- 你："什么是夫妻肺片？"
- 韩娜："夫妻肺片是一道经典川菜，其实里面没有夫妻也没有肺片！它是用牛肉、牛舌等配菜，配上麻辣红油做成的凉菜..."

---

## ⚠️ 常见问题

### Q1: 前端显示"无法连接到服务器"

**原因：** API服务器未启动

**解决：**
```bash
# 检查API服务器是否运行
ps aux | grep api_server.py

# 如果没有运行，启动它
cd /workspace/projects
python3 src/api_server.py
```

---

### Q2: API返回500错误

**原因：** Agent初始化失败

**解决：**
查看日志：
```bash
tail -f /tmp/api_server.log
```

常见问题：
- 模型配置错误
- API Key未设置
- 网络问题

---

### Q3: 跨域问题

**原因：** 前端和后端在不同域

**解决：**
已启用CORS，应该不会有跨域问题。如果还有问题，检查：
```python
from flask_cors import CORS
CORS(app)  # 确保这行代码存在
```

---

## 🔧 部署到生产环境

如果需要部署到生产环境，建议使用：

### Gunicorn（推荐）
```bash
pip install gunicorn
gunicorn -w 4 -b 0.0.0.0:5001 src.api_server:app
```

### 或使用Nginx反向代理

---

## 📊 性能优化

### 已实现
- ✅ Agent单例模式（避免重复初始化）
- ✅ 会话记忆管理
- ✅ 错误处理

### 可优化
- ⏳ 添加缓存
- ⏳ 使用Redis存储会话
- ⏳ 添加请求限流
- ⏳ 使用更快的WSGI服务器

---

## 📝 API文档

### 请求格式

**Header:**
```
Content-Type: application/json
```

**Body:**
```json
{
  "message": "string (required)",
  "session_id": "string (optional, default: 'default')"
}
```

### 响应格式

**成功：**
```json
{
  "reply": "string",
  "session_id": "string"
}
```

**错误：**
```json
{
  "error": "string"
}
```

---

## 🎉 完成！

现在你有一个完整的全栈聊天应用：
- ✅ 前端：微信风格界面
- ✅ 后端：LangChain Agent API
- ✅ 数据：会话记忆管理
- ✅ 部署：GitHub Pages

**立即开始测试吧！** 🚀
