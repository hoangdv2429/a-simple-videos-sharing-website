class VideosController < ApplicationController
  before_action :set_video, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  impressionist :actions=>[:show,:index]
  # , unique: [:session_hash]

  #check sigin

  # GET view count
  def show
    @videos = Video.find
    impressionist(@videos)
    # impressionist(@videos, "unique view", :unique => [:session_hash])
 end

  # GET /videos or /videos.json
  def index
    @categories = Category.all

    if params[:category].present?
      @videos = Video.where(["category_id IN (?)", Category.where(["category LIKE ?","%#{params[:category]}%"]).pluck(:id)])
    end

    if params[:title].present?
      @videos = Video.where(["title LIKE ?","%#{params[:title]}%"])
    end

    cate = params[:cate]
    if !cate.nil?
      @videos = Video.where(:category_id => cate)
    end
    
    if cate == 'all'
      @videos = Video.all
    end

    if cate.nil? && params[:category].nil? && params[:title].nil?
      @videos = Video.all
    end
  end
  
  #myvideo
  def myVideo 
    # @video = current_user.Videos.all
    @videos = Video.all
   
  end
  

  # GET /videos/1 or /videos/1.json
  def show
    @comment = Comment.new
    @comments = Comment.all
  end

  

  # GET /videos/new 
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos or /videos.json
  def create
    # @user = User.find_by(id: current_user.id)
    
    @video = Video.new(video_params)
    # @video = @user.videos.build(video_params)
    # @video.id = current_user.id
    # @video = Video.new(params[:video])
    @video.user_id = current_user.id

    respond_to do |format|
      if @video.save
        format.html { redirect_to @video, notice: "Video was successfully created." }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1 or /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to @video, notice: "Video was successfully updated." }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1 or /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url, notice: "Video was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end
    
    # Only allow a list of trusted parameters through.
    def video_params
      params.require(:video).permit(:title, :category_id, :description, :clip, :thumbnail,:user_id)
    end
end
