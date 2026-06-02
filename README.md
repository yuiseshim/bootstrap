
## GitHubアカウントへの新しいSSH キーの追加
```
# サーバ側
ssh-keygen -t rsa

# クライアント側
ssh dev-l4-g2 'cat ~/.ssh/id_rsa.pub' | pbcopy
```
