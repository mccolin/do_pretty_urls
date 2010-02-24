# THOSEKIDS
# DoPrettyUrls - initializer

require 'do_pretty_urls'
ActiveRecord::Base.class_eval do
  include ThoseKids::Do::PrettyUrls
end
