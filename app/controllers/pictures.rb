class Pictures < Application
  # provides :xml, :yaml, :js

  def index
    @pictures = Picture.all
    display @pictures
  end

  def show(id)
    @picture = Picture.get(id)
    raise NotFound unless @picture
    display @picture
  end

  def new
    only_provides :html
    @picture = Picture.new
    display @picture
  end

  def edit(id)
    only_provides :html
    @picture = Picture.get(id)
    raise NotFound unless @picture
    display @picture
  end

  def create(picture)
    @picture = Picture.new(picture)
    if @picture.save
      redirect resource(@picture), :message => {:notice => "Picture was successfully created"}
    else
      message[:error] = "Picture failed to be created"
      render :new
    end
  end

  def swf_upload
    only_provides :html
    @picture = Picture.new
    @picture.image = params[:Filedata]
    ## If the picture belongs to a user, uncomment this line
    ## @picture.user_id = session.user.id
    if @picture.save
      return "success"
    else
      return ""
    end
  end

  def update(id, picture)
    @picture = Picture.get(id)
    raise NotFound unless @picture
    if @picture.update_attributes(picture)
       redirect resource(@picture)
    else
      display @picture, :edit
    end
  end

  def destroy(id)
    @picture = Picture.get(id)
    raise NotFound unless @picture
    if @picture.destroy
      redirect resource(:pictures)
    else
      raise InternalServerError
    end
  end

end # Pictures
