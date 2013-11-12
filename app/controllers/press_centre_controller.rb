class PressCentreController < ApplicationController

  layout :set_layout

  def index
    
  end

  def press
    
  end

  def news_item
    
  end

  def news
    
  end

  def set_layout
    "application"
    if request.path === "/business/press-centre"
      "business"
    end


  end

end
