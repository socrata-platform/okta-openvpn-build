# frozen_string_literal: true

require 'open-uri'
instance_eval(open('https://raw.githubusercontent.com/socrata-cookbooks/' \
                   'shared/master/files/Gemfile').read)

group :build do
  gem 'fpm-cookery'
  gem 'packagecloud-ruby', '~> 1.0'
end
