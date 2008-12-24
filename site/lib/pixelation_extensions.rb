require 'sass'

module Sass::Script::Functions
  def color_step(from_color, to_color, percent)
    rgb = []
    for i in (0..2)
      f = from_color.value[i]
      t = to_color.value[i]
      p = percent.value.to_f
      if f > t
        f, t = t, f
        p = 1 - p
      end
      rgb[i] = (p * (t - f)).round
    end
    Sass::Script::Color.new(rgb)
  end
end