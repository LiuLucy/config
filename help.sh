#!/bin/zsh

help() {
    echo "📖 使用說明"
    echo "----------------------------------------"
    echo "🔧 其他功能"
    echo "  help     -> 顯示這個說明文件"
    echo ""
    echo "📂 目錄快速跳轉指令（fzf 選擇子目錄，並自動設定 Git Remote）"
    echo "  fluv     -> 選擇並進入 ~/Desktop/Fluv 內的子目錄（Remote 會設定為 GitHub PAT）"
    echo "  my       -> 選擇並進入 ~/Desktop/My 內的子目錄（Remote 會設定為 GitHub PAT）"
    echo "  tarode   -> 選擇並進入 ~/Desktop/Tarode 內的子目錄（Remote 會設定為 GitHub PAT）"
    echo ""
    echo "🐙 GitHub 快捷指令（自動設定 Git Remote）"
    echo "  set_git_remote <repo_path>  -> 根據目錄自動切換 Git Remote（使用 GitHub PAT）"
    echo ""
}
