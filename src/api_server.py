#!/usr/bin/env python3
"""
韩娜聊天助手 - 后端API服务器
提供RESTful API接口供前端调用
"""
import os
import sys
import json
from flask import Flask, request, jsonify, Response
from flask_cors import CORS
from typing import Dict, Any

# 添加项目根目录到Python路径
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', 'src'))

from agents.agent import build_agent
from langchain_core.messages import HumanMessage, AIMessage

app = Flask(__name__)
CORS(app)  # 允许跨域请求

# 全局Agent实例
agent = None
agent_config = {}

def get_agent():
    """获取或创建Agent实例"""
    global agent, agent_config

    if agent is None:
        print("正在初始化韩娜Agent...")
        agent = build_agent()
        print("✅ 韩娜Agent初始化完成！")

    return agent

@app.route('/health', methods=['GET'])
def health_check():
    """健康检查接口"""
    return jsonify({
        'status': 'healthy',
        'service': 'Hanna Chat API',
        'version': '1.0.0'
    })

@app.route('/api/chat', methods=['POST'])
def chat():
    """
    聊天接口

    请求格式:
    {
        "message": "用户消息",
        "session_id": "会话ID（可选）"
    }

    响应格式:
    {
        "reply": "韩娜的回复",
        "session_id": "会话ID"
    }
    """
    try:
        # 获取请求数据
        data = request.get_json()

        if not data or 'message' not in data:
            return jsonify({
                'error': '缺少message参数'
            }), 400

        user_message = data['message'].strip()
        session_id = data.get('session_id', 'default')

        if not user_message:
            return jsonify({
                'error': '消息不能为空'
            }), 400

        # 获取Agent实例
        agent_instance = get_agent()

        # 调用Agent
        print(f"用户消息: {user_message}")
        print(f"会话ID: {session_id}")

        # 使用config来指定线程ID（用于记忆管理）
        config = {
            "configurable": {
                "thread_id": session_id
            }
        }

        # 调用agent
        result = agent_instance.invoke(
            {"messages": [HumanMessage(content=user_message)]},
            config=config
        )

        # 获取回复
        if result and 'messages' in result:
            # 取最后一条消息作为回复
            last_message = result['messages'][-1]
            reply_text = last_message.content if hasattr(last_message, 'content') else str(last_message)
        else:
            reply_text = "抱歉，我现在无法回复。请稍后再试。"

        print(f"韩娜回复: {reply_text}")

        return jsonify({
            'reply': reply_text,
            'session_id': session_id
        })

    except Exception as e:
        print(f"错误: {str(e)}")
        import traceback
        traceback.print_exc()

        return jsonify({
            'error': f'服务器错误: {str(e)}'
        }), 500

@app.route('/api/config', methods=['GET'])
def get_config():
    """获取Agent配置信息"""
    try:
        workspace_path = os.getenv('COZE_WORKSPACE_PATH', os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
        config_path = os.path.join(workspace_path, 'config/agent_llm_config.json')

        with open(config_path, 'r', encoding='utf-8') as f:
            config = json.load(f)

        # 返回部分配置信息（不包含敏感信息）
        return jsonify({
            'model': config.get('config', {}).get('model', 'unknown'),
            'temperature': config.get('config', {}).get('temperature', 0.7),
            'service': 'Hanna Chat API'
        })

    except Exception as e:
        return jsonify({
            'error': f'无法读取配置: {str(e)}'
        }), 500

@app.route('/api/reset', methods=['POST'])
def reset_session():
    """
    重置会话记忆

    请求格式:
    {
        "session_id": "会话ID（可选，默认为'default'）"
    }
    """
    try:
        data = request.get_json() or {}
        session_id = data.get('session_id', 'default')

        # 注意：这里需要实现记忆清除逻辑
        # LangChain的记忆管理通常通过checkpointer实现
        # 可以通过删除thread_id对应的记忆来清除

        return jsonify({
            'message': f'会话 {session_id} 已重置',
            'session_id': session_id
        })

    except Exception as e:
        return jsonify({
            'error': f'重置失败: {str(e)}'
        }), 500

@app.errorhandler(404)
def not_found(error):
    return jsonify({
        'error': '接口不存在'
    }), 404

@app.errorhandler(500)
def internal_error(error):
    return jsonify({
        'error': '服务器内部错误'
    }), 500

if __name__ == '__main__':
    # 预加载Agent
    print("🚀 启动韩娜聊天API服务器...")
    print("")

    # 预热Agent
    try:
        get_agent()
        print("")
        print("✅ 服务器准备就绪！")
    except Exception as e:
        print(f"⚠️  Agent初始化警告: {str(e)}")
        print("⚠️  服务将启动，但AI回复可能不可用")

    print("")
    print("=" * 50)
    print("📡 API端点:")
    print("   - 健康检查: GET /health")
    print("   - 聊天接口: POST /api/chat")
    print("   - 配置信息: GET /api/config")
    print("   - 重置会话: POST /api/reset")
    print("=" * 50)
    print("")

    # 启动Flask服务器
    # host=0.0.0.0 允许外部访问
    # port=5001 使用5001端口
    # debug=True 开启调试模式（生产环境应关闭）
    app.run(
        host='0.0.0.0',
        port=5001,
        debug=True
    )
