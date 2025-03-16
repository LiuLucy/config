📌 快速設定新電腦的開發環境

這份 README.md 將 列出所有需要安裝的工具，以及 如何設定 GitHub Token，讓你在新的電腦上快速完成環境配置！🚀

⸻

📌 1️⃣ 安裝 config 並初始化

🔹 安裝並執行 setup_config.sh

git clone https://github.com/LiuLucy/config.git ~/config
cd ~/config
./setup_config.sh

✅ 這會自動：
	•	建立 ~/config 目錄
	•	安裝所有 zsh 設定
	•	載入 GitHub Personal Access Token (PAT)
	•	設定 aliases.sh、help.sh 等自訂設定

⸻

📌 2️⃣ 安裝必要工具

這些工具在 日常開發 & 終端機操作 中非常重要，請確保已安裝：

brew install espanso fzf

✅ 這些工具的用途：

工具	功能
espanso	文本擴展（快速輸入模板）
fzf	終端模糊搜索（快速選擇目錄）



⸻

📌 3️⃣ 設定 GitHub Personal Access Token (PAT)

🔹 產生 GitHub Token (https://github.com/settings/tokens)
	1.	進入 GitHub Token 設定頁面：GitHub Developer Settings
	2.	點擊 "Generate new token (classic)"
	3.	選擇必要的權限：
	•	✅ Metadata（GitHub 預設開啟）
	•	✅ Contents（允許 git push、git pull）
	•	✅ Pull requests（如果要開 PR，建議開啟）
	4.	點擊 "Generate Token"
	5.	複製 Token，例如：

ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx



🔹 設定 .envrc 來管理 GitHub Token

echo 'export GITHUB_PAT_LUCIEN="ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"' > ~/config/.envrc
echo 'export GITHUB_PAT_FLUV="ghp_yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy"' >> ~/config/.envrc
echo 'export GITHUB_PAT_TARODE="ghp_zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"' >> ~/config/.envrc
direnv allow

✅ 這樣，每次你進入 ~/config，GitHub Token 會自動載入！

🚨 確保 .envrc 不會被 GitHub 推送

echo '.envrc' >> ~/config/.gitignore
git add ~/config/.gitignore
git commit -m "Ignore .envrc to keep tokens secure"
git push origin main



⸻

📌 4️⃣ 設定 Git Remote 使用 HTTPS + PAT

🔹 自動設定 Git Remote

如果 git push 時遇到身份驗證問題，請執行：

set_git_remote ~/Desktop/MyProject

✅ 這會自動：
	•	將 Git Remote 設定為 HTTPS
	•	使用對應的 GitHub Token（Lucien、Fluv、Tarode）

🔹 手動更新 Remote（如果需要）

git remote set-url origin https://$GITHUB_PAT_LUCIEN@github.com/your-username/your-repo.git



⸻

📌 5️⃣ 測試 git push

git push origin main

✅ 如果成功，表示 GitHub Token 設定成功！ 🚀

⸻

📌 6️⃣ 重新載入 zsh

source ~/.zshrc

✅ 這樣所有設定都會生效！

⸻

📌 總結

1️⃣ 安裝 config 並執行 setup_config.sh
2️⃣ 安裝必要工具 (espanso, fzf)
3️⃣ 從 GitHub 取得 Personal Access Token (PAT) 並設定 .envrc
4️⃣ 確保 .envrc 不會被 GitHub 推送
5️⃣ 使用 set_git_remote() 自動設定 Git Remote
6️⃣ 測試 git push，確保 Token 設定正確
7️⃣ 重新載入 .zshrc 讓所有設定生效
