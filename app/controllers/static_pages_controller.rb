class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
    # => 'app/views/static_pages/help.html.erb'
  end
  
  def about
    # => 'app/views/static_pages/about.html.erb'
  end
  
  def contact
    # => 'app/views/static_pages/contact.html.erb'
  end
end
