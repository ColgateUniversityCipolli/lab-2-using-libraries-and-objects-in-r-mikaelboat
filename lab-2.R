#TASK 1
#command to list all directories in Music
directories <- list.dirs("Music")
#count the number of forward slashes
ct <- str_count(directories, "/")
#sub-setting album directories from all sub-directories
albums <- directories[which(ct == 2)]

songs = c()
code.to.process = c()
for(album in albums){
  files <- list.files(album)
  num <- str_count(files, ".wav")
  songs <- files[which(num >= 1)]
  for (song in songs){
    location <- paste('"',list.dirs(album), song, '"', sep="")
    track_name <- str_sub(song, end = str_length(song)-4)
    track_name <- paste(track_name, sep = "-")
    split_album <- str_split(album, "/", simplify = T)
    json_filename <- paste(split_album[2], "-", split_album[3], "-", track_name, ".json", sep = "")
    cmd <- paste("streaming_extractor_music.exe", location, paste('"', json_filename, '"', sep = ""))
    code.to.process = c(code.to.process, cmd)
  }
}

writeLines(code.to.process, "batfile.txt")

files <- list.files()
file.name <- files[which(str_count(list.files(), ".json") >= 1)]
filename <- str_split(file.name, "-", simplify = T)

album <- filename[1]
artist <- filename[2]
track <- filename[3]

json_file <- fromJSON(file.name)

# some fixes
# streaming-extractor_music.exe OfficeStuff Zip                                      OfficeStuff-Backpack-OfficeStuff Zip.json
# streaming_extractor_music.exe "Music/OfficeStuff/Backpack/01-OfficeStuff-Zip.wav" "OfficeStuff-Backpack-Zip.json"


