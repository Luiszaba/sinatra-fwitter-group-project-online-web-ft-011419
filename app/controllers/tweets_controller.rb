class TweetsController < ApplicationController
    get '/tweets' do
        if logged_in?
          @user = User.find_by(id: session[:user_id])
          @tweets = Tweet.all
          erb :'/tweets/tweets'
        else
          redirect '/login'
        end
      end
    
       get '/tweets/new' do
        if logged_in?
          erb :'tweets/new'
        else
          redirect '/login'
        end
      end
    
       post '/tweets/new' do
        if params[:content].empty?
          redirect '/tweets/new'
        else
          @tweet = Tweet.create(:content => params[:content], :user_id => session[:user_id])
          redirect "/tweets/#{@tweet.id}"
        end
      end
    
       get '/tweets/:id' do
        if logged_in?
          @tweet = Tweet.find_by(id: params[:id])
          erb :'/tweets/show_tweet'
        else
          redirect '/login'
        end
      end
    
       get '/tweets/:id/edit' do
        if logged_in?
          @tweet = Tweet.find_by(id: params[:id])
          erb :'/tweets/edit_tweet'
        else
          redirect '/login'
        end
      end
    
       patch '/tweets/:id' do
        @tweet = Tweet.find_by(id: params[:id])
    
         if params[:content].empty?
          redirect "/tweets/#{@tweet.id}/edit"
        else
          @tweet.content = params[:content]
          @tweet.save
        end
      end
    
       delete '/tweets/:id' do
        @tweet = Tweet.find_by(id: params[:id])
    
         if current_user.id == @tweet.user_id
          @tweet.delete
          binding.pry
        else
          redirect "/tweets/#{@tweet.id}"
        end
      end
    end