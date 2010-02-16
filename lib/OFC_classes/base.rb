module OpenFlashChart
  class Base
    def initialize(args={})
      set_defaults
      args.each do |k,v|
        self.instance_variable_set("@#{k}", v)
      end
      # yield self if block_given?  # magic pen pattern
    end

    def to_s
      returning self.to_json2 do |output|
        %w(font_size dot_size outline_colour halo_size start_angle tick_height grid_colour tick_length no_labels label_colour gradient_fill fill_alpha on_click spoke_labels visible_steps key_on_click dot_style background_colour background_alpha on_show).each do |replace|
          output.gsub!(replace, replace.gsub("_", "-"))
        end
      end
    end

    def to_json2
      self.instance_values.to_json
    end    
  end
end
