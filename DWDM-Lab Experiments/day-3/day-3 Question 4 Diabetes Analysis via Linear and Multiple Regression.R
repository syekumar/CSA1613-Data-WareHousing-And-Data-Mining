# Requires diabetes.csv in your working directory or downloaded from Pima Indians Diabetes dataset
if (!file.exists("diabetes.csv")) {
  url <- "https://raw.githubusercontent.com/jbrownlee/Datasets/master/pima-indians-diabetes.data.csv"
  download.file(url, "diabetes.csv")
}

# Load Data
diabetes <- read.csv("diabetes.csv", header = FALSE)
colnames(diabetes) <- c("Pregnancies", "Glucose", "BloodPressure", "SkinThickness", 
                        "Insulin", "BMI", "DiabetesPedigree", "Age", "Outcome")

# 1. Simple Linear Regression: Outcome ~ Age
simple_lm <- lm(Outcome ~ Age, data = diabetes)
summary(simple_lm)

# Plot Linear Trend
plot(diabetes$Age, diabetes$Outcome, main="Diabetes Trend vs Age", xlab="Age", ylab="Diabetes Outcome")
abline(simple_lm, col="red", lwd=2)

# 2. Multiple Linear Regression: Outcome ~ Age + BMI + Glucose + BloodPressure
multi_lm <- lm(Outcome ~ Age + BMI + Glucose + BloodPressure, data = diabetes)
summary(multi_lm)