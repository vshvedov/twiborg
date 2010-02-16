module OpenFlashChart
  class Line < Base
    @@color_index = 0
    LINES_PALETTE = ['F3FF6E', 'D254F5', 'FFB36E', '54B5F5', 'FFEE6E', '8154F5', 'FF8B6E', '54F5AF', 'FFD16E', '5477F5', 'F55498', 'C8F554']
    def set_defaults
      @values = []
      @@color_index = LINES_PALETTE[@@color_index + 1].nil? ? 0 : @@color_index+1
      @colour = "##{LINES_PALETTE[@@color_index]}"
      @type = "line"
      # @on_show = {:type => "drop", :cascade => 0.5, :delay => 0}
      @width = 3
      @font_size = 10
      @dot_style = DotStyle.new
    end

    def << arg
      @values << arg
    end

    def tip= arg
      @dot_style.tip = arg
    end
  end
end
