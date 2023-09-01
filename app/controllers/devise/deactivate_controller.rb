class Devise::DeactivateController < DeviseController
  prepend_before_action :authenticate_deactivatee!

  # POST /resource/deactivate/:id
  def create
    if params[:id]
      @resource = User.find(params[:id])
    else
      @resource = current_deactivatee
    end

    @resource.deactivate! if @resource

    respond_to do |format|
      format.json { head :ok }
      format.any(*navigational_formats) { redirect_to after_deactivate_path_for(resource_name) }
    end
  end

  # POST /resource/reactivate/:id
  def destroy
    if params[:id]
      @resource = User.find(params[:id])
    else
      @resource = current_deactivatee
    end

    @resource.reactivate! if @resource

    respond_to do |format|
      format.json { head :ok }
      format.any(*navigational_formats) { redirect_to after_reactivate_path_for(resource_name) }
    end
  end

  def test
  end

  protected

  def current_deactivatee
    authenticate_deactivatee!
  end

  # The path used after deactivated
  def after_deactivate_path_for(resource_name)
    request.referer if is_navigational_format?
  end

  # The path used after reactivated
  def after_reactivate_path_for(resource_name)
    request.referer if is_navigational_format?
  end

end