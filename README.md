# Cursor 规则仓库

本目录就是一个**独立的规则仓库**：没有「官方默认仓库」，你把它推到 GitHub/GitLab 后，**所有项目都从这一个地址同步规则**。新机或新项目只需知道这个地址即可直接使用。

---

## 规则仓库地址与直接使用

1. **创建并推送到远程**（仅做一次）  
   - 在 GitHub/GitLab 等新建空仓库（例如 `cursor-rules`）。  
   - 在本目录执行：
   ```bash
   cd /path/to/cursor-rules
   git remote add origin https://github.com/你的用户名/cursor-rules.git
   git add -A && git commit -m "Initial: Cursor rules" && git push -u origin master
   ```
   - 记下仓库地址，例如：`https://github.com/你的用户名/cursor-rules`

2. **只提供地址、直接用到任意项目**（无需先手动克隆）  
   - 在**要安装规则的项目根目录**下执行（把 `YOUR_RULES_REPO_URL` 换成你的仓库地址）：
   ```bash
   RULES_REPO_URL="https://github.com/你的用户名/cursor-rules"
   git clone "$RULES_REPO_URL" /tmp/cursor-rules-install && \
   /tmp/cursor-rules-install/install.sh . && \
   rm -rf /tmp/cursor-rules-install
   ```
   - 效果：临时克隆规则仓库 → 把规则安装到当前项目 → 删除临时目录；当前项目即具备完整规则。

3. **其他项目规则是否同步？**  
   - **可以同步**：所有项目都用**同一个规则仓库地址**执行上面的「直接使用」命令，装上的就是同一套规则。  
   - **更新规则**：在规则仓库里改 `.cursorrules` 并 push；需要同步的项目里再执行一次上面的安装命令（或 `~/cursor-rules/install.sh`），即更新为该版本。

---

## 使用 GitHub 免费空间 + 展示地址

- **免费**：GitHub 公开仓库不限数量、免费；把本仓库设为 Public 即可作为「规则展示与安装源」。
- **展示地址**：创建并推送后，仓库首页地址即为你的**规则展示/使用地址**，例如：
  - `https://github.com/你的用户名/cursor-rules`
  - 别人或其它机器可用该地址克隆、或按下方「直接使用」命令安装规则。
- **其他机器 / 他人也可以完善规则**：
  - 其它电脑：`git clone 展示地址 ~/cursor-rules`，改完 `git push` 即可。
  - 若你给他人仓库的写权限（Settings → Collaborators 或 fork 后 PR），他们也可以提交修改；你 pull 或合并 PR 后，所有用该地址安装的项目再执行一次安装即同步到最新。

**一键推送（在 GitHub 网页建好空仓后执行）：**

```bash
cd /path/to/cursor-rules
chmod +x push-to-github.sh
./push-to-github.sh https://github.com/你的用户名/cursor-rules
```

脚本会添加 remote、提交并 push，最后输出**展示地址**，可直接复制使用。

---

## 仓库内容

| 路径 | 说明 |
|------|------|
| `.cursorrules` | 完整规则（方案/执行、决策树、测试、Agent 协议等） |
| `.cursor/agent-master-prompt.md` | Agent 全自动执行指令模板（Ctrl+I 用） |
| `install.sh` | 将规则安装到指定项目的脚本 |
| `CURSOR-USER-RULES.txt` | **最小化用户规则**，需粘贴到 Cursor 设置中（见下） |

---

## 不同项目会怎样？（不强制、不冲突）

| 项目状态 | 行为 |
|----------|------|
| 项目里**有** `.cursorrules`（例如你运行过 `install.sh`） | 严格按该文件规则工作（方案/执行、决策树、测试闭环等）。 |
| 项目里**没有** `.cursorrules` | 正常协助，不拦截、不强制；可选地提醒一次可安装规则。 |

因此：别人的仓库、临时目录、不想用这套规则的项目，直接打开即可用；只有你主动安装规则的项目才会走完整流程，不会因为「没规则」被强制处理或导致问题。

---

## 新机 / 换设备流程

### 1. 克隆本仓库

```bash
git clone <你的规则仓库地址> ~/cursor-rules
cd ~/cursor-rules
```

### 2. 在 Cursor 中设置「最小化用户规则」（仅此一步需手动）

- 打开 Cursor → **Settings** → **Cursor Settings** → **Rules for AI**
- 将 `CURSOR-USER-RULES.txt` 中的全部内容**粘贴进去并保存**

规则**按项目可选**：只有安装了规则的项目会走完整流程；未安装的项目照常工作，不会被强制或拦截。

### 3. 为需要规则的项目安装（可选）

仅在**你希望该项目的对话遵守完整规则**时，在该项目目录下执行：

```bash
# 当前目录即为项目根时
~/cursor-rules/install.sh

# 或指定项目路径
~/cursor-rules/install.sh /path/to/your-project
```

安装后，用 Cursor 打开该项目即可自动加载 `.cursorrules`。

### 4. 可选：新项目模板

若你常用同一套规则，可：

- 新项目 `git clone` 后先执行一次 `~/cursor-rules/install.sh /path/to/new-project`；或
- 在模板项目里保留 `.cursorrules`，新项目从模板 fork/copy。

---

## 能否删除 Cursor 里原来的用户规则？

可以。规则已收敛为两类：

1. **Cursor 用户规则（Rules for AI）**：只保留 `CURSOR-USER-RULES.txt` 中的**最小化规则**（语言 + 有 `.cursorrules` 则加载遵守，没有则正常协助、不强制）。原先长篇规则可删除，避免重复。
2. **项目内规则**：由本仓库的 `install.sh` **按需**写入某项目的 `.cursorrules` 和 `.cursor/`；未安装的项目不受影响，不同项目可自由选择是否使用本套规则。

---

## 更新规则

在规则仓库中修改 `.cursorrules` 或 `.cursor/agent-master-prompt.md`，提交并 push。其它设备或项目需要新规则时：已克隆过则 `git pull` 后执行 `install.sh`；未克隆则用上文「只提供地址、直接使用」的命令再装一次即可。

---

## 小结

| 问题 | 答案 |
|------|------|
| 规则的默认仓库是哪个？ | 没有官方默认仓库；本目录就是你的**独立规则仓库**，推到 Git 后即你的「默认地址」。 |
| 要不要独立创建？ | 要。在 GitHub/GitLab 新建一个仓库（如 `cursor-rules`），把本目录推上去即可。 |
| 其他项目的规则能同步吗？ | 能。所有项目用**同一个规则仓库地址**安装，即共享同一套规则；更新仓库后在各项目再执行一次安装即同步。 |
| 规则地址怎么直接使用？ | 见上文「规则仓库地址与直接使用」：复制带 `RULES_REPO_URL` 的一串命令，替换成你的仓库地址，在目标项目根目录执行即可。 |
