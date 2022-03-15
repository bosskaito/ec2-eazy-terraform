# terraform eazy ec2 server

## aws AWS CLI のインストール

```
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
```

```
sudo apt-get install unzip
```

```
unzip awscliv2.zip
```

```
sudo ./aws/install
```

---

## IAM ユーザーを登録

```
aws configure --profile ナマエを入力
```

下記を入力していく

```
AWS Access Key ID [None]: {アクセスキー(各自)}
AWS Secret Access Key [None]: {シークレットアクセスキー(各自)}
Default region name [None]: ap-northeast-1
Default output format [None]: json
```

確認方法

```
aws configure list --profile ナマエ
```

```sh
#デフォルト変更
export AWS_DEFAULT_PROFILE=ナマエ
#確認
aws configure list
```

---

## terraform のインストール

自分でつけた名前のディレクトリで

```
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
```

```
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
```

```
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
```

```
sudo apt-get update && sudo apt-get install terraform
```

上記を行う

インストールできたかの確認は

```
terraform -v
```

---

## terraform.tfvars ファイルの書き換え

初期値を登録しておくデータです。以下を登録・確認する

```sh
# tagやnameに使用
app = "example"
# ssh接続する際のkey
key = "example"
# 東京リージョン
region = "ap-northeast-1"
vpc_cidr_block = "10.1.0.0/16"
subnet_cidr_block1 = "10.1.1.0/24"
subnet_cidr_block10 = "10.1.10.0/24"
subnet_cidr_block11 = "10.1.11.0/24"
# DB情報
db_name = "example_db"
db_username = "example_user"
# 8文字以上　英数字複合
db_password = "example999"
```

---

## 秘密鍵・公開鍵を作成

```
ssh-keygen -t rsa -f example -N ''
```

下記ファイルが出来る

- example(秘密鍵)
- example.pub(公開鍵)

## aws_instance.tf のファイル書き換え

```sh
resource "aws_key_pair" "web_app" {
  key_name   = var.key
  # fileの場所を記載する
  public_key = file("./example.pub(公開鍵)")
}
```

---

## terraform の初期化

```
terraform init
```

## terraform の実行

```
terraform apply
```

## terraform で作った環境の破棄

```
terraform destroy
```

---

## EC2 にログイン

秘密鍵の権限を変更

```sh
sudo chmod 600 example(秘密鍵)
```

```sh
ssh -i ./example(秘密鍵) ec2-user@Elastic IP アドレス
```
