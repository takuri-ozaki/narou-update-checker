# narou-update-checker

## about
[小説家になろう](https://syosetu.com/)に投稿されている作品の更新情報を確認、Slack通知するためのスクリプトです。  
cron等で定期実行させるようにすると良いと思います。

This is a script to notify slack of novels update posted [syosetsuka ni narou](https://syosetu.com/).  
It is convenient to set it to be executed periodically by cron or others.

## how to use
NCODE_LISTに更新を通知したい小説のncodeを記載してください。  
ncodeは小説ごとに割り振られたコードで、URLから確認ができます（https[]()://ncode.syosetu.com/[ここの英数字]/）。  
配列形式なので、改行して追加していくと便利です。  
例に記載してある`n2267be`は[Ｒｅ：ゼロから始める異世界生活（鼠色猫/長月達平 作）](https://ncode.syosetu.com/n2267be/)を表します。

SLACK_ENDPOINTにSlackのWebhook通知先URLを設定してください。

SAVE_DATA_PATHはスクリプトで利用する更新履歴情報を記録するファイルの保存先を指します。  
TMP_PATHは処理で使用する一時ファイルの保存先を指します。  
cronで実行する場合、これらの設定は絶対パスにしておくことを推奨します。

Please input ncode to NCODE_LIST. Ncode is code assigned to each novel.  
You could check ncode from URL (https[]()://ncode.syosetu.com/[here]/).  
NCODE_LIST is array, you could add data with line breaks.  
`n2267be` inputted as an example represents ncode of [Re: Zero kara Hajimeru Isekai Seikatsu (written by nezumiironeko/Nagatsuki Tappei)](https://ncode.syosetu.com/n2267be/).

Please input slack incoming webhook endpoint to SLACK_ENDPOINT.

SAVE_DATA_PATH means the location of file where update information is recorded.  
TMP_PATH means the location of temporary file used by this script.  
If you execute by cron, it is better to specify absolute paths for these values.

## note
過剰なアクセスにならないよう、スリープ処理を入れています。  
小説家になろう側のレイアウト変更等により、機能しなくなる可能性があります。

To prevent excessive access, this script includes sleep.  
Due to changing website layout and others, it may not work.

## dependent bash commands
* [[
* alias
* awk
* cat
* curl
* echo
* grep
* sed (GNU)
* shopt
* sleep
* tail
* touch
* uname

## for MacOS
MacOSで実行する場合、スクリプト実行中のエイリアスが有効になります。  
このスクリプトはGNUのsedを利用しているため、別途インストールが必要になります。

In this case, alias is enabled during script execution.  
This script uses GNU sed, please install gnu-sed.

```
brew install gnu-sed
```