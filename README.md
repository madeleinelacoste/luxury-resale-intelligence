# Luxury Resale Intelligence

An end-to-end analytics project exploring the factors associated with luxury resale listing prices using **SQL, Python, data visualization, and machine learning**, alongside a strategic analysis of the luxury resale market.

## Project Overview

The luxury resale market presents an interesting pricing challenge: two products in the same category can have dramatically different listing prices depending on factors such as designer, condition, material, product type, and customer engagement.

This project investigates the question:

**What product and listing characteristics are most associated with luxury resale listing prices, and how effectively can those characteristics be used to predict price?**

The project combines exploratory analysis, SQL, and machine learning using a public dataset of **10,409 Vestiaire Collective listings**.

## Tools & Technologies

- Python
- pandas
- NumPy
- Matplotlib
- scikit-learn
- SQL / Oracle SQL Developer
- Jupyter Notebook
- GitHub

## Dataset

The quantitative analysis uses a public dataset containing **10,409 luxury resale listings from Vestiaire Collective**.

Variables include:

- Designer
- Category and sub-category
- Listing price
- Condition
- Material
- Color
- Seller location
- Number of likes
- "We Love" designation
- Gender

The dataset represents a historical snapshot of listings and listing prices should not be interpreted as completed transaction prices.

## Exploratory Analysis

Initial analysis showed that listing prices are strongly right-skewed, with a median listing price of **$250** compared with an average of approximately **$411**.

Several patterns emerged:

- Bags had the highest median listing price among the major fashion categories analyzed.
- Within handbags, substantial price differences existed between designers.
- Chanel and Hermès had particularly high median handbag listing prices among designers with sufficient observations.
- Listings receiving more likes also tended to have higher listing prices, indicating an association between price and customer engagement.

These relationships are descriptive and should not be interpreted as causal.

## Machine Learning

Two regression approaches were evaluated to predict log-transformed listing price:

| Model | MAE | RMSE | R² |
|---|---:|---:|---:|
| Linear Regression | $182.07 | $468.42 | 0.552 |
| Random Forest | $174.61 | $452.37 | 0.586 |

The **Random Forest model produced lower prediction error and a higher R²** than the baseline linear regression model.

The model explained approximately **58.6% of the variation in log listing prices** in the held-out test data.

## Key Predictors

Grouped Random Forest feature importance indicated that the most influential characteristics were:

| Characteristic | Relative Importance |
|---|---:|
| Designer | 39.1% |
| Sub-category | 18.0% |
| Material | 7.5% |
| Color | 7.3% |
| Location | 7.2% |
| Condition | 6.5% |
| Number of Likes | 6.1% |
| Category | 5.2% |

Designer was the strongest predictor by a substantial margin, highlighting the importance of **designer brand in luxury resale listing pricing**.

Feature importance reflects predictive usefulness within this model and does not establish causal effects.

## Business Takeaways

The analysis suggests that luxury resale pricing is shaped by a combination of **brand, product attributes, and marketplace engagement**.

For resale platforms, these findings demonstrate how marketplace data can support:

- Pricing recommendations
- Consignment valuation
- Inventory segmentation
- Merchandising strategy
- Customer demand analysis
- Data-driven pricing tools

At the same time, prediction errors—particularly for very high-priced listings—show that additional variables such as product model, rarity, age, retail price, and detailed item characteristics could improve pricing models.

## Repository Structure

```text
luxury-resale-intelligence/
│
├── notebooks/
│   └── vestiaire_price_analysis.ipynb
│
├── sql/
│   └── vestiaire_analysis.sql
│
└── README.md
```

## Project Components

### Python & Machine Learning

[`notebooks/vestiaire_price_analysis.ipynb`](notebooks/vestiaire_price_analysis.ipynb)

Contains data preparation, exploratory analysis, visualization, feature engineering, Linear Regression, Random Forest modeling, model evaluation, and feature-importance analysis.

### SQL Analysis

[`sql/vestiaire_analysis.sql`](sql/vestiaire_analysis.sql)

Contains SQL queries used to investigate the structure of the luxury resale marketplace and analyze listing prices across product and marketplace characteristics.

## Limitations

This analysis uses historical marketplace listing data rather than completed transaction data. Listing price therefore represents seller/platform asking price rather than confirmed resale value.

The dataset also does not capture every factor that may affect luxury resale pricing, including product rarity, exact model, original retail price, item age, authenticity-related attributes, or broader market conditions.

## Future Development

Potential extensions include hyperparameter tuning, additional machine-learning algorithms, category-specific pricing models, interactive dashboards, and incorporation of richer product-level attributes.

### Data Source

The dataset used in this project was originally collected from Vestiaire Collective as part of the open-source project *Decision Support for Pricing of Second-Hand Luxury Fashion Items* by GitHub user PeDiot.

Original project: [PeDiot/price_prediction_vestiaire_collective](https://github.com/PeDiot/price_prediction_vestiaire_collective)

The original project collected listing information from Vestiaire Collective through web scraping, including product price, designer, category, condition, material, color, seller location, and engagement information.

This portfolio project uses the dataset as the basis for an independent SQL, exploratory data analysis, and machine-learning workflow. The analysis, visualizations, SQL queries, model implementation, and business interpretation presented here were developed independently for this project.
