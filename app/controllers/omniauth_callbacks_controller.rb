# frozen_string_literal: true

class OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController

  def omniauth_success
    get_resource_from_auth_hash
    set_token_on_resource
    create_auth_params

    if confirmable_enabled?
      @resource.skip_confirmation!
    end

    sign_in(:user, @resource, store: false, bypass: false)

    @resource.save!

    yield @resource if block_given?

    if DeviseTokenAuth.cookie_enabled
      set_token_in_cookie(@resource, @token)
    end

    render json: { data: @resource, auth_params: @auth_params }

  rescue 
    return render json: {errors: ["Houve um problema ao processar sua requisição"]}
  end
end
