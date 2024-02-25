class SessionsController < ApplicationController
    skip_before_action :authenticate_user!
    skip_before_action :verify_authenticity_token

    respond_to :json
    def create
        resource = User.find_by_email(params[:login])
        return head :unauthorized unless resource

        if resource.valid_password?(params[:password])
            sign_in("user", resource)
            signed_stream_name = Turbo::StreamsChannel.signed_stream_name("counters_json")
            render json: { success: true, stream: signed_stream_name }
            return
        end
        return head :unauthorized
    end
      
end  