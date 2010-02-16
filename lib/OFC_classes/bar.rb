module OpenFlashChart
  class Bar < Base
    @@color_index = 0
    PALETTE = ['B6C326', '832B9A', 'C47125', '2B6D9A', '7A9A2B', '9A2B58', 'C49125', '2B429A', '2B9A70', 'C44625', '4B2B9A', 'C4B125']
    def set_defaults
      @values = []
      @@color_index = PALETTE[@@color_index + 1].nil? ? 0 : @@color_index+1
      @colour = "##{PALETTE[@@color_index]}"
      @type = "bar_glass"
      @on_show = {:type => "pop-up", :cascade => 0.5}
    end

    def << arg
      @values << arg
    end

    def tip= arg
      @tip = arg
    end
  end
end
