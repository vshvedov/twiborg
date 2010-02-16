module OpenFlashChart
  class XAxisLabels < Base
    def set_defaults
      @labels = []
      @colour = "#ffffff"
      @font_size = 10
    end

    def rotate= arg
      @rotate = arg
    end

    def labels= arg
      @labels = arg
    end

    def << arg
      @labels << arg
    end
  end
end
