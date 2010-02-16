module OpenFlashChart
  class Area < Base
    @@color_index = 0
    PALETTE = ['B6C326', '832B9A', 'C47125', '2B6D9A', '7A9A2B', '9A2B58', 'C49125', '2B429A', '2B9A70', 'C44625', '4B2B9A', 'C4B125']
    LINES_PALETTE = ['B6C326', '832B9A', 'C47125', '2B6D9A', '7A9A2B', '9A2B58', 'C49125', '2B429A', '2B9A70', 'C44625', '4B2B9A', 'C4B125']
    def set_defaults
      @values = []
      @@color_index = PALETTE[@@color_index + 1].nil? ? 0 : @@color_index+1
      @colour = "##{LINES_PALETTE[@@color_index]}"
      @fill = "##{PALETTE[@@color_index]}"
      @fill_alpha = 0.4
      @type = "area"
      @on_show = {:type => "pop-up", :cascade => 0.3, :delay => 0.5}
      @width = 3
      @font_size = 10
      @dot_style = DotStyle.new
    end

    def << arg
      @values << arg
    end

    def tip= arg
      @tip = arg
    end
  end
end
