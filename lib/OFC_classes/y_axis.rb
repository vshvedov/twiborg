module OpenFlashChart
  class YAxis < Base
    def rorate_labels arg
      @labels[:rotate] = arg
    end

    def labels= arg
      @labels[:labels] = arg
    end

    def set_defaults
      @steps = 1
      @min = 0
      @max = 20
      @colour = '#999999'
      @grid_colour = '#333333'
      @labels = {
        :colour => '#ffffff'
      }
    end
  end
end