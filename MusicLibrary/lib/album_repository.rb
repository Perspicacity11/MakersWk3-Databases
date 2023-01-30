require_relative 'album'

class AlbumRepository

    def all
        sql = 'SELECT title, release_year, artist_id FROM albums;'
        result_set = DatabaseConnection.exec_params(sql, [])

        albums = []

        result_set.each do |record|
            album = Album.new
            album.title = record['title']
            album.release_year = record['release_year']
            album.artist_id = record['artist_id']

            albums << album
        end
        return albums
    end

    def find(id)
        sql = "SELECT title, release_year, artist_id FROM albums WHERE id = $1"
        result_set = DatabaseConnection.exec_params(sql, [id])

        result_set.each do |record|
            album = Album.new
            album.title = record['title']
            album.release_year = record['release_year']
            album.artist_id = record['artist_id']
            return album
        end
    end

     def create(album)
        sql = "INSERT INTO albums (title, release_year, artist_id) VALUES('#{album.title}', #{album.release_year}, #{album.artist_id});"
        result_set = DatabaseConnection.exec_params(sql, [])
        return result_set
     end


    def update(album, column_name, new_value)
        sql = "UPDATE albums SET #{column_name} = #{new_value};"
        result_set = DatabaseConnection.exec_params(sql, [])
        return result_set
    end
       
    def delete(title)
        sql = "DELETE FROM albums WHERE title = '#{title}'"
        result_set = DatabaseConnection.exec_params(sql, [])
        return result_set
    end

end