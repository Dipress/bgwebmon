module Omniauthable
  extend ActiveSupport::Concern

  included do
    def self.from_omniauth auth
      user = User.where(email: auth.info.email).first_or_create do |user|
        user.name.blank? ? user.name = auth.info.nickname : true ;
        user.email.blank? ? user.email = auth.info.email : true ;
      end
      provider = Provider.where(uid: auth.uid, provider: auth.provider, name: auth.info.nickname).first
      provider.nil? ? user.providers.build(provider: auth.provider, uid: auth.uid, name: auth.info.nickname) : true;
      user
    end

    def self.new_with_session params, session
      if session['devise.user_attributes']
        new(session['devise.user_attributes'], without_protection: true) do |user|
          if params["providers_attributes"].nil?
            user.providers.build session['devise.provider_attributes'], without_protection: true
          end
          user.attributes = params
          #user.valid?
        end
      else
        super
      end
    end
  end
end