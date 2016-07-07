require 'mqtt'
require 'yaml'

network_config = YAML.load_file('./network_settings.yml')

host = network_config.fetch('mqtt_host')
port = network_config.fetch('mqtt_port')

MQTT::Client.connect(:remote_host => host, :remote_port => port) do |client|
  left_topic, left_camera_url = client.get('left_camera_url')
  puts "#{left_topic}:#{left_camera_url}"
  
  right_topic, right_camera_url = client.get('right_camera_url')
  puts "#{right_topic}:#{right_camera_url}"
end
