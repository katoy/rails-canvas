class PicturesController < ApplicationController

  def new
  end

  def create
    path = 'public/images/'
    picture = Picture.create
    File.open("#{Rails.root}/#{path}/#{picture.id}.png", 'wb') { |f|
      f.write Base64.decode64(params[:data].sub!('data:image/png;base64,', ''))
    }
    if Picture.count > 10
      picture = Picture.order(:id).first
      begin
        File.unlink()
      rescue => ex
        p exc
      end
      picture.destroy
    end

    render :nothing => true
  end

  def index
    ids = []
    Picture.all.reverse.each do |picture|
      ids << picture.id
    end
    @response = ids.join(',')
  end

  def list
    ids = []
    Picture.all.reverse.each do |picture|
      ids << picture.id
    end
    render :text => ids.join(',')
  end
end
