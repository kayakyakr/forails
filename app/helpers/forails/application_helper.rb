module Forails
  module ApplicationHelper
    def forails_location_breadcrumb
      parts = []
      
      if defined? @forum
        forum = @forum
      end
      
      if defined? @topic
        parts << "#{link_to @topic.name, @topic}" if @topic.persisted?
        forum = @topic.forum
      end
      
      ([forum] | forum.ancestors).each{|f| parts.unshift "#{link_to f.name, f}"} unless forum.nil?
      parts.unshift("#{link_to "Index", forums_path}")
      
      parts.each_with_index.map do |part, i|
        if i == parts.length - 1
          %{<span class="forails-major-link">#{part}</span>}
        else
          %{<span class="forails-minor-link">#{part}</span>}
        end
      end.join(" > ").html_safe
    end
  end
end
