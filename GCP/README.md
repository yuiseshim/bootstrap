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
gcloud compute instances create l4-g2 --project=mycomputer-465723 --zone=asia-northeast1-b --machine-type=g2-standard-32 --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default --metadata=enable-osconfig=TRUE --maintenance-policy=TERMINATE --provisioning-model=STANDARD --service-account=193556165326-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/trace.append --accelerator=count=1,type=nvidia-l4 --create-disk=auto-delete=yes,boot=yes,device-name=l4-g2,disk-resource-policy=projects/mycomputer-465723/regions/asia-northeast1/resourcePolicies/default-schedule-1,image=projects/ubuntu-os-cloud/global/images/ubuntu-2404-noble-amd64-v20260517,mode=rw,size=510,type=pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=goog-ops-agent-policy=v2-template-1-7-0,goog-ec-src=vm_add-gcloud --reservation-affinity=any && printf 'agentsRule:\n  packageState: installed\n  version: latest\ninstanceFilter:\n  inclusionLabels:\n  - labels:\n      goog-ops-agent-policy: v2-template-1-7-0\n' > config.yaml && gcloud compute instances ops-agents policies create goog-ops-agent-v2-template-1-7-0-asia-northeast1-b --project=mycomputer-465723 --zone=asia-northeast1-b --file=config.yaml
```


```
gcloud compute instances create test-instance-e2-medium \
    --project=mycomputer-465723 \
    --zone=us-central1-c \
    --machine-type=e2-medium \
    --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default \
    --metadata=enable-osconfig=TRUE \
    --maintenance-policy=MIGRATE \
    --provisioning-model=STANDARD \
    --service-account=193556165326-compute@developer.gserviceaccount.com \
    --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/trace.append \
    --tags=ssh-only \
    --create-disk=auto-delete=yes,boot=yes,device-name=test-instance-e2-medium,disk-resource-policy=projects/mycomputer-465723/regions/us-central1/resourcePolicies/default-schedule-1,image=projects/ubuntu-os-cloud/global/images/ubuntu-2404-noble-amd64-v20260225,mode=rw,size=20,type=pd-balanced \
    --no-shielded-secure-boot \
    --shielded-vtpm \
    --shielded-integrity-monitoring \
    --labels=goog-ops-agent-policy=v2-template-1-5-0,goog-ec-src=vm_add-gcloud \
    --reservation-affinity=any \
&& \
printf 'agentsRule:\n  packageState: installed\n  version: latest\ninstanceFilter:\n  inclusionLabels:\n  - labels:\n      goog-ops-agent-policy: v2-template-1-5-0\n' > config.yaml \
&& \
gcloud compute instances ops-agents policies create goog-ops-agent-v2-template-1-5-0-us-central1-c \
    --project=mycomputer-465723 \
    --zone=us-central1-c \
    --file=config.yaml
```

``` 修正版
gcloud compute instances create e2-medium \
  --project=mycomputer-465723 \
  --zone=us-central1-c \
  --machine-type=e2-medium \
  --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default,address='' \
  --metadata=enable-osconfig=TRUE \
  --maintenance-policy=MIGRATE \
  --provisioning-model=STANDARD \
  --service-account=193556165326-compute@developer.gserviceaccount.com \
  --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/trace.append \
  --tags=ssh-only \
  --create-disk=auto-delete=yes,boot=yes,image=projects/ubuntu-os-cloud/global/images/ubuntu-2404-noble-amd64-v20260225,size=100,type=pd-balanced \
  --no-shielded-secure-boot \
  --shielded-vtpm \
  --shielded-integrity-monitoring \
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
