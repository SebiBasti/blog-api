class V2::PostsController < ApplicationController
  def index
    json_response({ message: 'Hello there'})
  end
end
