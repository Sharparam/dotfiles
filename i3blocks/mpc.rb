class MPC
  def initialize
    @mods = Hash[run[2].scan(/(\w+): (off|on)/).map do |m|
      [m.first.to_sym, m.last == 'on']
    end]
  end

  def [](mode)
    @mods[mode]
  end

  def available
    run.split("\n").size > 1
  end

  def status
    run.split("\n")[1].match(/^\[(\w+)\]/)[1].to_sym
  end

  def play
    run 'play'
  end

  def pause
    run 'pause'
  end

  def stop
    run 'stop'
  end

  def toggle
    run 'toggle'
  end

  def next
    run 'next'
  end

  def previous
    run 'previous'
  end

  def long
    run('-f [[%artist% - ]%title%[ (%album%)]]|[%file%]').split("\n").first
  end

  def short
    run('-f "%title%"').split("\n").first
  end

  def file
    run('-f "%file%"').split("\n").first
  end

  def to_s
    run.split("\n").first
  end

  private

  def run(command = '')
    `mpc #{command}`.strip
  end
end
