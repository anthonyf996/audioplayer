#!/bin/bash

next_song_id=1

for song in ../content/mp3/*mp3
do
	if [ ! -f "${song}" ]
	then
		continue
	fi
	song_name="${song%.mp3}"
	song_name=$(basename "${song_name}")
	artworkPath=$(find ../content/images/ -name "${song_name}.???")
	if [ -z "${artworkPath}" ]
	then
		artworkPath=$(find ../content/images/ -name "${song_name}.????")
	fi
	sqlite3 database.db "INSERT INTO Songs VALUES(${next_song_id});"
	sqlite3 database.db "INSERT INTO SongAttributes VALUES(${next_song_id}, \"title\", \"${song_name}\");"
	sqlite3 database.db "INSERT INTO SongAttributes VALUES(${next_song_id}, \"songPath\", \"../${song}\");"
	if [ ! -z "${artworkPath}" ]
	then
		sqlite3 database.db "INSERT INTO SongAttributes VALUES(${next_song_id}, \"artworkPath\", \"../${artworkPath}\");"
	fi
	next_song_id=$((next_song_id + 1))
done
