library(stringr)

# Specify the path to the assembly-stats executable for this example I have it in the same directory as the script
assemblyStatsPath <- "./assembly-stats"

# Specify the path to the dataset file
lrDatasetFile <- "~/flye_assembly_output/pacbio_LR_30x_assembly/assembly.fasta"

# Defining a function to run assembly-stats
runAssemblyStats <- function(assemblyStatsPath, lrDatasetFile) {
  # This builds the command to run assembly-stats
  command <- paste(assemblyStatsPath, lrDatasetFile, sep=" ")
  
  # Run assembly-stats and capture the output
  output <- system(command, intern=TRUE)
  
  # This extracts the desired information from the output of assembly-stats
  totalBases <- as.numeric(str_extract(output[2], "(?<=sum\\s=\\s)\\d+"))
  numReads <- as.numeric(str_extract(output[2], "(?<=sum\\s=\\s)\\d+"))
  avgReadLength <- as.numeric(str_extract(output[2], "(?<=ave\\s=\\s)\\d+"))
  largestReadLength <- as.numeric(str_extract(output[2], "(?<=largest\\s=\\s)\\d+"))
  draftGenomeSize <- as.numeric(str_extract(output[2], "\\d+"))
  numContigs <- as.numeric(str_extract(output[2], "(?<=n\\s=\\s)\\d+"))
  largestContigLength <- as.numeric(str_extract(output[2], "(?<=largest\\s=\\s)\\d+"))
  nFifty <- as.numeric(str_extract(output[3], "(?<=N50\\s=\\s)\\d+"))
    
  # Makke the extracted info into a list
  return(list(
    totalBases = totalBases,
    numReads = numReads,
    avgReadLength = avgReadLength,
    largestReadLength = largestReadLength,
    draftGenomeSize = draftGenomeSize,
    numContigs = numContigs,
    largestContigLength = largestContigLength,
    nFifty = nFifty
  ))
}

# Run assembly-stats and output the extracted information for the dataset
result <- runAssemblyStats(assemblyStatsPath, lrDatasetFile)
