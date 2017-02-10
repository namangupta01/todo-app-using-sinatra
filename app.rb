require 'sinatra'
require 'data_mapper'
set :bind, '0.0.0.0'

class Task
	attr_accessor :task,:task_completed,:id,:important,:urgent



	def initialize task, important, urgent, id
		@task = task
		@task_completed=false
		@id=id
		@important=important
		@urgent=urgent
	end

	def toggle_task 
		@task_completed=!@task_completed
	end

	def to_string
		"Task is : #{@task}, Completed : #{@complete}"
	end
end

tasks=[]
unique_id=0
get '/' do 
	erb :task, locals: {:tasks => tasks, :update => "false", :task_id => unique_id}
end

post '/add_tasks' do
	task = Task.new params[:task ],params[:important_or_not],params[:urgent_or_not], unique_id
	tasks << task
	unique_id=unique_id+1
	redirect '/'
end
post '/add_updated_task' do
	task_id=params[:task_id].to_i
	task = Task.new params[:task ],params[:important_or_not],params[:urgent_or_not], task_id
	tasks[task_id]=task
	redirect '/'
end

post '/remove_task' do
	task_id=params[:task_id]
	temp=task_id.to_i
	
	tasks.delete_at(temp)
	for i in temp..unique_id-2
		aaaatasks[i].id=i
	end
	unique_id=unique_id-1
	redirect '/'
end


post '/update_task' do 
	task_id=params[:task_id].to_i
	erb :task, locals: {:tasks => tasks,:update => "true", :task_id => task_id}
	end



post '/toggle_task' do
	tasks[params[:task_id].to_i].toggle_task
	redirect '/'
end
