#!/bin/zsh

cd_with_fzf() {
  local dir="$1"

  if [ ! -d "$dir" ]; then
    echo "❌ 目錄 $dir 不存在！"
    return 1
  fi

  # 讓使用者選擇 repo
  local subdir=$(find "$dir" -maxdepth 1 -type d ! -name "." -exec basename {} \; | fzf --prompt="選擇 $(basename $dir): ")

  if [ -n "$subdir" ]; then
    cd "$dir/$subdir"
    # 🔥 進入資料夾後，自動切換 Git Remote
    set_git_remote "$PWD"
  else
    cd "$dir"
  fi
}
set_git_remote() {
  local repo_dir="$1"
  local repo_name=""
  local username=""
  local github_pat=""

  # 確保這是 Git Repo
  if [ ! -d "$repo_dir/.git" ]; then
    echo "⚠️  這不是 Git 專案，跳過 Remote 設定"
    return
  fi

  # 取得目前的 Remote URL
  local current_remote=$(git -C "$repo_dir" remote get-url origin 2>/dev/null)

  # ✅ 解析 Git Remote URL
  if [[ "$current_remote" =~ ^git@github\.com:(.*)/(.*)\.git$ ]]; then
    username="${match[1]}"
    repo_name="${match[2]}"
  elif [[ "$current_remote" =~ ^https://github\.com/(.*)/(.*)\.git$ ]]; then
    username="${match[1]}"
    repo_name="${match[2]}"
  else
    echo "⚠️  無法解析 Remote，跳過變更"
    return
  fi

  echo "📦 解析結果：Username=$username, Repo=$repo_name"

  # 根據專案目錄選擇正確的 GitHub PAT
  case "$(basename $(dirname "$repo_dir"))" in
    "Fluv")
      echo "🌐 使用 GitHub Fluv 帳號"
      github_pat="$GITHUB_PAT_FLUV"
      ;;
    "My")
      echo "🔑 使用 GitHub Lucien 帳號"
      github_pat="$GITHUB_PAT_LUCIEN"
      ;;
    "Tarode")
      echo "🚀 使用 GitHub Tarode 帳號"
      github_pat="$GITHUB_PAT_TARODE"
      ;;
    *)
      echo "⚠️  未知的 Git 目錄，使用 GitHub Lucien 帳號"
      github_pat="$GITHUB_PAT_LUCIEN"
      ;;
  esac

  # 🔹 檢查是否有 Token
  if [[ -z "$github_pat" ]]; then
    echo "❌ 錯誤：未設定 GitHub PAT，請先設定 `.envrc`"
    return
  fi

  # 🔹 強制使用 HTTPS + PAT
  local correct_remote="https://$github_pat@github.com/$username/$repo_name.git"

  # 檢查是否需要變更 Remote
  if [[ "$current_remote" != "$correct_remote" ]]; then
    echo "🔄 變更 Git Remote 為 HTTPS：$correct_remote"
    git -C "$repo_dir" remote set-url origin "$correct_remote"
  else
    echo "✅ Git Remote 無需更改，當前為：$current_remote"
  fi
}
