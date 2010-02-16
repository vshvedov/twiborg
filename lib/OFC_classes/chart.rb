module OpenFlashChart
  class Chart < Base
    def << arg
      @elements << arg
    end

    def set_defaults
      @elements = []
      @y_axis = YAxis.new
      @x_axis = XAxis.new
      @bg_colour = '#161616'
    end

    def y_axis= arg
      @y_axis = arg
    end

    def x_axis= arg
      @x_axis = arg
    end

    def title= arg
      @title = arg
    end
  end
end
