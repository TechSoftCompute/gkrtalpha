class ProductsController < ApplicationController
  # GET /products
  # GET /products.json
  def index
    @products = params[:order].blank? ? Product.few_products(:offset=>0) : Product.few_products(:offset=>0,:order=>params[:order])
    if params[:category].blank? || params[:category] == "all"
      @favourite_products = Product.all.sort{|a,b| a.liked_percentage <=> b.liked_percentage}
    else
      category = Category.find(:first,:conditions=>"name ilike '%#{params[:category]}%'")
      @favourite_products = category.blank? ? [] : category.products
    end
    @products_for_modal = [@products,@favourite_products].flatten.compact.uniq
    @comment = Comment.new
    @categories = Category.all
    @category = Category.new

    respond_to do |format|
      format.html # index.html.erb
      format.js#on { render json: @products }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new
    @product.creator_id = current_user.id if current_user

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html { redirect_to products_path, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to products_path, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  def few_more_products
    @comment = Comment.new
    @products = Product.few_products(:offset=>params[:step].to_i,:order=>params[:order])
    @products_for_modal = @products
    respond_to do |format|
      format.js
    end
  end

  def like_product
    @product = Product.find(params[:id])
    like = params[:like] == "liked" ? @product.liked.to_i : @product.disliked.to_i
    @product.update_attribute(params[:like],like + 1)
    respond_to do |format|
      format.js
    end
  end
end
