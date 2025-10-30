
Project: Finance & Economics Analysis
Author: Adam Bendadda


1. Overview
--------------------------------------------------------------
This repository contains a complete data analysis project exploring 
the relationship between financial market indicators and 
macroeconomic variables.

The goal is to analyze how economic factors such as GDP growth, 
inflation, and unemployment impact stock market performance, 
volatility, and trading activity.

The project integrates SQL analytical queries, Python-based 
exploratory analysis, and a Power BI dashboard for visualization.

--------------------------------------------------------------
2. Files Included
--------------------------------------------------------------

1) finance_economics_dataset.csv
   → Raw dataset containing daily stock index data and economic variables.

2) finance_economics_dataset_enriched.csv
   → Processed dataset with calculated indicators such as:
      - Daily returns (ret_close_pct)
      - 30-day volatility (vol_30d)
      - GDP growth (%), Inflation (%), Unemployment (%)
      - Monthly and yearly breakdowns

3) finance_economics.ipynb
   → Python Jupyter Notebook performing:
      - Data cleaning and enrichment
      - Feature engineering
      - Statistical correlations
      - Visualizations (matplotlib, seaborn)
      - Export of enriched dataset for SQL and Power BI

4) finance_economics.sql
   → SQL analytical queries answering key business and economic questions:
      - Average and extreme daily returns per stock index
      - Volatility ranking (30-day rolling)
      - Return-to-volatility ratios
      - Yearly trends and macroeconomic correlations (GDP, inflation, unemployment)
      - Trading volume and seasonality patterns

5) finance_economics_dashboard.pbix
   → Power BI dashboard for interactive visualization of:
      - Performance of each stock index
      - GDP growth and inflation trends
      - Volatility evolution by year
      - Correlation matrices and KPI summaries

--------------------------------------------------------------
3. Analytical Questions Answered
--------------------------------------------------------------

1. What is the average performance of each stock index?
2. Which indices show the highest volatility over time?
3. How does GDP growth correlate with market returns?
4. What is the relationship between inflation and returns?
5. How do unemployment levels affect market volatility?
6. Which indices show the highest trading volume?
7. Which months are most active in terms of volume and volatility?

--------------------------------------------------------------
4. Tools & Technologies
--------------------------------------------------------------
- SQL (PostgreSQL)
- Python (Pandas, NumPy, Matplotlib, Seaborn)
- Power BI
- Excel / CSV data sources

--------------------------------------------------------------
5. Dataset Description
--------------------------------------------------------------
Variables include:
- stock_index (e.g. S&P500, NASDAQ, FTSE, CAC40)
- date, year, month
- close_price, trading_volume
- ret_close_pct (daily return %)
- vol_30d (30-day rolling volatility)
- gdp_growth_pct, inflation_rate_pct, unemployment_rate_pct

--------------------------------------------------------------
6. Key Insights
--------------------------------------------------------------
- High correlation between GDP growth and positive returns during stable inflation periods.
- Inflation above 6% correlates with lower or negative average returns.
- Volatility spikes during years with slower GDP growth and higher unemployment.
- Some indices (e.g. NASDAQ) show higher return-to-volatility ratios.
- Distinct seasonal patterns observed in trading volumes (stronger Q1/Q4).

--------------------------------------------------------------
7. Usage Instructions
--------------------------------------------------------------
1) Load the enriched CSV dataset into your SQL environment.
2) Execute finance_economics.sql to reproduce analytical results.
3) Explore visual results using the Power BI dashboard.
4) Use the notebook (finance_economics.ipynb) for deeper EDA and plots.

--------------------------------------------------------------
8. Author
--------------------------------------------------------------
Name: Adam Bendadda
Role: Data Analyst
Contact: adambendadda123@gmail.com
LinkedIn: https://www.linkedin.com/in/bendadda-adam-4b7b5124a/
GitHub: https://github.com/adambeen

--------------------------------------------------------------
9. License
--------------------------------------------------------------
This project is released under the MIT License.
You are free to reuse, modify, and distribute this material with proper credit.
==============================================================

