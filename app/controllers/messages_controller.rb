# coding: utf-8
class MessagesController < ApplicationController
  # what messages needs this?
  def index
    if is_msg?
      flash.now[:notice] = current_msg
      clear_msg
    end
  end
end
