## require library GenomicRanges
path <- "C:/Users/nhadad/Desktop/LauraSINECov/Test"
fs <- list.files(path, pattern = glob2rx("*.bed")) ## list all files end with bed
for (f in fs) {
  fname <- file.path(path, f)                     ## assign a path to each file
  df <- read.table(fname)[,1:4]  						  ## read genome files
  sine = read.table("Afrosine_insertion.txt")		## read SINE location - notice I changed the ext to txt so it won't read it
  sine$id = as.factor(paste("sine",1:nrow(sine), sep = "_"))  ## assign names to each sine
  colnames(df)=c("chr","start","end","meth")	## rename columns for convenience
  colnames(sine)=c("chr","start","end","id")
  sine.gr=with(sine,GRanges(chr,IRanges(start,end,names = id)))  ## convert to grange object
  df.gr=with(df,GRanges(chr,IRanges(start,end,names = meth)))	## convert to grange object
  overlap=findOverlaps(sine.gr,df.gr)	## overlap regions with granges
  matchedsites=data.frame(names(sine.gr)[queryHits(overlap)],names(df.gr)[subjectHits(overlap)],stringsAsFactors = F) ## get overlapping sites
  colnames(matchedsites)=c("id","meth") 	## rename columns 
  x = aggregate(as.numeric(meth) ~ id, matchedsites, sum)	## sum all sites matching a specific index
  colnames(x) = c("id","cov")	
  x$cov = x$cov/172	## divide by 172
  x = merge(sine, a_dat_mean, by = "id")	## merge with SINE file by id to get coordinates
  #
  write.table(x,paste(fname,"CoveragePerSINE.txt", sep = "_"),
              append = F,quote = F,
              sep = "\t",row.names = F
              ,col.names = F)                     ## write it 
