#' Compress and Save Data frame Code
#'
#' This function compresses a data.frame by removing spaces from column names and
#' formatting its `dput()` output for compact representation. The function can
#' also save the data.frame as an RDS or R script file. For more details, please visit https://github.com/agronomy4future/datazip
#'
#' @param df A dataframe to be compressed and optionally saved.
#' @param output A character string specifying the file path to save the output.
#'   If `NULL`, the compressed representation is printed to the console.
#'   Supported formats are `.rds` and `.r`.
#'
#' @return Returns the modified dataframe invisibly.
#'
#' @export
#'
#' @examples
#'if(!require(remotes)) install.packages("remotes")
#'if (!requireNamespace("datazip", quietly = TRUE)) {
#'    remotes::install_github("agronomy4future/datazip", force= TRUE)
#'}
#'library(remotes)
#'library(datazip)
#'
#' df= data.frame(x= 1:5, y= letters[1:5])
#' # convert data to code
#' datazip(df) # Print compressed representation
#' datazip(df, output="df1.rds") # Save as RDS
#' datazip(df, output="df2.r") # Save as R script
#'
#' # import code to data
#' df_loaded_rds= dataunzip("df1.rds")  # Load from RDS file
#' df_loaded_r= dataunzip("df2.r")      # Load from R script file
#' print(df_loaded_rds)
#' print(df_loaded_r)
datazip= function(df, output=NULL) {
  # Remove spaces from column names
  names(df)= gsub(" ", "", names(df))

  # Capture dput() output as text
  dput_text= capture.output(dput(df))

  # Remove newlines and collapse into one line
  dput_one_line= gsub("\n", "", paste(dput_text, collapse=""))

  # Remove spaces only between code elements (but not inside character strings)
  dput_one_line= gsub(", ", ",", dput_one_line)  # Remove spaces after commas
  dput_one_line= gsub(" = ", "=", dput_one_line)  # Remove spaces around equal signs

  if (!is.null(output)) {
    if (grepl("\\.rds$", output, ignore.case=TRUE)) {
      # Save as RDS file
      saveRDS(df, file=output)
      cat("Data saved as RDS file:", output, "\n")
    } else if (grepl("\\.r$", output, ignore.case=TRUE)) {
      # Save as R script file
      writeLines(dput_text, con=output)
      cat("Data saved as R script file:", output, "\n")
    } else {
      stop("Unsupported file format. Use '.rds' or '.r'.")
    }
  } else {
    # If no output, print to console
    cat(dput_one_line, "\n")
  }

  # Return the modified dataframe
  return(invisible(df))
}

# Function to load data from an RDS or R script file
dataunzip= function(output) {
  if (grepl("\\.rds$", output, ignore.case=TRUE)) {
    df_loaded= readRDS(file=output)
    cat("Data loaded from RDS file:", output, "\n")
  } else if (grepl("\\.r$", output, ignore.case=TRUE)) {
    df_loaded= dget(file=output)
    cat("Data loaded from R script file:", output, "\n")
  } else {
    stop("Unsupported file format. Use '.rds' or '.r'.")
  }
  return(df_loaded)
}
