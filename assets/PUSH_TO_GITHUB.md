# 🚀 推送代码到GitHub

## 📝 你的仓库信息

- **GitHub用户名**: Xbs950812
- **仓库名**: hanna-chat
- **仓库地址**: https://github.com/Xbs950812/hanna-chat
- **远程仓库**: ✅ 已配置

---

## 🔐 推送需要认证

由于使用HTTPS方式，需要提供GitHub凭证。

### 方法1：使用Personal Access Token（推荐）

#### 步骤1：创建GitHub Token

1. **登录GitHub**
   - 访问：https://github.com/Xbs950812
   - 点击右上角头像
   - 选择 "Settings"

2. **创建Token**
   - 在左侧边栏找到 "Developer settings"
   - 点击 "Personal access tokens"
   - 选择 "Tokens (classic)"
   - 点击 "Generate new token (classic)"

3. **配置Token**
   - Note: `hanna-chat-deploy`
   - Expiration: 选择 `90 days` 或 `No expiration`
   - 勾选权限：
     - ✅ `repo` (Full control of private repositories)
     - ✅ `workflow` (Update GitHub Action workflows)
   - 点击 "Generate token"

4. **复制Token**
   - **重要：立即复制并保存**
   - Token只显示一次！
   - 格式类似：`ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx`

---

#### 步骤2：推送代码

**在终端中执行：**

```bash
cd /workspace/projects
git push -u origin main
```

**当提示输入用户名和密码时：**

- **Username**: 输入你的GitHub用户名 `Xbs950812`
- **Password**: 粘贴刚才创建的Token（不是GitHub密码！）

**示例：**
```bash
Username for 'https://github.com': Xbs950812
Password for 'https://Xbs950812@github.com': ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

---

### 方法2：使用SSH密钥（如果你已经配置）

```bash
# 修改远程仓库地址为SSH
cd /workspace/projects
git remote set-url origin git@github.com:Xbs950812/hanna-chat.git

# 推送代码
git push -u origin main
```

---

### 方法3：配置Git凭证存储

**一次性配置：**

```bash
# 配置凭证存储
git config --global credential.helper store

# 推送（会提示输入一次，之后会自动记住）
git push -u origin main
```

---

## ✅ 推送成功后

你会看到类似这样的输出：

```
Enumerating objects: 85, done.
Counting objects: 100% (85/85), done.
Delta compression using up to 8 threads
Compressing objects: 100% (75/75), done.
Writing objects: 100% (85/85), 345.67 KiB | 5.23 MiB/s, done.
Total 85 (delta 20), reused 0 (delta 0), pack-reused 0
To https://github.com/Xbs950812/hanna-chat.git
 * [new branch]      main -> main
branch 'main' set up to track 'origin/main'.
```

---

## 🌐 启用GitHub Pages

推送成功后：

1. **打开仓库**
   - 访问：https://github.com/Xbs950812/hanna-chat

2. **进入Settings**
   - 点击仓库顶部的 "Settings" 标签

3. **启用Pages**
   - 在左侧边栏找到 "Pages"
   - 在 "Source" 下选择：
     - **Branch**: `main`
     - **Folder**: `/` (root)
   - 点击 "Save"

4. **等待部署**
   - 通常需要1-2分钟
   - 你会看到：`Your site is live at: https://...`

---

## 🎯 访问你的网站

部署成功后，访问：

```
https://Xbs950812.github.io/hanna-chat/
```

---

## 📱 测试

1. **电脑访问**
   - 打开浏览器
   - 访问：https://Xbs950812.github.io/hanna-chat/

2. **手机访问**
   - 在手机浏览器中输入相同地址
   - 应该能直接打开

---

## 💡 提示

1. **Token安全**
   - 不要分享Token
   - 定期更新Token
   - 使用完后可以删除

2. **推送更新**
   - 修改代码后：
   ```bash
   git add .
   git commit -m "更新内容"
   git push
   ```

3. **查看部署状态**
   - 访问仓库的 "Actions" 标签
   - 可以看到部署进度

---

## ❓ 常见问题

### Q: 忘记了Token怎么办？
A: 重新创建一个Token，旧的无法找回。

### Q: 推送时提示认证失败？
A:
- 检查Token是否正确复制
- 确认Token有 `repo` 权限
- 重新创建Token

### Q: GitHub Pages部署失败？
A:
- 检查仓库是否为Public（免费版需要公开仓库）
- 等待更长时间
- 查看Actions日志

---

**现在就去创建Token并推送代码吧！** 🚀
