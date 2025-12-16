# Terraform 基礎スターター（GCP 例）

Terraform の基礎を押さえるためのミニリポジトリです。最小構成の GCE 作成例と、module / env 分離の推奨ディレクトリを用意しました。解説を読みながらコードを開くと理解が早まります。

このリポジトリ直下には Nuxt 3 の最小セットアップを配置し、Terraform は `modules/` と `envs/` に分離した構成を推奨としています。

## 1. Terraformとは？
インフラをコードで宣言し、同じコードで再現性のある構築ができる IaC ツール。マルチクラウド対応で、宣言型（なりたい状態を書く）なのが特徴です。

## 0. Nuxt 3（アプリ）
- Nuxt 3 はリポジトリ直下に配置しています。

### 起動
```
npm install
npm run dev
```

## 2. 📂 基本ファイル構成
- `main.tf` : 実際のリソース定義
- `variables.tf` : 入力値の定義
- `outputs.tf` : 実行結果の出力
- `provider.tf` : どのクラウドに接続するか
- `terraform.tfvars` : 環境ごとの値（Git 管理しない）

### 最小例（GCE）
`gce-instance/` に provider/variables/main の 3 ファイルを配置。`terraform init` → `plan` → `apply` で VM を 1 台作成できます。

## 3. 🏗️ 基本コマンド
- `terraform init` : プラグイン取得と初期化
- `terraform plan` : 差分の確認
- `terraform apply` : 反映
- `terraform destroy` : 削除

## 4. 🧩 リソース定義の基本
- 例: `gce-instance/main.tf` の Compute Engine 定義
- Terraform はファイルの“順番”では動かず、全 `.tf` を読み込んで依存関係グラフを作り、適切な順序で適用します。

## 5. 🗂 ステートファイル（.tfstate）
- Terraform が「現在こう認識している」という情報を保持
- Git に絶対入れない（認証情報・現在の状態が含まれる）
- このリポジトリの `.gitignore` に `.terraform/` と `terraform.tfstate*` を含めています

## 6. 🔧 モジュール（module）の基礎
- 繰り返し使う構成を部品化する仕組み
- このリポジトリでは `modules/compute` に GCE の作成ロジックを定義し、`envs/stg` / `envs/prod` から呼び出しています。

## 7. 📘 よく使うブロック
- `terraform` : バージョンや provider のバージョンピンを管理
- `provider` : 接続先クラウドやリージョン/プロジェクト指定
- `variable` : 入力値を宣言（tfvars で環境ごとに差し替え）
- `output` : 結果を出力（秘密情報は出力しない）
- `resource` : 作成対象
- `data` : 既存リソースを参照
- `module` : 再利用可能な部品

## 8. 🌲 推奨ディレクトリ構成（modules と envs）
```
terraform-basics-sample/
├── app.vue
├── nuxt.config.ts
├── package.json
├── modules/
│   ├── compute/                # Compute Engine（GCE）用モジュール
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── cloud_run/              # Cloud Run 用モジュール（雛形）
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── envs/                        # 環境ごとの root module
│   ├── stg/
│   │   ├── main.tf
│   │   └── terraform.tfvars.example
│   └── prod/
│       ├── main.tf
│       └── terraform.tfvars.example
└── gce-instance/               # 最小 GCE 例（単一 root module）
     ├── provider.tf
     ├── variables.tf
     └── main.tf
```

（補足）`provision/` 配下にも同等のサンプルを残していますが、推奨は `modules/` + `envs/` です。

- `modules/` でロジックを部品化し、`envs/` は環境ごとの入口（root module）
- ステートを環境ごとに分離でき、apply 先の取り違えを防止

## 9. 🛡️ 実行と Git 管理のルール
- Terraform は必ず実行対象のディレクトリに `cd` してから実行します（例: `cd envs/stg`）。
- Git に含めない: `.terraform/`, `terraform.tfstate*`, `*.tfvars`, 秘密鍵系（`.pem`, `.key`, サービスアカウント JSON など）
- 例として `.gitignore` をリポジトリ直下に用意しています。

## サンプルの動かし方
### 1) 最小 GCE 例
```
cd gce-instance
terraform init
terraform plan -var "project_id=YOUR_PROJECT_ID"
terraform apply -var "project_id=YOUR_PROJECT_ID"
```

### 2) module + envs 例（推奨）
- `envs/stg/terraform.tfvars.example` を `terraform.tfvars` にコピーして値を埋める
```
cd envs/stg
terraform init
terraform apply
```
prod も同様に `cd envs/prod` で実行します。

## 学びのポイント
- 実行フロー: `init` → `plan` → `apply`（destroy は逆の差分適用）
- 依存関係は Terraform が計算するので、main.tf の“書く順番”は自由
- module で再利用性を上げ、env ディレクトリでステート分離することで安全性を確保
# terraform-basics-sample
