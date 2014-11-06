class RecipesController < ApplicationController
  def index
    @recipes = if params[:keywords]
       Recipe.where('name like ?',"%#{params[:keywords]}%")
     else
       []
     end
  end
end
