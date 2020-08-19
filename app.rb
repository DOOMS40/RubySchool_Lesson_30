require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, { adapter: "sqlite3", database: "leprosorium.sqlite3" }

class Post < ActiveRecord::Base
	validates :avtor, presence: true, length: { minimum: 3 }
	validates :content, presence: true 
end

class Comment < ActiveRecord::Base
end

get '/'  do
	@posts = Post.order(created_at: :desc)
	erb :index	

end

get '/new' do
	@c = Post.new
	erb :new
end

post '/new' do
	@c = Post.create params[:post]

	if @c.save
		erb "<h2>Вы успешно создали post</h2>"
	else
		@error = @c.errors.full_messages.first
		erb :new
	end
end

#вывод информации о посте
get '/details/:post_id' do
	Post.create params[:id]
	erb :details
end

#обработчик post-запроса /details......
#(браузер отправляет данные на сервер,мы из принимаем)
post '/details/:id' do
	@comments = Comment.create params[:comment]
	if @comments.save
		erb "<h2> Вы успешно отправили коментарий</h2"
	else
		@error = @comments.errors.full_messages.first
		redirect to ('/details/' + post_id)
	end	


	redirect to ('/details/' + post_id)
	
end