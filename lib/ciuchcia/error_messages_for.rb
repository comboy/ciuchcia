module ActiveRecord
  class Errors
    def full_messages
      full_messages = []
      @errors.each_key do |attr|
        @errors[attr].each do |msg|
          next if msg.nil?
          full_messages << msg
        end
      end
      full_messages
    end
  end
end

module ActionView
  module Helpers
    module ActiveRecordHelper
      
      def error_messages_for(object_name, options = {})
        options = options.symbolize_keys
        object = instance_variable_get("@#{object_name}")
        unless object.errors.empty?
          content_tag("div",
            content_tag(
              options[:header_tag] || "h2",
              # We could put here error numbers, you can use object.errors.count
              "Formularz nie został wysłany ponieważ zawiera błędy"
            ) +
            content_tag("p", "Wystąpiły następujące problemy:") +
            content_tag("ul", object.errors.full_messages.collect { |msg| content_tag("li", msg) }),
            "id" => options[:id] || "errorExplanation", "class" => options[:class] || "errorExplanation"
          )
        end
        
      end
    end
  end
end