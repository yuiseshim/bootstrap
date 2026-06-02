
## GitHubアカウントへの新しいSSH キーの追加
```
# サーバ側
# RSAではなくEd25519を使用（より安全で新しい標準）
ssh-keygen -t ed25519 -C $EMAIL -f ~/.ssh/id_ed25519 -N

# クライアント側
ssh $HOST 'cat ~/.ssh/id_rsa.pub' | pbcopy
```

### Config追記 `~/.ssh/config`
```
cat > ~/.ssh/config << EOF
Host $HOST
  HostName HNAME
  User UNAME
  IdentityFile ~/.ssh/id_ed25519
  StrictHostKeyChecking accept-new
EOF
chmod 600 ~/.ssh/config
```
