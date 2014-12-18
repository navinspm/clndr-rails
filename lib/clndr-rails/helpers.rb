  module Helpers
    include ActionView::Helpers::UrlHelper
    def show_calendar(scope,*args)
      options = {}
      args.map{|x| options.merge! x}
      Clndr.get_calendar(scope.to_sym).view(options)
    end

    def next_month_link(scope,name,*args,&block)
      args.push(:onclick => "#{Clndr.get_calendar(scope.to_sym).name}.forward(#{'{withCallbacks: true}' if block_given?}); return false")
      options = {}
      args.map{|x| options.merge! x}
      link_to(name, '#', options )
    end

    def previous_month_link(scope,name,*args,&block)
      args.push(:onclick => "#{Clndr.get_calendar(scope.to_sym).name}.back(#{'{withCallbacks: true}' if block_given?}); return false")
      options = {}
      args.map{|x| options.merge! x}
      link_to(name, '#', options )
    end

    def next_year_link(scope,name,*args,&block)
      args.push(:onclick => "#{Clndr.get_calendar(scope.to_sym).name}.nextYear(#{'{withCallbacks: true}' if block_given?}); return false")
      options = {}
      args.map{|x| options.merge! x}
      link_to(name, '#', options )
    end

    def previous_year_link(scope,name,*args,&block)
      args.push(:onclick => "#{Clndr.get_calendar(scope.to_sym).name}.previousYear(#{'{withCallbacks: true}' if block_given?}); return false")
      options = {}
      args.map{|x| options.merge! x}
      link_to(name, '#', options )
    end

  end