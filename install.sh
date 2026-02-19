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
echo "  - 已写入 $TARGET/.cursorrules"

# 复制 .cursor 目录内容（不覆盖已有 .cursor，只合并）
mkdir -p "$TARGET/.cursor"
if [ -d "$SCRIPT_DIR/.cursor" ]; then
  for f in "$SCRIPT_DIR/.cursor"/*; do
    [ -e "$f" ] || continue
    name=$(basename "$f")
    cp "$f" "$TARGET/.cursor/$name"
    echo "  - 已写入 $TARGET/.cursor/$name"
  done
fi

echo "安装完成。在 Cursor 中打开目标项目即可自动加载规则。"
