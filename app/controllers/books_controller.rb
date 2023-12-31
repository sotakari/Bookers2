class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def create
    @book = Book.new(book_params)
    @books = Book.all
    @book.user
    @book.user_id = current_user.id
    @user = current_user
    if @book.save
      flash[:notice] = "You have created book successfully"
      redirect_to "/books/#{@book.id}"
    else
      flash[:notice] = "error occurred"
      render :index
    end
  end

  def edit
    is_matching_login_user
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully"
      redirect_to book_path(@book.id)
    else
      flash[:notice] = "error occurred"
      render :edit
    end
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def show
    @book2 = Book.find(params[:id])
    @book = Book.new
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
    book = Book.find(params[:id])
    user = book.user
    unless user.id == current_user.id
      redirect_to books_path
    end
  end
end
