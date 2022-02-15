resource "aws_cognito_user_pool" "user_pool" {
    name = "GoogleExample"

    # ユーザー確認を行う際にEmail or 電話で自動検証を行うための設定。Emailを指定。
    auto_verified_attributes = [
        "email",
    ]

    account_recovery_setting {
        recovery_mechanism {
            name     = "verified_email"
            priority = 1
        }
        recovery_mechanism {
            name     = "verified_phone_number"
            priority = 2
        }
    }

    # 「schema」は登録するユーザーに求める属性。(メールアドレスや電話番号など)
    # 「email」はデフォルトで有効になっている属性だが、今回は登録時に必須にしたいため設定。
    schema {
        attribute_data_type      = "String"
        developer_only_attribute = false
        mutable                  = true
        name                     = "email"
        required                 = true

        string_attribute_constraints {
            max_length = "2048"
            min_length = "0"
        }
    }

    username_configuration {
        case_sensitive = false
    }
}

# Google OAuth
variable "google_client_id" {}
variable "google_client_secret" {}

resource "aws_cognito_identity_provider" "example_provider" {
    user_pool_id  = "${aws_cognito_user_pool.user_pool.id}"
    provider_name = "Google"
    provider_type = "Google"

    provider_details = {
        authorize_scopes  = "email"
        client_id         = var.google_client_id
        client_secret     = var.google_client_secret
    }

    attribute_mapping = {
        email    = "email"
        "username" = "sub"
    }
}

resource "aws_cognito_user_pool_client" "user_pool_client" {
        user_pool_id  = "${aws_cognito_user_pool.user_pool.id}"
        name = "SomeWebApp"

  access_token_validity                = 60
  allowed_oauth_flows                  = ["code","implicit"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_scopes                 = ["openid"]
  callback_urls                        = ["http://localhost:3000/"]

  explicit_auth_flows = [
    "ALLOW_CUSTOM_AUTH",
    # 更新トークン(新しいアクセストークンを取得するのに必要。)
    "ALLOW_REFRESH_TOKEN_AUTH",
    # SRPプロトコルを使用してユーザー名&パスワードを検証する。
    "ALLOW_USER_SRP_AUTH",
  ]
  id_token_validity                    = 60
  logout_urls                   = ["http://localhost:3000/"]
  prevent_user_existence_errors = "ENABLED"

  # 属性の読み取り有無設定。
  read_attributes = [
    "address",
    "birthdate",
    "email",
    "email_verified",
    "family_name",
    "gender",
    "given_name",
    "locale",
    "middle_name",
    "name",
    "nickname",
    "phone_number",
    "phone_number_verified",
    "picture",
    "preferred_username",
    "profile",
    "updated_at",
    "website",
    "zoneinfo",
  ]
  # 更新トークンの期限
  refresh_token_validity       = 30
  supported_identity_providers = ["COGNITO","Google"]

  # 属性の書き有無設定。
  write_attributes = [
    "address",
    "birthdate",
    "email",
    "family_name",
    "gender",
    "given_name",
    "locale",
    "middle_name",
    "name",
    "nickname",
    "phone_number",
    "picture",
    "preferred_username",
    "profile",
    "updated_at",
    "website",
    "zoneinfo",
  ]

    token_validity_units {
        access_token  = "minutes"
        id_token      = "minutes"
        refresh_token = "days" 
    }
}
