class NotesController < ApplicationController

	before_filter :checklogedin
	before_filter :sadmin
	before_filter :ip_check

	def index
		@user = current_user()
		@note = Note.all
	end

	def new
		@user = current_user()
		@note = Note.new
	end

	def create
		@user = current_user()
		@note = Note.new(params[:note])
		if @note.save
			redirect_to @note
		else
			render :new
		end
	end

	def show
		@user = current_user()
		@note = Note.find(params[:id])

	end

	def edit
		@user = current_user()
		@note = Note.find(params[:id])

	end

	def update
		@user = current_user()
		@note = Note.find(params[:id])
		if @note.update_attributes(params[:note])
			redirect_to @note
		else
			render :edit
		end
	end

	def delete
		@user = current_user()
		@note = Note.find(params[:id])
	end

	def destroy
		@user = current_user()
		@note = Note.find(params[:id])
		@note.destroy
		redirect_to @note
	end

end
