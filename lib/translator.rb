require 'singleton'

require_relative 'configuration'

class Translator
  include Singleton
  include Configuration

  def translate(beat)
    (beat * CUBE_SIDE_LENGTH).round
  end
end
