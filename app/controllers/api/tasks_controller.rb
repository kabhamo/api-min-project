class Api::TasksController < ApplicationController
	before_action :get_person, only: [:show, :update, :destroy, :create, :index]
	before_action :get_task, only: [:show, :update, :destroy]
	#TODO: type field return,create/update-fields can be nulls
	# render status correctly,rename methods and fields(addTask,etc...)
	def index
		begin
			@people = Person.find(params[:person_id])
		rescue Exception => e 
			render json: { error: 'A person with given id ' + params[:person_id] + ' does not exist.'}, status: 404
		else
			@people = Person.find(params[:person_id])
		   	@tasks = @person.tasks
		   	if ((params[:status]).nil?)
		   		render json: (format_collection @tasks), status: 200
	   		else
       			@ret = @tasks.where(status:(params[:status]))
	   			render json: (format_collection @ret), status: 200
   			end
		end
    end 

	def show
		@task = Task.find(params[:id])
	    render json:  (format_collection @task), status: 200
    end 

    def create
			if (params[:type].to_s == "Chore" || params[:type].to_s =="HomeWork")
				if (params[:type].to_s == "Chore")
					if ((params[:status].to_s == "Active" || params[:status].to_s == "Done" ||params[:status].to_s == "active" || params[:status].to_s == "done" || params[:status].nil?) && 
						(params[:size].to_s == "Small" || params[:size].to_s == "Medium" || params[:size].to_s == "Large"))
						@tasks = @person.tasks.create!(
		    			status: params[:status],
		    			description: params[:description],
		    			size: params[:size]
					)
						if (params[:status].nil?)
							@tasks=@tasks.update(status: "active")
						end
						if (params[:status].to_s == "Active")
							@tasks=@tasks.update(status: "active")
						end
						if (params[:status].to_s == "Done")
							@tasks=@tasks.update(status: "done")
						end
					render json:{ message: 'Task created and assigned successfully'}, status: 201
					else
						render json: { error: 'One of required fields is missing/incorrect data(IF)'}, status: 400
					end
				else
					if ((!params[:status].nil? || params[:status].to_s == "Active" || params[:status].to_s == "Done" || params[:status].to_s == "active" || params[:status].to_s == "done") && 
						!params[:dueDate].nil?)
						@tasks = @person.tasks.create!(
			    			status: params[:status],
			    			course: params[:course],
			    			details: params[:details],
			    			dueDate: params[:dueDate]
					)
					if (params[:status].nil?)
							@tasks=@tasks.update(status: "active")
						end
						if (params[:status].to_s == "Active")
							@tasks=@tasks.update(status: "active")
						end
						if (params[:status].to_s == "Done")
							@tasks=@tasks.update(status: "done")
						end
					render json:{ message: 'Task created and assigned successfully'}, status: 201
					else
						render json: { error: 'One of required fields is missing/incorrect data(NOT IF)'}, status: 400
					end
				end
			else
				render json: { error: 'type of task is incorrect,try again'}, status: 400
			end
    end 

    def update
       @tasks = @person.tasks.update(
		    status: params[:status],
		    description: params[:description]
		)
        render json:  (format_collection @task), status: 200

    end 

    def destroy
	    @tasks = Task.all 
	    @tasks = Task.find(params[:id])
	    @tasks.destroy
	    render json: @tasks
    end

   def get_task_by_id
		begin
			@task = Task.find(params[:id])
		rescue Exception => e 
			render json: { error: 'A task with the id ' + params[:id] + ' does not exist.'}, status: 404
		else
			@task = Task.find(params[:id])
    		render json: @task.attributes.delete_if { |k, v| v.nil? }.to_json , status: 200
			end
	end

	#def set_task_by_id
	#	begin
	#		@task = Task.find(params[:id])
	#	rescue Exception => e 
	#		render json: { error: 'A task with the id ' + params[:id] + ' does not exist(set_task).'}, status: 404
	#	else
	#		@task = Task.find(params[:id])
	#		if (@task.type.to_s == "Chore" && params[:type].to_s =="HomeWork")
	#			# disable all the fields
	#			@task=@task.update (type: params[:type],
	#				status: "active",
	#				description: nil,
	#				size: nil,
	#				course:params[:course],
	#				dueDate:params[:dueDate],
	#				details:params[:details])
	#		end
	#		if (@task.type.to_s == "HomeWork" && params[:type].to_s =="Chore")
	#			# disable all the fields
	#			@task=@task.update (type: params[:type],
	#				status: "active",
	#				description: params[:description],
	#				size: params[:size],
	#				course:nil,
	#				dueDate:nil,
	#				details:nil,)
	#		end
	#		if (params[:status].to_s == "Active" || params[:status].to_s == "active")
	#			@tasks=@tasks.update(status: "active")
	#		end
	#		if (params[:status].to_s == "Done" || params[:status].to_s == "done")
	#			@tasks=@tasks.update(status: "done")
	#		end
	#		render json: (format_collection @task), status: 200
	#	end
	#end

	def del_task_by_id
		begin
			@task = Task.find(params[:id])
		rescue Exception => e 
			render json: { error: 'A task with the id ' + params[:id] + ' does not exist.'}, status: 404
		else
			@task = Task.find(params[:id])
			@task.destroy
    		render json:  { message: 'Task removed successfully.'}, status: 200
		end
	end

	def get_owner_id
		begin
			@task = Task.find(params[:id])
		rescue Exception => e 
			render json: { error: 'A task with the id ' + params[:id] + ' does not exist.'}, status: 404
		else
			@task = Task.find(params[:id])
			render json: @task.owner_id, status: 200
		end
	end

	def set_owner_id
		begin
			@task = Task.find(params[:id])
		rescue Exception => e
			render json: { error: 'A task with the id ' + params[:id] + ' does not exist.'}, status: 404
		else
			post_data = request.body.read
			req = JSON.parse(post_data)
			@task.update(
				owner_id: req
			)
			render json: {message: 'task owner updated successfully.'}, status: 204
		end
	end

	def get_status
		begin
			@task = Task.find(params[:id])
		rescue Exception => e 
			render json: { error: 'A task with the id ' + params[:id] + ' does not exist.'}, status: 404
		else
			@task = Task.find(params[:id])
    		render json: @task.status , status: 200
		end
	end

	def set_status
		begin
			@task = Task.find(params[:id])
		rescue Exception => e 
			render json: { error: 'A task with the id ' + params[:id] + ' does not exist.'}, status: 404
		else 
			post_data = request.body.read
    		req = JSON.parse(post_data)
			if (req == "Active" || req == "Done")
				begin
					@task = @task.update(status: req)
				rescue Exception => e 
					render json: { error: 'An error occurred when update the task'}, status: 400
				else 
					render json: { message: 'task owner updated successfully.'}, status: 204
				end
			else
				render json: { error: 'Request contains data that make no sense.'}, status: 400
			end
		end
	end
    private
	  	def get_person
	  		begin
			@people = Person.find(params[:person_id])
			rescue Exception => e 
			render json: { error: 'A person with the id ' + params[:person_id] + ' does not exist.'}, status: 404
			else
			 @person = Person.find(params[:person_id])
			end
	   	end
   	def get_task
    		@task = @person.tasks.find(params[:id]) if @person
	end
	def format_collection obj_col
  		obj_col.as_json.each do |obj|
    	obj.reject! { |key, value| value.nil? }
  end
end
end
