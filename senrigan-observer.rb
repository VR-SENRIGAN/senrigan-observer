require 'mqtt'
require 'arduino_firmata'
require 'yaml'

class SenriganObserver
  ARDUINO_PORT = '/dev/cu.usbmodem1411'

  def main(debug = false)
    network_config = YAML.load_file('./network_settings.yml')

    host = network_config.fetch('mqtt_host')
    port = network_config.fetch('mqtt_port')

    puts "Connect start. #{host}:#{port}"

    MQTT::Client.connect(remote_host: host, remote_port: port) do |client|

      client.publish('left_camera_url', network_config.fetch('left_camera_url'), retain=true)
      client.publish('right_camera_url', network_config.fetch('right_camera_url'), retain=true)

      client.get('pan') do |topic, message|
        puts "Move to #{message}"
        arduino.servo_write 2, message.to_i unless debug
      end
    end
    puts 'Connect end'
  end

  private

  def arduino
    @arduino ||= ArduinoFirmata.connect(ARDUINO_PORT)
  end
end

SenriganObserver.new.main ARGV.include? '-d'
