class SubsController < ApplicationController
  before_action :must_be_logged_in
  before_filter :moderator?, only: [:edit, :update]

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator = current_user

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def moderator?
    @sub = Sub.friendly.find_by(id: params[:id])
    redirect_to sub_url(@sub) unless @sub.moderator == current_user
  end

  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.friendly.find(params[:id])
    render :show
  end

  def edit
    @sub = Sub.friendly.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.friendly.find(params[:id])
    unless @sub.update_attributes(sub_params)
      flash[:errors] = @sub.errors.full_messages
    end
    redirect_to sub_url(@sub)
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
