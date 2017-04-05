#!/usr/bin/env ruby
# encoding: utf-8

require_relative 'mpc'
require_relative 'spotify'

PLAYER = [MPC.new, Spotify.new].find { |p| p.available }

exit unless PLAYER

if ARGV.first
  case ARGV.first
  when 'toggle'
    PLAYER.toggle
  when 'next'
    PLAYER.next
  when 'previous'
    PLAYER.previous
  else
    abort 'Invalid option'
  end
  exit
end

ICONS = { playing: '', paused: '', stopped: '' }.freeze
MODS = { repeat: '', random: '', single: '', consume: '' }.freeze

def copy(s)
  require 'open3'
  Open3.popen2('xclip -sel c') { |i, o, w| i << s }
end

case ENV['BLOCK_BUTTON'].to_i
when 2
  copy PLAYER.long
when 3
  copy PLAYER.file
end

mods = [:repeat, :random, :single, :consume].map { |m| MODS[m] if PLAYER[m] }.compact.join(' ')

print "#{ICONS[PLAYER.status]} #{PLAYER}"
print " #{mods}" if mods.size > 0
puts "\n#{ICONS[PLAYER.status]} #{PLAYER.short}"
puts '#a0a0a0' if PLAYER.status == :paused
