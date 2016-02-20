class WelcomeController < ApplicationController
  def index
  end

  def show
  redirect_to article_path(Article.last) and return
  end
  
end
