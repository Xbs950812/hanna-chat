#!/bin/bash

echo "=== 韩娜聊天助手 - GitHub推送工具 ==="
echo ""
echo "📦 仓库信息："
echo "   用户名: Xbs950812"
echo "   仓库名: hanna-chat"
echo "   地址: https://github.com/Xbs950812/hanna-chat"
echo ""

echo "✅ 远程仓库已配置："
git remote -v

echo ""
echo "=========================================="
echo "⚠️  推送需要GitHub认证"
echo "=========================================="
echo ""
echo "请选择认证方式："
echo ""
echo "1. 使用Personal Access Token（推荐）"
echo "2. 使用SSH密钥"
echo ""
read -p "请输入选择 (1/2): " choice

case $choice in
    1)
        echo ""
        echo "📝 创建Token步骤："
        echo "   1. 访问: https://github.com/settings/tokens"
        echo "   2. 点击 'Generate new token (classic)'"
        echo "   3. 勾选 'repo' 权限"
        echo "   4. 点击 'Generate token'"
        echo "   5. 复制Token（只显示一次！）"
        echo ""
        read -p "✅ 已创建Token并准备好？(按回车继续)..."
        echo ""
        echo "正在推送..."
        echo ""
        echo "当提示输入凭证时："
        echo "   Username: Xbs950812"
        echo "   Password: [粘贴你的Token]"
        echo ""
        git push -u origin main
        ;;
    2)
        echo ""
        echo "📝 切换到SSH方式..."
        git remote set-url origin git@github.com:Xbs950812/hanna-chat.git
        echo "✅ 已切换到SSH"
        echo ""
        echo "正在推送..."
        git push -u origin main
        ;;
    *)
        echo "❌ 无效选择"
        exit 1
        ;;
esac

if [ $? -eq 0 ]; then
    echo ""
    echo "=========================================="
    echo "✅ 推送成功！"
    echo "=========================================="
    echo ""
    echo "🌐 下一步：启用GitHub Pages"
    echo ""
    echo "1. 访问: https://github.com/Xbs950812/hanna-chat"
    echo "2. 点击 'Settings'"
    echo "3. 找到 'Pages'"
    echo "4. Branch选择 'main', Folder选择 '/'"
    echo "5. 点击 'Save'"
    echo ""
    echo "🎉 等待1-2分钟后访问:"
    echo "   https://Xbs950812.github.io/hanna-chat/"
    echo ""
else
    echo ""
    echo "=========================================="
    echo "❌ 推送失败"
    echo "=========================================="
    echo ""
    echo "请查看详细推送指南："
    echo "   assets/PUSH_TO_GITHUB.md"
    echo ""
fi
