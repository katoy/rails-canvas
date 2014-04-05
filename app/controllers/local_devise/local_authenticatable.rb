# -*- coding: utf-8 -*-

require 'devise/strategies/authenticatable'

# See
#  https://github.com/plataformatec/devise/blob/master/lib/devise/strategies/database_authenticatable.rb
#  http://qiita.com/hattorix@github/items/f383afdef336975bd669#2-3

# ログインチェック方法を独自に定義する。
# databas_authenticable を ベースにして、ログイン許可のアカウントチェックを追加する。
# config/initializers/devise.rb 中で、このチェックメソッドをつかうことを設定する必要がある。

module Devise
  module Strategies
    # Devise 標準の DatabaseAuthenticatable に サーバータイプ別のアカウントチェックを追加。
    class LocalAuthenticatable < Authenticatable
      def authenticate!
        resource  = valid_password? && mapping.to.find_for_database_authentication(authentication_hash)
        encrypted = false

        if validate(resource){ encrypted = true; validate_resource(resource) }
          resource.after_database_authentication
          success!(resource)
        end

        mapping.to.new.password = password if !encrypted && Devise.paranoid
        fail(:not_found_in_database) unless resource
      end

      # ログインチェックのロジック
      def validate_resource(resource)

        # user_0* のユーザーは login 不可にする。
        return false if /user_0[2468]/ =~ resource.username

        # パスワードのチェック
        resource.valid_password?(password)
      end
    end
  end
end
Warden::Strategies.add(:local_authenticatable, Devise::Strategies::LocalAuthenticatable)
