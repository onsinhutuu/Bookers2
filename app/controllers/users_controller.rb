class UsersController < ApplicationController
	before_action :authenticate_user!,except: [:top]
	 def index
		  @user = current_user

	  	@users = User.all
	  	@book = Book.new
   end

   def create
   	   @user = current_user
		   @books = Book.all
		   @book = Book.new(book_params)
		   @book.user_id = current_user.id
		   if @book.save
		   	flash[:notice] = "Book was successfully created."
		   	redirect_to book_path(@book.id)
		   else
		   	render template: "books/index"
		   end
   end

    def show
		  # @book = Book.find(params[:id]
		  @book = Book.new
		  @user = User.find(params[:id])
		  @books = @user.books
		  #@book =  User.find(params[:id]).books
		  #@books = Book.all.where(user_id: @user.id)
    end

	  def edit
     @user = User.find(params[:id])
       if @user == current_user
     	 else
     	 	@user = current_user
     	  redirect_to user_path(@user.id)
     	 end
    end

    def update
       @user = User.find(params[:id])
  	   if @user.update(user_params)
  	   flash[:notice] = "You have updated user successfully."
  	   redirect_to user_path(@user.id)
       else
       render :edit
       end
    end

     def following
      @user  = User.find(params[:id])
      @users = @user.following
      render 'show_follow'
     end

     def followers
       @user  = User.find(params[:id])
       @users = @user.followers
       render 'show_follower'
     end


    def top
    end

    private

    def user_params
      params.require(:user).permit(:name, :profile_image, :introduction)
    end
end
