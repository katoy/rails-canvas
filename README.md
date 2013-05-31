
* [http://kray.jp/blog/rails3-html5-canvas/](http://kray.jp/blog/rails3-html5-canvas/) rails3 + html5 canvasでお絵かき投稿サイトを作ろう！ (2011年11月14日)
 をなぞって作成してみた。  

[![スクリーンショット]](https://raw.github.com/katoy/rails-canvas/master/misc/scrennshts/screen-001.png)


    $ rvm list  
    ...  
      =* ruby-1.9.3-p429 [ i386 ]  
    ...  
    $ rfm gemset list  
    ...  
       => rails32  
    ...  
      
    $ rails new canvas  
    $ cd canvas  
    $ rails g controller pictures  


上のような環境下で rails アプリを新規作成した後に次のような操作をしていく。  
（投稿サイトを作ろう！ のページを参照）  
 (画面レイアウト, css ｎついては http://ruby.railstutorial.org/chapters/filling-in-the-layout#sec-structure を参照)  
 
次のファイルを削除
- README.rd  
- app/pubic/index.html  

次のファイルを編集。(存在していなければ作成)  
内容は 実際の githug レポジトリー中のソースコードを参照すること  

- Gemfile
- README.md

- config/routes.rb

- app/assets/strylesheet/pictures.css.scss
- app/assets/strylesheet/custom.css.scss

- app/assets/javascripts/pictures.js.coffee

- app/views/layouts/_shim.html.erb
- app/views/layouts/_header.html.erb
- app/views/layouts/_footer.html.erb
- app/views/layouts/application.html.erb

- app/view/pictures/new.html.erb

* 実装済みの機能

- 描画  
- 色、太さの変更 (アルファ値も扱えるようにした)  
- undo/redo (現状では回数制限は無し[エラー処理も無し])  


* TODO

- 画像の保存・読み込み  
- 保存された画像の一覧表示、サムネイル表示  
- ページ上の各種リンクの実装
- rspec でのテスト  
- heroku へ deploy  


