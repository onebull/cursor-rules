# 创建仓库并上传（拿到展示地址）

按下面做一次，即可在 GitHub 上拥有一个**免费规则仓库**，并得到可分享的**展示地址**；其它机器或他人也可基于该地址查看、克隆、完善规则。

---

## 第一步：在 GitHub 上创建空仓库

1. 打开：**https://github.com/new**
2. **Repository name**：填 `cursor-rules`（或你喜欢的名字）。
3. **Public**，不要勾选 “Add a README” / “Add .gitignore”（保持空仓）。
4. 点 **Create repository**。
5. 页面上会显示仓库地址，例如：`https://github.com/你的用户名/cursor-rules`  
   → 这就是你的**展示地址**，先复制下来。

---

## 第二步：在本机推送当前目录

在**本机**打开终端，进入本规则目录，执行（把下面的地址换成你在第一步拿到的地址）：

```bash
cd /home/ubuntu/cursor-rules
chmod +x push-to-github.sh install.sh
./push-to-github.sh https://github.com/你的用户名/cursor-rules
```

**若从未配置过 Git 用户信息，必须先执行一次**（否则无法 commit/push）：

```bash
git config --global user.email "你的邮箱@example.com"
git config --global user.name "你的名字"
```

推送成功后，脚本会再次打印**展示地址**。

---

## 展示地址用来做什么？

| 用途 | 用法 |
|------|------|
| 在浏览器打开 | 直接访问该 URL，可查看、编辑规则文件。 |
| 其它机器同步 / 完善规则 | `git clone 展示地址 ~/cursor-rules`，改完 `git add && git commit && git push`。 |
| 在任意项目安装规则 | 见 README 中「只提供地址、直接使用」：复制带 `RULES_REPO_URL` 的命令，把地址换成你的展示地址，在项目根执行。 |

---

## 他人如何一起完善规则？

- **写权限**：在 GitHub 仓库页 → **Settings** → **Collaborators** → 添加对方账号，对方即可直接 push。
- **无写权限**：对方 fork 你的仓库，改完提 PR；你合并后，你的展示地址即更新，其它机器 `git pull` 或重新执行安装命令即可同步。

---

## 分层规则体系说明

本仓库支持**三层规则体系**，规则越往下越具体，越往上越通用：

```
根 .cursorrules                   ← 第一层：全局核心行为准则
  └── project/.cursorrules        ← 第二层：项目级标准（可选）
        └── .cursor/rules/*.mdx   ← 第三层：功能模块分层规则（按需创建）
```

### 第一层：`.cursorrules`（随本仓库提供）

全局核心行为准则，适用于所有项目：

- 语言 / 方案优先 / 决策树 / 原子任务测试
- Memory Bank（跨会话防断片）
- 工作日志门禁 / 环境管理
- Agent 全自动执行协议

### 第二层：`project/.cursorrules`（项目自建）

项目级开发标准，在安装完第一层规则后，可在项目根目录创建：

```markdown
# 项目开发标准规范

> 引用：必须先遵循根 .cursorrules 核心规则

## 规则体系架构
[说明三层结构]

## 目录职能与管理
[项目特定目录约定]

## 功能开发流程
[项目特定开发流程]

## 环境管理规范
[项目特定环境配置]
```

### 第三层：`.cursor/rules/*.mdx`（按需扩展）

功能模块分层规则，见 `.cursor/rules/layered-rules-extension.mdx` 中的完整扩展目录。

**快速上手**：

```bash
# 查看可扩展的规则目录
cat .cursor/rules/layered-rules-extension.mdx

# 按需创建具体规则文件（示例）
cp .cursor/rules/layered-rules-extension.mdx .cursor/rules/20-backend-api.mdx
# 然后编辑，将扩展提示替换为具体约束
```

### install.sh 安装内容

执行 `install.sh` 后，以下文件会被复制到目标项目：

| 文件 | 说明 |
|------|------|
| `.cursorrules` | 第一层全局规则（核心） |
| `.cursor/agent-master-prompt.md` | Ctrl+I Agent 执行模板 |
| `.cursor/rules/memory-bank-workflow.mdx` | Memory Bank 工作流规范 |
| `.cursor/rules/agent-mcp-workflow.mdx` | Agent MCP 自动选用规范 |
| `.cursor/rules/docs-governance.mdx` | 文档治理与生命周期规范 |
| `.cursor/rules/layered-rules-extension.mdx` | 分层规则扩展目录（导航） |

安装后按需创建第二层 `project/.cursorrules` 和第三层具体规则文件。
