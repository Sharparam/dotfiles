#!/usr/bin/env ruby

def color(percent)
  if percent < 40
    '#FF0000'
  elsif percent < 60
    '#FFAE00'
  elsif percent < 80
    '#FFF600'
  else
    '#00FF00'
  end
end

def get_addr(interface)
  has_addr = `ip -color=never addr show #{interface}` =~ /inet6? ([^\/]+)\//
  has_addr ? $1 : nil
end

def get_wifi_data(interface)
  conf = `iwconfig #{interface} 2>/dev/null`
  has_ssid = conf =~ /ESSID:"(.+)"\s*$/
  if has_ssid
    ssid = $1
    quality, max_quality = conf.match(/Link Quality=(\d+)\/(\d+)/).to_a[1..2].map(&:to_f)
    strength = ((quality / max_quality) * 100).round
    {
      ssid: ssid,
      strength: strength
    }
  else
    {
      ssid: interface,
      strength: nil
    }
  end
end

def get_data(interface)
  addr = get_addr(interface)
  return nil unless addr
  wifi_data = get_wifi_data(interface)
  {
    address: addr,
    ssid: wifi_data[:ssid],
    strength: wifi_data[:strength]
  }
end

interfaces = ENV['BLOCK_INSTANCE']&.split(',') || %w[wlp4s0]

data = interfaces.map { |i| get_data(i) }.compact.first

exit if data.nil?

address = data[:address]
ssid = data[:ssid]
strength = data[:strength]

if strength
  long = "#{ssid}: #{address} #{strength}%"
else
  long = "#{ssid}: #{address}"
end
short = "#{strength || 100}%"

if ENV['BLOCK_BUTTON'].to_i == 2
  require 'open3'
  Open3.popen2('xclip -sel c') { |i, _, _| i.write address }
end

puts long
puts short
puts color strength if strength
