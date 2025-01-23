# Load necessary libraries
install.packages("dplyr")
install.packages("ggcorrplot")
install.packages("ggplot2")
install.packages("caret")
install.packages("randomForest")
install.packages("e1071")
library(e1071)
library(randomForest)
library(caret)
library(ggplot2)
library(ggcorrplot)
library(readr)
library(dplyr)

# Load the dataset
wine_data <- read_csv("wine_data/WineQT.csv", show_col_types = FALSE)

# Clean column names
colnames(wine_data) <- make.names(colnames(wine_data))

# Check for missing data
if (sum(is.na(wine_data)) > 0) {
  stop("Dataset contains missing values. Please handle them before proceeding.")
}

# Convert 'quality' to a categorical variable for classification
wine_data <- wine_data %>%
  mutate(quality_category = case_when(
    quality <= 5 ~ "low",
    quality == 6 ~ "medium",
    quality >= 7 ~ "high"
  ))

# Convert 'quality_category' to a factor
wine_data$quality_category <- factor(wine_data$quality_category)

# Scale numeric features (excluding 'Id') and retain 'quality_category'
wine_data_scaled <- wine_data %>%
  mutate(across(where(is.numeric), scale)) %>%
  select(-Id) %>%
  mutate(quality_category = wine_data$quality_category)

# Correlation plot (excluding non-numeric columns)
corr <- cor(wine_data_scaled %>% select(-quality, -quality_category))
ggcorrplot(corr, method = "circle")

# Boxplot of alcohol by quality category
ggplot(wine_data, aes(x = quality_category, y = alcohol)) +
  geom_boxplot() +
  labs(title = "Alcohol vs. Quality Category", x = "Quality Category", y = "Alcohol")

# Split data into training and testing sets (using 'quality_category' as the target)
set.seed(123)
trainIndex <- createDataPartition(wine_data$quality_category, p = 0.8, list = FALSE)
train_data <- wine_data[trainIndex, ]
test_data <- wine_data[-trainIndex, ]

# Train Random Forest model
rf_model <- randomForest(quality_category ~ . -quality -Id, data = train_data, ntree = 100)
print(rf_model)

# Train SVM model
svm_model <- svm(quality_category ~ . -quality -Id, data = train_data, kernel = "radial")
summary(svm_model)

# Random Forest predictions
rf_predictions <- predict(rf_model, test_data)

# SVM predictions
svm_predictions <- predict(svm_model, test_data)

# Ensure the levels of predictions and actual values match
test_data$quality_category <- factor(test_data$quality_category, levels = levels(rf_predictions))

# Evaluate Random Forest accuracy
rf_cm <- confusionMatrix(rf_predictions, test_data$quality_category)
print(rf_cm)

# Evaluate SVM accuracy
svm_cm <- confusionMatrix(svm_predictions, test_data$quality_category)
print(svm_cm)

# Save predictions to CSV
test_data$rf_predictions <- rf_predictions
test_data$svm_predictions <- svm_predictions
write_csv(test_data, "wine_predictions.csv")