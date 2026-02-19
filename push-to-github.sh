#!/usr/bin/env bash
# 在 GitHub 网页创建好空仓库后，用本脚本推送并设置上游
# 用法: ./push-to-github.sh https://github.com/你的用户名/cursor-rules
# 或:   ./push-to-github.sh git@github.com:你的用户名/cursor-rules.git

set -e
REPO_URL="${1:?请传入仓库地址，例如: https://github.com/你的用户名/cursor-rules}"

cd "$(dirname "${BASH_SOURCE[0]}")"

# 若 .git 不存在则先 init
if [ ! -d .git ]; then
  git init
  git branch -M main 2>/dev/null || true
fi

# 统一转成可 push 的地址（HTTPS 形式便于展示）
if [[ "$REPO_URL" == *.git ]]; then
  REPO_URL="${REPO_URL%.git}"
fi
REMOTE_URL="$REPO_URL.git"

# 添加或更新 origin
if git remote get-url origin &>/dev/null; then
  git remote set-url origin "$REMOTE_URL"
else
  git remote add origin "$REMOTE_URL"
fi

# 默认分支尽量用 main（与 GitHub 新建仓一致）
git branch -M main 2>/dev/null || true
git add -A
# 有未提交更改或尚无提交时执行一次提交
(git diff --cached --quiet 2>/dev/null && git rev-parse HEAD &>/dev/null) || git commit -m "Initial: Cursor rules and install script"
git push -u origin main 2>/dev/null || git push -u origin master 2>/dev/null || git push -u origin HEAD

echo ""
echo "已推送。展示地址（可直接分享、用于 install）："
echo "  $REPO_URL"
echo ""
