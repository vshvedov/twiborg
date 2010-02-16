module OpenFlashChart
  class DotStyle < Base
    @@color_index = 0
    DOTS_PALETTE = ['B6C326', '832B9A', 'C47125', '2B6D9A', '7A9A2B', '9A2B58', 'C49125', '2B429A', '2B9A70', 'C44625', '4B2B9A', 'C4B125']
    DOTS_TYPES = ['anchor', 'anchor', 'anchor', 'solid-dot', 'hollow-dot', 'star']
    DOTS_ROTATIONS = [0, 45]
    DOTS_SIDES = [3, 4, 5, 6]
    DOTS_HOLLOW = [true, false]

    def set_defaults
      @@color_index = DOTS_PALETTE[@@color_index + 1].nil? ? 0 : @@color_index+1
      @colour = "##{DOTS_PALETTE[@@color_index]}"
      @type = DOTS_TYPES[rand(DOTS_TYPES.size)]
      @rotation = DOTS_ROTATIONS[rand(DOTS_ROTATIONS.size)]
      @sides = DOTS_SIDES[rand(DOTS_SIDES.size)]
      @dot_size = 4
      @alpha = 1
      @hollow = DOTS_HOLLOW[rand(DOTS_HOLLOW.size)]
      @background_alpha = 0.3
      @tip = '#x_label#:#val#'
      @width = 1
    end

    def tip= arg
      @tip = arg
    end
  end
end
