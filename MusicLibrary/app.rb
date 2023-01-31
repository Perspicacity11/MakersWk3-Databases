require_relative 'lib/database_connection'
require_relative 'lib/album_repository'

DatabaseConnection.connect('music_library')

seed_sql = File.read('spec/seeds_music_library.sql')
connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library' })
connection.exec(seed_sql)

album_repo = AlbumRepository.new

album_repo.all.each do |album|
  p album
end