#TASK 1
#command to list all directories in Music
directories <- list.dirs("Music")
#count the number of forward sla
ct <- str_count(directories, "/")
#subsetting album directories from all subdirectories
albums <- directories[which(ct == 2)]

songs = c()
code.to.process = c()
for(album in albums){
  files <- list.files(album)
  num <- str_count(files, ".wav")
  songs <- files[which(num >= 1)]
  for (song in songs){
    location <- paste('"',list.dirs(album), list.files(song), '"', sep="")
    track_name <- str_sub(song, end = str_length(song)-4)S
    track_name <- paste(unlist(str_split(track_name, "-")), collapse = " ")
    split_album <- str_split(album, "/", simplify = T)
    json_filename <- paste(split_album[2], "-", split_album[3], "-", track_name, ".json", sep = "")
    cmd <- paste("streaming-extractor_music.exe", location, json_filename)
    code.to.process = c(code.to.process, cmd)
  }
}

writeLines(code.to.process, "batfile.txt")

# some fixes
# streaming-extractor_music.exe OfficeStuff Zip                                      OfficeStuff-Backpack-OfficeStuff Zip.json
# streaming-extractor_music.exe "Music/OfficeStuff/Backpack/01-OfficeStuff-Zip.wav" "OfficeStuff-Backpack-Zip.json"


