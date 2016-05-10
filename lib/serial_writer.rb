require 'rubyserial'
require 'singleton'

require_relative 'configuration'

class SerialWriter
  include Singleton
  include Configuration

  def initialize
    @serial = Serial.new SERIAL_FILE, BAUD_RATE
    sleep INIT_DELAY
  end

  def write(string)
    @serial.write "#{string}\n"
  end
end
