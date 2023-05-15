# Load the stringr package
library(stringr)

# Specify the path to the assembly-stats executable
assemblyStatsPath <- "./assembly-stats"

# Specify the path to the LR dataset file
lrDatasetFile <- "~/Assignment2/flye_assembly_output/pacbio_LR_30x_assembly/assembly.fasta"

# Define a function to run assembly-stats and extract information
runAssemblyStats <- function(assemblyStatsPath, lrDatasetFile) {
  # Build the command to run assembly-stats
  command <- paste(assemblyStatsPath, lrDatasetFile, sep=" ")
  
  # Run assembly-stats and capture the output
  output <- system(command, intern=TRUE)
  
  # Extract the desired information from the output
  totalBases <- as.numeric(str_extract(output[2], "(?<=sum\\s=\\s)\\d+"))
  numReads <- as.numeric(str_extract(output[2], "(?<=sum\\s=\\s)\\d+"))
  avgReadLength <- as.numeric(str_extract(output[2], "(?<=ave\\s=\\s)\\d+"))
  largestReadLength <- as.numeric(str_extract(output[2], "(?<=largest\\s=\\s)\\d+"))
  draftGenomeSize <- as.numeric(str_extract(output[2], "\\d+"))
  numContigs <- as.numeric(str_extract(output[2], "(?<=n\\s=\\s)\\d+"))
  largestContigLength <- as.numeric(str_extract(output[2], "(?<=largest\\s=\\s)\\d+"))
  nFifty <- as.numeric(str_extract(output[3], "(?<=N50\\s=\\s)\\d+"))
  nSixty <- as.numeric(str_extract(output[4], "(?<=N60\\s=\\s)\\d+"))
  nSeventy <- as.numeric(str_extract(output[5], "(?<=N70\\s=\\s)\\d+"))
  nEighty <- as.numeric(str_extract(output[6], "(?<=N80\\s=\\s)\\d+"))
  nNinety <- as.numeric(str_extract(output[7], "(?<=N90\\s=\\s)\\d+"))
  nHundred <- as.numeric(str_extract(output[8], "(?<=N100\\s=\\s)\\d+"))
  nCount <- as.numeric(str_extract(output[9], "(?<=N_count\\s=\\s)\\d+"))
  gapsAssem <- as.numeric(str_extract(output[10], "(?<=Gaps\\s=\\s)\\d+"))
    
  # Return the extracted information as a list
  return(list(
    totalBases = totalBases,
    numReads = numReads,
    avgReadLength = avgReadLength,
    largestReadLength = largestReadLength,
    draftGenomeSize = draftGenomeSize,
    numContigs = numContigs,
    largestContigLength = largestContigLength,
    nFifty = nFifty,
    nSixty = nSixty,
    nSeventy = nSeventy,
    nEighty = nEighty,
    nNinety = nNinety,
    nHundred = nHundred,
    nCount = nCount,
    gapsAssem = gapsAssem
  ))
}

# Run assembly-stats and extract information for the LR dataset
result <- runAssemblyStats(assemblyStatsPath, lrDatasetFile)

# Print the extracted information
cat("Total number of bases:", result$totalBases, "\n")
cat("Number of reads:", result$numReads, "\n")
cat("Average read length:", result$avgReadLength, "\n")
cat("Largest read length:", result$largestReadLength, "\n")
cat("Draft Genome Size:", result$draftGenomeSize, "\n")
cat("number of contigs:", result$numContigs, "\n")
cat("Largest Contig Length:", result$largestContigLength, "\n")
cat("N50:", result$nFifty, "\n")
cat("N60:", result$nSixty, "\n")
cat("N70:", result$nSeventy, "\n")
cat("N80:", result$nEighty, "\n")
cat("N90:", result$nNinety, "\n")
cat("N100:", result$nHundred, "\n")
cat("N count:", result$nCount, "\n")
cat("Gaps:", result$gapsAssem, "\n")
