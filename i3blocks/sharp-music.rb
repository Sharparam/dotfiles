#!/usr/bin/env ruby
# encoding: utf-8

ICONS = { playing: '', paused: '', stopped: '' }.freeze

MODS = { repeat: '', random: '', single: '', consume: '' }.freeze

case ENV['BLOCK_BUTTON'].to_i
when 1 # Left mouse button
  `mpc next`
when 2 # Scroll click
  `mpc toggle`
when 3 # Right mouse button
  `mpc prev`
when 4 # Mouse 4 (?)
  `mpc volume +5`
when 5 # Mouse 5 (?)
  `mpc volume -5`
end

mpc = `mpc`.split "\n"

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
puts