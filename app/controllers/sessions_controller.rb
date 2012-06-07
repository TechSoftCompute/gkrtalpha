class SessionsController < Devise::SessionsController
  #include Devise::Controllers::InternalHelpers
  skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate_user!
  prepend_before_filter :require_no_authentication, :only => [ :newsession, :login ]
  prepend_before_filter :allow_params_authentication!, :only => :login
 
  def newsession
    resource = build_resource    
    clean_up_passwords(resource)
    respond_to do |format|
      format.json {render :json => resource}
    end
  end
  
  def login
    auth_options =  {:scope => :user, :recall =>"sessions#newsession"}
    resource = warden.authenticate!(auth_options)
   # set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    r_s = user_signed_in? ? '{"a":1}' : '{"a":0}'
    puts r_s
    respond_to do |f|
      f.json { render json: r_s, :callback => params[:callback] }
    end
  #  respond_with resource, :location => after_sign_in_path_for(resource)
  end

  def destroy
    super
  end


end
