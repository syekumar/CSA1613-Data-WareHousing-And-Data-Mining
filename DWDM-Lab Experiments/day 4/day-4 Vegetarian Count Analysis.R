veg_data <- data.frame(
  Person = c("Gopu", "Babu", "Baby", "Gopa1", "Krishna", "Jai", "DeV", "Malini", "Hema", "Anu"),
  Vegetarian = c("yes", "yes", "yes", "no", "yes", "no", "no", "yes", "yes", "yes")
)

# Counts
counts <- table(veg_data$Vegetarian)
print(counts)

# Comparison
if(counts["yes"] > counts["no"]) {
  cat("Vegetarians are greater in number:", counts["yes"])
} else {
  cat("Non-Vegetarians are greater in number:", counts["no"])
}