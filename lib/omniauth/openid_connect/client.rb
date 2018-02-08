require 'openid_connect'

module OmniAuth
  module OpenIDConnect
    class Client < ::OpenIDConnect::Client
      def initialize(attributes = {})
        super attributes
        @send_scope = attributes[:send_scope]
      end

      def authorization_uri(params = {})
        post_processed_authorization_url(super(params))
      end

      private

      def post_processed_authorization_url(url)
        return url if @send_scope

        url.sub(/\?scope=[^&]*/, '?')
          .sub(/\&scope=[^&]*/, '')
          .sub(/\?$/,'')
      end
    end
  end
end
