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