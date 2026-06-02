## ホスト側の設定
```
brew install --cask google-cloud-sdk

公式ページの手順はあるがbrewでいける. 
uname -m
FILE_NAME="google-cloud-cli-darwin-arm.tar.gz"
cd Download
curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/$FILE_NANE
tar -xf $FILE_NAME
```

## ストレージ: ディスクの作成
```
gcloud compute disks create dev-disk-500gb \
    --project=mycomputer-465723 \
    --type=pd-balanced \
    --size=500GB \
    --zone=asia-northeast1-b \
&& \
gcloud compute resource-policies create snapshot-schedule default-schedule-1 \
    --project=mycomputer-465723 \
    --region=asia-northeast1 \
    --max-retention-days=14 \
    --on-source-disk-delete=keep-auto-snapshots \
    --daily-schedule \
    --start-time=22:00 \
&& \
gcloud compute disks add-resource-policies dev-disk-500gb \
    --project=mycomputer-465723 \
    --zone=asia-northeast1-b \
    --resource-policies=projects/mycomputer-465723/regions/asia-northeast1/resourcePolicies/default-schedule-1
```

## VMインスタンス: インスタンスの作成
```
gcloud compute instances create dev-l4-g2 \
    --project=mycomputer-465723 \
    --zone=asia-northeast1-b \
    --machine-type=g2-standard-32 \
    --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default \
    --maintenance-policy=TERMINATE \
    --provisioning-model=STANDARD \
    --service-account=193556165326-compute@developer.gserviceaccount.com \
    --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/trace.append \
    --accelerator=count=1,type=nvidia-l4 \
    --tags=ssh-only \
    --create-disk=auto-delete=yes,boot=yes,device-name=dev-l4-g2,disk-resource-policy=projects/mycomputer-465723/regions/asia-northeast1/resourcePolicies/default-schedule-1,image=projects/ubuntu-os-cloud/global/images/ubuntu-2404-noble-amd64-v20260517,mode=rw,size=510,type=pd-balanced \
    --no-shielded-secure-boot \
    --shielded-vtpm \
    --shielded-integrity-monitoring \
    --labels=goog-ec-src=vm_add-gcloud \
    --reservation-affinity=any
```



## ファイアウォール ポリシー: ファイアウォール ルールの作成
```
MY_IP="$(curl -4 -s ifconfig.me)/32" && \
gcloud compute firewall-rules create allow-ssh-from-my-ip \
  --project=mycomputer-465723 \
  --direction=INGRESS \
  --priority=1000 \
  --network=default \
  --action=ALLOW \
  --rules=tcp:22 \
  --source-ranges="${MY_IP}" \
  --target-tags=ssh-only
```

## 固定外部IP設定
```
gcloud compute addresses create instance-ip0 \
  --project=mycomputer-465723 \
  --region=us-central1
```
