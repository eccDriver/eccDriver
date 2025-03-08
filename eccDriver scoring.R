input_file_a="EDG information.txt"
input_file_b="STRING PPI information.txt"
input_file_c="DEG information.txt"
output_file="result.txt"

library(dplyr)
fileA <- read.table(input_file_a, header = FALSE, stringsAsFactors = FALSE)
fileB <- read.table(input_file_b, header = TRUE, stringsAsFactors = FALSE)
matching_rows1 <- fileB[fileB$protein1 %in% fileA$protein_ID, ]
column_vector1 <- matching_rows1$protein1
Degree <- table(column_vector1)
print(Degree)
fileC <- read.table(input_file_c, header = TRUE, stringsAsFactors = FALSE)
matching_rows2 <- fileB[fileB$protein2 %in% fileC$protein_ID, ]
column_vector2 <- matching_rows2$protein1
DIF_frequency <- table(column_vector2)
print(DIF_frequency)
colnames(DIF_frequency)[1] <- "protein2"
colnames(DIF_frequency)[2] <- "Freq"
DIF1_score <- DIF_frequency[DIF_frequency$protein2 %in% fileA$protein_ID, ]
df=left_join(matching_rows1, DIF_frequency, by = "protein2")
df_summary <- df %>%
  group_by(protein1) %>%
  summarise(total_score = sum(Freq, na.rm=TRUE))
print(df_summary)
missing_values <- is.na(df_summary)
df_summary[missing_values] <- 0
DIF2_score=df_summary
result <- Degree %>%
  left_join(DIF1_score, by = "protein1") %>%
  left_join(DIF2_score, by = "protein1")
write.table(result, file = output_file, sep = "\t", row.names = FALSE, col.names = TRUE, quote = FALSE)


