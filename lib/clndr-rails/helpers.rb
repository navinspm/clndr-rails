  module Helpers
    include ActionView::Helpers::UrlHelper

    # find calendar and call .view with options
    def show_calendar(scope,*args)
      options = {}
      args.map{|x| options.merge! x}
      Clndr.get_calendar(scope.to_sym).view(options)
    end

    # generate links for calendar
    def next_month_link(scope,name,*args,&block)
      navigate_link scope,name,'forward', *args, &block
    end

    def previous_month_link(scope,name,*args,&block)
      navigate_link scope,name,'back', *args, &block
    end

    def next_year_link(scope,name,*args,&block)
      navigate_link scope,name,'nextYear', *args, &block
    end

    def previous_year_link(scope,name,*args,&block)
      navigate_link scope,name,'previousYear', *args, &block
    end

    private

    def navigate_link(scope,name,jsmethod,*args,&block)
      args.push(:onclick => "#{Clndr.get_calendar(scope.to_sym).name}.#{jsmethod}(#{'{withCallbacks: true}' if block_given?}); return false")
      options = {}
      args.map{|x| options.merge! x}
      link_to(name, '#', options )
    end

  end