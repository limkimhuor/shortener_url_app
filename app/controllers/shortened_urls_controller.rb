class ShortenedUrlsController < ApplicationController
  before_action :find_url, only: [:show, :shortened]

  def index
    @url = ShortenedUrl.new
  end

  def show
    redirect_to @url.sanitize_url
  end

  def create
    @url = ShortenedUrl.new shortened_url_params
    @url.sanitize
    if @url.new_url?
      if @url.save
        redirect_to shortened_path @url.short_url
      else
        flash.now[:error] = "Check the errors below"
        render :index
      end
    else
      flash.now[:notice] = "A short link for this URL is existed!"
      redirect_to shortened_path @url.find_duplicate.short_url
    end
  end

  def shortened
    host = request.host_with_port
    @original_url = @url.sanitize_url
    @short_url = [host, @url.short_url].join "/"
  end

  private
  def find_url
    @url = ShortenedUrl.find_by_short_url params[:short_url]
  end

  def shortened_url_params
    params.require(:shortened_url).permit :original_url
  end
end
