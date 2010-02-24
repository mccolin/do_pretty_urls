# THOSEKIDS
# DoPrettyUrls - meat and potatoes

module ThoseKids
  module Do
    module PrettyUrls
      def self.included(mod)
        mod.extend(ClassMethods)
      end
      
      # Helper methods for the ActiveRecord class implementing PrettyUrls
      module ClassMethods
        
        # Class-level initializer
        # * +column+ - specifies the column to use for vanity URL generation 
        # * +value+ - can be specified instead of column for almagamations
        def do_pretty_urls(options={})
          options = {:column=>'name', :value=>nil}.merge(options)
          
          class_eval <<-EOV
            include ThoseKids::Do::PrettyUrls::InstanceMethods
            
            def vanity_column
              '#{options[:column]}'
            end
            
            def vanity_name
              "#{options[:value]}".empty? ? nil : "#{options[:value]}"
            end
          EOV
        end
        
      end


      # Instance methods for use by the ActiveRecord class id/URL-generator
      module InstanceMethods
        # Override default to_param for pretty URLs
        def to_param
          if vanity_name
            "#{id}-#{vanity_name.downcase.gsub(/[^a-z1-9]+/i, '-')}"
          else
            "#{id}-#{(send vanity_column).downcase.gsub(/[^a-z1-9]+/i, '-')}"
          end
        end
      end
      
    end
  end
end

