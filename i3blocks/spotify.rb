class Spotify
  def [](_)
    false
  end

  def available
    run('status') != 'Not available'
  end

  def status
    run('status').downcase.to_sym
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
    run 'play-pause'
  end

  def next
    run 'next'
  end

  def previous
    run 'previous'
  end

  def long
    data = metadata

    return file if data[:title].empty?

    output = data[:title]

    output = "#{data[:artist]} - #{output}" unless data[:artist].empty?
    output = "#{output} (#{data[:album]}" unless data[:album].empty?

    output
  end

  def short
    metadata[:title]
  end

  def file
    run 'metadata mpris:trackid'
  end

  def to_s
    data = metadata
    return data[:title] if data[:artist].empty?
    "#{data[:artist]} - #{data[:title]}"
  end

  private

  def run(command)
    `playerctl -p spotify #{command}`.strip
  end

  def artist
    run 'metadata artist'
  end

  def title
    run 'metadata title'
  end

  def album
    run 'metadata album'
  end

  def metadata
    {
      artist: artist.strip,
      title: title.strip,
      album: album.strip
    }
  end
end
