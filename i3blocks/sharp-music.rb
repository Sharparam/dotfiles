#!/usr/bin/env ruby
# encoding: utf-8

ICONS = { playing: '', paused: '', stopped: '' }.freeze
MODS = { repeat: '', random: '', single: '', consume: '' }.freeze

def copy(s)
  require 'open3'
  Open3.popen2('xclip -sel c') { |i, _, _| i.write s }
end

def mpcf(f)
  `mpc -f "#{f}"`.split("\n").first
end

mouse = ENV['BLOCK_BUTTON'].to_i

mpc = `mpc`.split "\n"
mpc_short = `mpc -f "%title%"`.split "\n"

case mouse
when 2
  copy mpcf '[[%artist% - ]%title%[ (%album%)]]|[%file%]'
when 3
  copy mpcf '%file%'
end

# If we get less than 3 lines of output, it means playback is stopped
exit if mpc.size < 3

mods = Hash[mpc[2].scan(/(\w+): (off|on)/).map do |m|
  [m.first.to_sym, m.last == 'on']
end]

data = {
  now_playing: mpc[0],
  status: mpc[1].match(/^\[(\w+)\]/)[1].to_sym,
  mods: [:repeat, :random, :single, :consume].map { |m| MODS[m] if mods[m] }.compact.join(' ')
}

print "#{ICONS[data[:status]]} #{data[:now_playing]}"
print " #{data[:mods]}" if data[:mods].size > 0
puts "\n#{ICONS[data[:status]]} #{mpc_short[0]}"
puts '#a0a0a0' if data[:status] == :paused
