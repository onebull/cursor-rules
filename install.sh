#!/usr/bin/env bash
# 将本仓库的 .cursorrules 和 .cursor/ 安装到指定项目目录（默认当前目录）
# 用法: ./install.sh [目标项目路径]
# 例:   ./install.sh ~/my-app   或   ./install.sh .

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${1:-.}"

if [ -n "$1" ]; then
  TARGET="$(cd "$1" && pwd)"
else
  TARGET="$(pwd)"
fi

echo "规则仓库: $SCRIPT_DIR"
echo "目标项目: $TARGET"

# 复制 .cursorrules
cp "$SCRIPT_DIR/.cursorrules" "$TARGET/.cursorrules"
echo "  ✓ .cursorrules"

# 复制 .cursor 目录内容（递归合并，不删除已有文件）
if [ -d "$SCRIPT_DIR/.cursor" ]; then
  # 使用 rsync 递归复制（若可用），否则用 cp -r 逐项合并
  if command -v rsync &>/dev/null; then
    rsync -a --exclude='.gitkeep' "$SCRIPT_DIR/.cursor/" "$TARGET/.cursor/"
    echo "  ✓ .cursor/ (rsync)"
  else
    mkdir -p "$TARGET/.cursor"
    find "$SCRIPT_DIR/.cursor" -type f | while read -r src; do
      rel="${src#$SCRIPT_DIR/.cursor/}"
      dst="$TARGET/.cursor/$rel"
      mkdir -p "$(dirname "$dst")"
      cp "$src" "$dst"
      echo "  ✓ .cursor/$rel"
    done
  fi
fi

echo ""
echo "安装完成。在 Cursor 中打开目标项目即可自动加载规则。"
echo ""
echo "已安装文件："
echo "  .cursorrules                              ← 全局核心规则"
echo "  .cursor/agent-master-prompt.md            ← Ctrl+I Agent 执行模板"
echo "  .cursor/rules/memory-bank-workflow.mdx    ← Memory Bank 工作流"
echo "  .cursor/rules/agent-mcp-workflow.mdx      ← Agent MCP 自动选用"
echo "  .cursor/rules/docs-governance.mdx         ← 文档治理规范"
echo "  .cursor/rules/layered-rules-extension.mdx ← 分层规则扩展目录"
echo ""
echo "下一步（可选）："
echo "  1. 创建 .cursor/memory/ 目录与 activeContext.md、decisionLog.md、productContext.md"
echo "  2. 查看 .cursor/rules/layered-rules-extension.mdx，按需创建项目专属规则文件"
echo "  3. 在项目根创建 .cursorrules 的项目级扩展（project/.cursorrules）"
