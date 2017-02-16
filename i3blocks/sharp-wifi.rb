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

interface = ENV['BLOCK_INSTANCE'] || 'wlp4s0'

has_addr = `ip addr show #{interface}` =~ /inet6? ([^\/]+)\//

exit unless has_addr

address = $1

conf = `iwconfig #{interface}`

ssid = conf.match(/ESSID:"(.+)"\s*$/)[1].to_s

quality = conf.match(/Link Quality=(\d+)\//)[1].to_f

strength = ((quality / 70.0) * 100).round

long = "#{ssid}: #{address} #{strength}%"
short = "#{strength}%"

puts long
puts short
puts color strength
