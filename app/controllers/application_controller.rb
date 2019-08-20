require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    # erb :index
  end

  # Allow user to create a new Post
  get '/posts/new' do
    erb :new
  end
  
   # this is where we make new posts that save to our database!
  post '/posts' do
    Post.create(params)
    redirect '/posts'
  end
  
   # This allows us to see our posts
  get '/posts' do
    @posts = Post.all
    erb :index
  end
  
   # This allows to get the posts from the database
   get '/posts/:id' do
     @post = Post.find(params["id"])
     erb :show
   end
   
   # Allow to update the Record
   get '/posts/:id/edit' do
     @post = Post.find(params["id"])
     erb :edit
   end
   
    # Allow to update the Record in the database
    patch '/posts/:id' do
      Post.update(params[:id], name: params[:name], content: params[:content])
      @post = Post.find(params[:id])

      erb :show
    end

    # Allow to delete a Record
    delete '/posts/:id/delete' do
      Post.delete params[:id]
      redirect '/posts'
    end

end
