# Wine Quality Analysis and Prediction

## Overview

This repository contains an analysis of the wine quality dataset, utilizing R for data preprocessing, visualization, and machine learning models, and Tableau for interactive dashboards. The project predicts wine quality categories (low, medium, high) based on chemical features like alcohol, pH, and density.

---

## Dataset

The dataset used for this analysis is `WineQT.csv`, which includes the following columns:

1. `fixed acidity`
2. `volatile acidity`
3. `citric acid`
4. `residual sugar`
5. `chlorides`
6. `free sulfur dioxide`
7. `total sulfur dioxide`
8. `density`
9. `pH`
10. `sulphates`
11. `alcohol`
12. `quality` (Numeric rating of wine)
13. `Id` (Row identifier)

The dataset has been preprocessed and used to predict wine quality categories: **low**, **medium**, or **high**.

---

## R Code Explanation

### 1. **Data Preprocessing**

- Cleaned column names for consistency.
- Checked for missing data.
- Converted the numeric column `quality` into a categorical variable `quality_category` for classification tasks.

### 2. **Data Transformation**

- Scaled numeric features to normalize the data.
- Created a correlation matrix to explore relationships between features.

### 3. **Visualization**

- Generated a **correlation plot** (using `ggcorrplot`) to highlight relationships between numeric features.
- Created a **boxplot** to show the distribution of alcohol content across wine quality categories.

### 4. **Model Training**

- Split the dataset into training and testing subsets.
- Trained two machine learning models:
  - **Random Forest** to predict `quality_category`.
  - **Support Vector Machine (SVM)** for comparison.

### 5. **Evaluation**

- Evaluated both models using confusion matrices.
- Saved predictions to a CSV file (`wine_predictions.csv`) for further analysis.

---

## Visualizations

### R Visualizations

1. **Feature Correlation Matrix**:

   - Visualizes relationships between numeric features.
   - Helps identify which features are most correlated with wine quality.
   - ![Correlation Plot](wine1.png)

2. **Boxplot: Alcohol vs. Quality Category**:
   - Displays the variation in alcohol content across different wine quality categories.
   - Provides insights into how alcohol levels correlate with wine quality.

---

## Tableau Visualizations

The Tableau dashboards (`Wine_tableau.twbx` and `Wine_tableau.twb`) include the following visualizations:

1. **Bar Chart: Predicted vs. Actual Quality**:

   - Compares the distribution of predicted and actual wine quality categories.
   - Visualizes the performance of the machine learning models.

2. **Treemap**:

   - Displays the proportions of wines in each quality category, sized and colored by alcohol content.

3. **Boxplot**:

   - Represents the distribution of alcohol content across quality categories.

4. **Line Chart**:

   - Highlights trends in alcohol levels across wine quality categories.

5. **Interactive Filters**:
   - Filters allow users to drill down by features like `quality_category`, `alcohol`, or model predictions.

---

## Files Included

1. **Code**:

   - `wine_analysis.R`: R script for data analysis, model training, and visualization.

2. **Outputs**:

   - `wine_predictions.csv`: Contains predictions from the Random Forest and SVM models.

3. **Tableau Dashboards**:
   - `Wine_tableau.twbx`: Packaged Tableau workbook.
   - `Wine_tableau.twb`: Tableau workbook file.

---

## How to Run

### **1. Run the R Script**

- Install the necessary R packages:
  ```R
  install.packages(c("dplyr", "ggcorrplot", "ggplot2", "caret", "randomForest", "e1071"))
  ```
