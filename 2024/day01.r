# Read input from file


# Parse the input
system.time({
  input <- vroom::vroom("data/input01.txt",col_names = F)
  left <- input$X1
  right <- input$X4
})

# Function for part1
part1 <- function(left, right) {
  left_sorted <- sort(left)
  right_sorted <- sort(right)
  return(sum(abs(left_sorted - right_sorted)))
}

# Function for part2
part2 <- function(left, right) {
  counts <- table(right)
  return(sum(left * counts[as.character(left)],na.rm = T))
}

# Calculate and print results
system.time({
  cat("Part1:", part1(left, right), "\n")
})

system.time({
  cat("Part2:", part2(left, right), "\n")
})
