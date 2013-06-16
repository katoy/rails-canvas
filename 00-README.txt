
- Getting started.

    $ bundle install
    $ rake db:migrate
    $ rails s

- test/fixtures/users.yml を読み込む。

    $ rake db:drop
    $ rake db:migrate
    $ rake db:fixtures:load

このデータで初期化すると、
　admin / 123123
　user_00 / 123123
などでログインできるようになる。

admin で loign すると、[Admin] メニューから ユーザー情報を閲覧, 編集が可能になる。
