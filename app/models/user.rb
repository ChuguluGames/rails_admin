module RailsAdmin
  class User < ActiveRecord::Base
    devise :omniauthable

    def self.find_for_open_id(access_token, signed_in_resource = nil)
      data = access_token.info
      if user = User.where(:email => data['email']).first
        user
      else
        User.create!(:email => data['email'], :password => Devise.friendly_token[0,20])
      end
    end
  end
end
