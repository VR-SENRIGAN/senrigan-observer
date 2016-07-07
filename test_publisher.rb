require 'mqtt'
require 'yaml'

network_config = YAML.load_file('./network_settings.yml')

host = network_config.fetch('mqtt_host')
port = network_config.fetch('mqtt_port')

MQTT::Client.connect(:remote_host => host, :remote_port => port) do |client|
  while true
    sleep(1)
    client.publish('pan', 'Hello, VR-SENRIGAN!')
    puts "publish to ${host}:${port} "
  end
end
