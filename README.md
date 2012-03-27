# Rails Admin

For original and complete informations, please refer to the [official repository's documentation](https://github.com/sferik/rails_admin).

## What's new?

Chugulu forked this project to implement Omniauth with Devise by default to allow people connect with their Google Apps account.

## How?

First, we had to adapt the model created while running `rails generate devise:install` (through the rails_admin generator) by adding the following:

    def self.find_for_open_id(access_token, signed_in_resource=nil)
      data = access_token.info
      if user = #{model_name.camelize}.where(:email => data['email']).first
        user
      end
    end

Then, we created a controller [`OmniauthCallbacksController`](https://github.com/ChuguluGames/rails_admin/tree/master/lib/generators/rails_admin/templates/controllers).

To know more about the development involved, you can go through the source. Almost everything starts [here](https://github.com/ChuguluGames/rails_admin/blob/master/lib/generators/rails_admin/install_generator.rb#L84).
