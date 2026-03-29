# grep-to-hx

`grep-to-hx` は、tmux環境下で ripgrep (rg) と fzf を使用し、検索結果から Helix Editor (hx) へ即座にジャンプするためのコマンドラインツールです。

## 概要

このスクリプトは、単なる検索ツールではなく、IDEのような「検索パネル」としての挙動を提供します。
検索結果一覧（fzf）を表示したまま、Enterキーを押すたびに背後のペインで開いている Helix Editor の表示ファイルを切り替え、フォーカスを移動させることができます。

## 主な機能

- **インタラクティブな条件指定**: 検索キーワード、ファイルパターンのワイルドカード、および検索対象ディレクトリを順に入力できます。
- **スマートな初期値**: 検索ディレクトリの入力時に、現在のディレクトリのホームからの相対パス（例: `~/repo/grep-to-hx/`）が自動的に挿入されます。
- **ライブプレビュー**: `bat` (または `batcat`) を使用し、選択中の行をシンタックスハイライト付きで確認できます。
- **ペイン連携**: tmuxの `{up-of}` ターゲットを利用し、スクリプトを実行しているペインの「上」にあるペインの Helix を操作します。

## 必要条件

以下のツールがインストールされ、パスが通っている必要があります。

- [Helix Editor](https://helix-editor.com/) (hx)
- [fzf](https://github.com/junegunn/fzf)
- [ripgrep](https://github.com/BurntSushi/ripgrep) (rg)
- [bat](https://github.com/sharkdp/bat) (Ubuntu環境では `batcat`)
- [tmux](https://github.com/tmux/tmux)

## インストールと設定

1. リポジトリをクローンするか、`grep-to-hx.sh` をダウンロードします。
2. スクリプトに実行権限を付与します。
   ```bash
   chmod +x grep-to-hx.sh
