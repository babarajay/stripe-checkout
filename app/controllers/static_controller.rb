class StaticController < ApplicationController
  def index
    condition = params[:title].blank? ? {} : ["lower(title) LIKE ?", "%#{params[:title].downcase}%"]
    @products = Product.where(condition)
  end

  def success; end

  def cancel; end
end
