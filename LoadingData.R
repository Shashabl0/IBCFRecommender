# downloading and Loading CSV


#url = "http://www2.informatik.uni-freiburg.de/~cziegler/BX/BX-CSV-Dump.zip"  #URL of the file
download.file(url, destfile="downloadfilename.zip")
dir.create("data")  #directory created
unzip("filename.zip",exdir="data")

files = paste0("data/",list.files("data"))


ratings = read.csv2(files[1],sep = ";")
books = read.csv2(files[2],sep=";")
users = read.csv2(files[3],sep=";")

