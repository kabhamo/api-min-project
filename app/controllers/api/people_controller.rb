class Api::PeopleController < ApplicationController
	def index
	   @people = Person.all 
	   render json: @people , status: 200
    end 

    def show
    	begin
			@people = Person.find(params[:id])
		rescue Exception => e 
			render json: { error: 'A person with the id ' + params[:id] + ' does not exist.'}, status: 404
		else
			 @people = Person.find(params[:id])
	    		render json: @people, status: 200
   		end 
	    # @people = Person.find(params[:id])
	    # render json: @people
    end 

    def create
    	if (!params[:email].nil?)
    		@unique = Person.where(email: (params[:email]))
			if (@unique!=[])
				render json: { error: 'email already in use'}, status: 400
			else
			@people = Person.create(
			    name: params[:name],
			    email: params[:email],
			    favoriteProgrammingLanguage: params[:favoriteProgrammingLanguage]
			)
			render json: @people, status: 200
			end
		else
			render json: { error: 'One of required fields is missing/incorrect data'}, status: 400
		end
    end 

    def update
        begin
			@people = Person.find(params[:id])
		rescue Exception => e 
			render json: { error: 'A person with the id ' + params[:id] + ' does not exist.'}, status: 404
		else
			 @people = Person.find(params[:id])
			 @unique = Person.where(email: (params[:email]))
			if (!params[:email].nil? && @unique!=[])
	        	@people.update(
		    	email: params[:email]
        		)
    		end
    		if (!params[:name].nil?)
	        	@people.update(
		    	name: params[:name]
        		)
        	end
			if (!params[:favoriteProgrammingLanguage].nil?)
	        	@people.update(
		    	favoriteProgrammingLanguage: params[:favoriteProgrammingLanguage]
        		)
    		end
	    		render json: @people, status: 200
   		end 
    end 

    def destroy
		#@people = Person.all 
		begin
			@people = Person.find(params[:id])
		rescue Exception => e 
			render json: {error: 'A person with id ' + params[:id] + ' does not exist.'}, status: 404
		else
			@tasks = @people.tasks.all
			if @tasks.size > 0
				@tasks.each do |i|
					@tasks.destroy(i.id)
				end
			end
			@people.destroy
			render json: {message: "Person removed successfully." }, status: 200
		end
	end
end
