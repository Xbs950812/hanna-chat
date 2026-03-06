# 韩娜聊天前端界面使用指南

## 📱 功能特性

- ✅ **微信风格界面**：完美复刻微信聊天UI，包括消息气泡、头像、输入框等
- ✅ **响应式设计**：支持桌面端和移动端，自动适配不同屏幕尺寸
- ✅ **韩娜头像**：使用指定的清新温柔女性头像
- ✅ **消息动画**：打字指示器、消息气泡动画等微交互
- ✅ **自动滚动**：新消息自动滚动到底部
- ✅ **时间戳显示**：每条消息都显示发送时间

## 🚀 快速开始

### 1. 本地预览

```bash
# 启动HTTP服务器
cd /workspace/projects
python3 -m http.server 8080 --directory assets --bind 0.0.0.0

# 在浏览器中打开
http://localhost:8080/hanna_chat.html
```

### 2. 连接后端API

目前前端使用模拟回复，要连接到实际的LangChain Agent后端，需要修改 `generateResponse` 函数：

```javascript
// 将 generateResponse 函数替换为实际的API调用
async function generateResponse(userMessage) {
    try {
        const response = await fetch('http://your-backend-api/chat', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ message: userMessage })
        });

        const data = await response.json();
        return data.reply;
    } catch (error) {
        console.error('API调用失败:', error);
        return '抱歉，我现在无法回复。请稍后再试。';
    }
}
```

## 🎨 界面元素说明

### 顶部导航栏
- **返回按钮**：左上角的 "‹" 符号
- **标题**：显示"韩娜"
- **菜单图标**：右上角的 "⋮" 更多选项

### 消息区域
- **用户消息**：右侧绿色气泡
- **韩娜消息**：左侧白色气泡，带韩娜头像
- **时间戳**：消息上方显示发送时间

### 输入区域
- **语音按钮**：左上角的麦克风图标 🎤
- **输入框**：支持多行输入，自动调整高度
- **表情按钮**：表情图标 😊
- **加号按钮**：更多功能 ⊕
- **发送按钮**：点击发送消息

## 📝 后端API接口规范

如果需要连接后端，请遵循以下接口规范：

### 请求格式
```json
{
  "message": "用户输入的消息",
  "session_id": "会话ID（可选，用于记忆管理）"
}
```

### 响应格式
```json
{
  "reply": "韩娜的回复",
  "timestamp": "2024-01-01T12:00:00Z"
}
```

## 🎯 后续优化建议

### 1. 连接实际后端
- 创建后端API服务器（Flask/FastAPI）
- 将LangChain Agent封装为API接口
- 实现会话管理和记忆持久化

### 2. 增强功能
- **语音输入**：集成Web Speech API实现语音转文字
- **表情支持**：添加表情选择器
- **图片发送**：支持上传和发送图片
- **消息撤回**：长按消息显示撤回选项
- **分享功能**：分享对话记录

### 3. 性能优化
- 添加消息懒加载
- 实现消息搜索功能
- 添加对话历史记录

### 4. 用户体验
- 添加夜间模式
- 自定义主题色
- 消息音效
- 消息震动反馈

## 📱 移动端适配

前端已针对移动端优化：
- 触摸友好的按钮大小
- 适配移动端键盘弹出
- 防止页面缩放
- 流畅的滚动体验

## 🔧 自定义配置

### 修改头像
在HTML文件中找到以下两处，替换为你的头像URL：
```html
<!-- 韩娜头像 -->
<img src="https://code.coze.cn/api/sandbox/..." alt="韩娜">
```

### 修改颜色主题
在CSS中修改以下变量：
```css
/* 微信绿色 */
background-color: #95ec69;

/* 头部背景色 */
background-color: #ededed;

/* 文字颜色 */
color: #1aad19;
```

## 📄 文件结构

```
assets/
├── hanna_chat.html          # 主聊天界面文件
└── FRONTEND_README.md       # 本说明文档
```

## 🎉 完成！

前端界面已经创建完成，具备完整的微信聊天界面功能。你可以：
1. 在浏览器中打开 `hanna_chat.html` 查看效果
2. 根据需要修改样式和功能
3. 连接到你的LangChain Agent后端实现完整对话功能

如有问题，请随时联系！💪
