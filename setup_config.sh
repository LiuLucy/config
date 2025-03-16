#!/bin/zsh

CONFIG_PATH=~/config
ZSHRC=~/.zshrc
ENVRC="$CONFIG_PATH/.envrc"
FILES=("aliases.sh" "help.sh")  # 你可以在這裡新增其他檔案
PAT_KEYS=("GITHUB_PAT_LUCIEN" "GITHUB_PAT_FLUV" "GITHUB_PAT_TARODE")

# 1️⃣ 檢查 ~/config 是否存在，如果不存在就建立
if [ ! -d "$CONFIG_PATH" ]; then
    echo "📁 建立 $CONFIG_PATH 資料夾..."
    mkdir -p "$CONFIG_PATH"
fi

# 2️⃣ 迴圈處理每個要 source 的檔案
for file in "${FILES[@]}"; do
    FILE_PATH="$CONFIG_PATH/$file"
    SOURCE_CMD="source $FILE_PATH"

    # 確保檔案存在
    if [ ! -f "$FILE_PATH" ]; then
        echo "⚠️  檔案 $FILE_PATH 不存在，跳過..."
        continue
    fi

    # 檢查 ~/.zshrc 是否已經包含這個檔案的 source 指令
    if grep -Fxq "$SOURCE_CMD" "$ZSHRC"; then
        echo "✅ ~/.zshrc 已經包含 $SOURCE_CMD，無需修改"
    else
        echo "🔧 將 $SOURCE_CMD 加入 ~/.zshrc..."
        echo "" >> "$ZSHRC"
        echo "# 載入 $file 設定檔" >> "$ZSHRC"
        echo "$SOURCE_CMD" >> "$ZSHRC"
    fi
done

# 3️⃣ 檢查 `.envrc` 是否存在，並讀取 PAT 變數
if [ -f "$ENVRC" ]; then
    echo "📄 讀取 $ENVRC 中的 GitHub PAT 變數..."

    for key in "${PAT_KEYS[@]}"; do
        value=$(grep "^export $key=" "$ENVRC" | cut -d '=' -f2-)

        if [[ -n "$value" ]]; then
            # 確保變數沒有重複加入
            if grep -q "^export $key=" "$ZSHRC"; then
                echo "✅ ~/.zshrc 已經包含 $key，無需修改"
            else
                echo "🔧 將 $key 加入 ~/.zshrc..."
                echo "" >> "$ZSHRC"
                echo "# GitHub PAT 變數" >> "$ZSHRC"
                echo "export $key=$value" >> "$ZSHRC"
            fi
        else
            echo "⚠️  找不到 $key，請檢查 $ENVRC"
        fi
    done
else
    echo "⚠️  找不到 $ENVRC，無法載入 GitHub PAT 變數"
fi

# 4️⃣ 重新載入 .zshrc
echo "♻️  重新載入 ~/.zshrc..."
source "$ZSHRC"

echo "🚀 設定完成！"
