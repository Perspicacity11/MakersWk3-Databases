require_relative 'lib/database_connection'
require_relative 'lib/album_repository'

DatabaseConnection.connect('music_library')

# album_repository.all.each do |album|
#   p album.all
# end

album_repo = AlbumRepository.new

p album_repo.all