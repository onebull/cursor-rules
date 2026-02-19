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
