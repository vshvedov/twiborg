module OpenFlashChart
  class Pie < Base
    PALETTE = ['B6C326', '832B9A', 'C47125', '2B6D9A', '7A9A2B', '9A2B58', 'C49125', '2B429A', '2B9A70', 'C44625', '4B2B9A', 'C4B125']
    def set_defaults
      @values = []
      @colours = PALETTE
      @type = "pie"
      @border = 2
      @animate = [ {:type => "bounce", :distance => 10}, { :type => "fade" }]
      @tip = '#label#<br>#val# из #total# (#percent#)'
      @gradient_fill = false
      @fill_alpha = 1.0
      @label_colour = '#000000'
    end

    def << arg
      @values << arg
    end

    def tip= arg
      @tip = arg
    end
  end
end
