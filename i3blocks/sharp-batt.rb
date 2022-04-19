#!/usr/bin/env ruby
# encoding: utf-8

require 'ostruct'

FA_LIGHTNING = "<span color='yellow'><span font='FontAwesome'>\uf0e7</span></span>"
FA_PLUG = "<span font='FontAwesome'>\uf1e6</span>"
FA_UNKNOWN = "<span font='FontAwesome'>\uf128</span>"

def color(percent)
  if percent < 10
    '#FF0000'
  elsif percent < 20
    '#FF3300'
  elsif percent < 30
    '#FF6600'
  elsif percent < 40
    '#FF9900'
  elsif percent < 50
    '#FFCC00'
  elsif percent < 60
    '#FFFF00'
  elsif percent < 70
    '#FFFF33'
  elsif percent < 80
    '#FFFF66'
  else
    '#FFFFFF'
  end
end

def batt_symbol(percent)
  if percent < 10
    "\uf244" # 
  elsif percent < 40
    "\uf243" # 
  elsif percent < 60
    "\uf242" # 
  elsif percent < 80
    "\uf241" # 
  else
    "\uf240" # 
  end
end

def batt_to_s(batteries, battery, short = false)
  output = battery[:status] == :charging ? (FA_LIGHTNING + ' ') : ''
  batt_color = batteries.all? { |b| b[:percent] < 10 } ? '#FFFFFF' : color(battery[:percent])
  if short
    output += "<span color='#{batt_color}' font='FontAwesome'>#{batt_symbol battery[:percent]}</span>"
  else
    output += "#{battery[:id]}: <span color='#{batt_color}'>#{battery[:percent]}%</span>"
    output += " #{battery[:hours].round 1}h" if [:discharging, :charging].include? battery[:status]
  end

  output
end

data = `acpi`

if not data
  puts "<span color='red'><span font='FontAwesome'>\uf00d \uf240</span></span>"
  puts "<span color='red'><span font='FontAwesome'>\uf00d \uf240</span></span>"
  exit 0
end

batteries = data.split("\n").map do |line|
  next unless line =~ /^Battery (\d+): ([^,]+), (\d+)%/

  data = { id: $1.to_i, status: $2.downcase.to_sym, percent: $3.to_i }

  case data[:status]
  when :charging
    data[:eta] = line.match(/(\d+:\d+:\d+) until charged/).to_a.last
  when :discharging
    data[:eta] = line.match(/(\d+:\d+:\d+) remaining/).to_a.last
  end

  if data[:eta]
    segs = data[:eta].split ':'
    data[:hours] = segs.first.to_f
    data[:hours] += segs[1].to_f / 60.0
  end

  data
end

charging = `acpi -a` =~ /^Adapter \d+: on-line$/

output = charging ? FA_PLUG + ' ' : ''
short_output = output

output += batteries.map { |batt| batt_to_s batteries, batt }.join ' '
short_output += batteries.map { |batt| batt_to_s batteries, batt, true}.join ' '

puts output
puts short_output

exit 33 if batteries.all? { |batt| batt[:percent] < 10 }
