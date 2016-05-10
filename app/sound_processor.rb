require 'ruby-processing'

$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/../lib"

require 'configuration'
require 'translator'
require 'serial_writer'

class SoundProcessor < Processing::App
  include Configuration

  load_library "minim"
  import "ddf.minim"
  import "ddf.minim.analysis"

  def setup
    @minim = Minim.new self
    @input = @minim.get_line_in
    @beat = BeatDetect.new @input.mix.size, SAMPLING_FREQUENCY
    @beat_value = 0.001
    @beat.set_sensitivity BEAT_SENSITIVITY
  end

  def draw
    process_beat
    SerialWriter.instance.write(Translator.instance.translate(@beat_value))
  end

  private

  def process_beat
    @beat.detect @input.mix
    @beat_value = @beat.is_kick ? 1 : @beat_value * 0.95
  end
end

SoundProcessor.new
