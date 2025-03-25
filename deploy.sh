#!/bin/bash

# 切到 Test 分支並確認匯出資料夾存在
echo "🛠 切換到 Test 分支"
git checkout Test

if [ ! -d "export/web" ]; then
  echo "❌ 找不到 export/web 資料夾，請先從 Godot 匯出 HTML5 遊戲"
  exit 1
fi

# 建立暫存資料夾
echo "📦 備份匯出檔案到 /tmp/godot-export"
rm -rf /tmp/godot-export
cp -r export/web /tmp/godot-export

# 切換到 gh-pages 分支
echo "🔁 切換到 gh-pages 分支"
git checkout gh-pages

# 複製檔案到當前目錄
echo "📥 複製匯出內容到 gh-pages 根目錄"
cp -r /tmp/godot-export/. ./

# 提交與推送
echo "🚀 提交並推送更新"
git add .
git commit -m "部署最新 HTML5 遊戲版本"
git push origin gh-pages

echo "✅ 部署完成！快去看看你的 GitHub Pages 網站吧 🎉"
