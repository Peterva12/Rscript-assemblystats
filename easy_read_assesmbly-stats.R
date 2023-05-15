library(stringr)

# Specify the path to the assembly-stats executable in this example its in the same directory as the script
assemblyStatsPath <- "./assembly-stats"

# Specify the path to the dataset file
lrDatasetFile <- "~/flye_assembly_output/pacbio_LR_30x_assembly/assembly.fasta"

# Define a function to run assembly-stats and extract information
runAssemblyStats <- function(assemblyStatsPath, lrDatasetFile) {
  # Build the command to run assembly-stats
  command <- paste(assemblyStatsPath, lrDatasetFile, sep=" ")
  
  # Run assembly-stats and capture the output
  output <- system(command, intern=TRUE)
  
  # Extract the desired information from the assembly-stats output
  totalBases <- as.numeric(str_extract(output[2], "(?<=sum\\s=\\s)\\d+"))
  numReads <- as.numeric(str_extract(output[2], "(?<=sum\\s=\\s)\\d+"))
  avgReadLength <- as.numeric(str_extract(output[2], "(?<=ave\\s=\\s)\\d+"))
  largestReadLength <- as.numeric(str_extract(output[2], "(?<=largest\\s=\\s)\\d+"))
  draftGenomeSize <- as.numeric(str_extract(output[2], "\\d+"))
  numContigs <- as.numeric(str_extract(output[2], "(?<=n\\s=\\s)\\d+"))
  largestContigLength <- as.numeric(str_extract(output[2], "(?<=largest\\s=\\s)\\d+"))
  
  nFifty <- as.numeric(str_extract(output[3], "(?<=N50\\s=\\s)\\d+"))
  nFiftyContig <- as.numeric(str_extract(output[3], "(?<=n\\s=\\s)\\d+"))
  
  nSixty <- as.numeric(str_extract(output[4], "(?<=N60\\s=\\s)\\d+"))
  nSixtyContig <- as.numeric(str_extract(output[4], "(?<=n\\s=\\s)\\d+"))
  
  nSeventy <- as.numeric(str_extract(output[5], "(?<=N70\\s=\\s)\\d+"))
  nSeventyContig <- as.numeric(str_extract(output[5], "(?<=n\\s=\\s)\\d+"))
  
  nEighty <- as.numeric(str_extract(output[6], "(?<=N80\\s=\\s)\\d+"))
  nEightyContig <- as.numeric(str_extract(output[6], "(?<=n\\s=\\s)\\d+"))
  
  nNinety <- as.numeric(str_extract(output[7], "(?<=N90\\s=\\s)\\d+"))
  nNinetyContig <- as.numeric(str_extract(output[7], "(?<=n\\s=\\s)\\d+"))
  
  nHundred <- as.numeric(str_extract(output[8], "(?<=N100\\s=\\s)\\d+"))
  nHundredContig <- as.numeric(str_extract(output[8], "(?<=n\\s=\\s)\\d+"))
  
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
    nFiftyContig = nFiftyContig,
    nSixty = nSixty,
    nSixtyContig = nSixtyContig,
    nSeventy = nSeventy,
    nSeventyContig = nSeventyContig,
    nEighty = nEighty,
    nEightyContig = nEightyContig,
    nNinety = nNinety,
    nNinetyContig = nNinetyContig,
    nHundred = nHundred,
    nHundredContig = nHundredContig,
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
cat("N50:", result$nFifty, "n:", result$nFiftyContig, "\n")
cat("N60:", result$nSixty, "n:", result$nSixtyContig, "\n")
cat("N70:", result$nSeventy, "n:", result$nSeventyContig, "\n")
cat("N80:", result$nEighty, "n:", result$nEightyContig, "\n")
cat("N90:", result$nNinety, "n:", result$nNinetyContig, "\n")
cat("N100:", result$nHundred, "n:", result$nHundredContig, "\n")
cat("N count:", result$nCount, "\n")
cat("Gaps:", result$gapsAssem, "\n")
