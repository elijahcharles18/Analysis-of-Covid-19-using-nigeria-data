

# COVID-19 Data Analysis in Nigeria

## Overview
COVID-19 in Nigeria began with the first confirmed case on **February 27, 2020**. In response, the government implemented travel restrictions, lockdowns, and social distancing measures. By **mid-2023**, Nigeria had reported over **250,000 confirmed cases** and around **3,000 deaths**.

## Objective
The main objective of this analysis is to **investigate the differences in the total deaths due to COVID-19 across six regions in Nigeria**. The study uses statistical methods to determine whether the death rates vary significantly between regions and identifies regions with higher death tolls.

## Summary
An **ANOVA (Analysis of Variance)** test was conducted to determine if there are significant differences in total COVID-19 deaths across different regions. The results show significant differences between several regions. Further **Tukey's Honest Significant Differences (HSD)** test was performed to pinpoint which specific regions differ from one another in terms of COVID-19 death rates.

## Methodology

### 1. Data Collection
The dataset, `covid_df`, contains records of **total deaths attributed to COVID-19** across various regions of Nigeria. 

### 2. Data Preparation
The data was inspected for completeness and consistency. The primary variables of interest were:
- `total_death` (response variable)
- `region` (predictor variable)

### 3. Statistical Analysis
- **ANOVA** was used to assess whether there are statistically significant differences in the total death rates across regions.
- After finding significant results from the ANOVA, **Tukey’s HSD Post Hoc** analysis was conducted to identify which specific regions have significantly different death rates.

## ANOVA Results
The ANOVA table below presents the results of testing whether the total number of deaths significantly differs across the regions.

| **Source**     | **df** | **Sum Sq** | **Mean Sq** | **F Value** | **Pr(>F)** |
|----------------|--------|------------|-------------|-------------|------------|
| Region         | 5      | 1,786,769  | 357,354     | 91.22       | < 2e-16    |
| Residual       | 4094   | 16,038,541 | 3,918       |             |            |

- **F(5, 4094) = 91.22**, with a **p-value** of **< 2e-16**, which indicates strong evidence against the null hypothesis. Therefore, there are significant differences in the total deaths across the regions.

## Visual Presentation of Results

### Figure 1
The graph below shows that the **South West** region has the highest number of COVID-19 deaths compared to other regions.


![Total number of covid-19 deaths in Nigeria](https://github.com/elijahcharles18/Analysis-of-Covid-19-using-nigeria-data/raw/main/Total_number_of_covid-19_confirmed_in_nigeria.jpg)

*Figure 1: COVID-19 Deaths by Region in Nigeria*



### Figure 2
This graph highlights the **South West** region also having the highest number of confirmed COVID-19 cases.
![Total number of covid-19 confirmed in Nigeria](https://github.com/elijahcharles18/Analysis-of-Covid-19-using-nigeria-data/raw/main/Total_number_of_covid-19_confirmed_in_nigeria.jpg)

*Figure 2: COVID-19 Confirmed Cases by Region in Nigeria*

### Post Hoc Analysis Results

The Tukey HSD test results indicate which pairs of regions have statistically significant differences in COVID-19 death rates. Below are the pairwise comparisons:

| **Region Comparison**                   | **Difference (diff)** | **Lower Bound (lwr)** | **Upper Bound (upr)** | **p-value (p adj)** | **Interpretation**         |
|-----------------------------------------|-----------------------|-----------------------|-----------------------|---------------------|----------------------------|
| North East - North Central              | -10.12                | -19.57                | -0.66                 | 0.02795             | Reject null hypothesis     |
| North West - North Central              | -3.48                 | -12.54                | 5.58                  | 0.88302             | Accept null hypothesis     |
| South East - North Central              | -11.59                | -21.53                | -1.65                 | 0.01152             | Reject null hypothesis     |
| South South - North Central             | 19.14                 | 9.66                  | 28.61                 | 0.0000002           | Reject null hypothesis     |
| South West - North Central              | 48.65                 | 39.28                 | 58.03                 | 0.0000000           | Reject null hypothesis     |
| North West - North East                 | 6.63                  | -2.82                 | 16.08                 | 0.34154             | Accept null hypothesis     |
| South East - North East                 | -1.48                 | -11.77                | 8.82                  | 0.99854             | Accept null hypothesis     |
| South South - North East                | 29.25                 | 19.41                 | 39.10                 | 0.0000000           | Reject null hypothesis     |
| South West - North East                 | 58.77                 | 49.02                 | 68.52                 | 0.0000000           | Reject null hypothesis     |
| South East - North West                 | -8.11                 | -18.04                | 1.82                  | 0.18296             | Accept null hypothesis     |
| South South - North West                | 22.62                 | 13.16                 | 32.09                 | 0.0000000           | Reject null hypothesis     |
| South West - North West                 | 52.14                 | 42.78                 | 61.50                 | 0.0000000           | Reject null hypothesis     |
| South South - South East                | 30.73                 | 20.42                 | 41.04                 | 0.0000000           | Reject null hypothesis     |
| South West - South East                 | 60.25                 | 50.03                 | 70.46                 | 0.0000000           | Reject null hypothesis     |
| South West - South South                | 29.52                 | 19.75                 | 39.28                 | 0.0000000           | Reject null hypothesis     |

## Conclusion
The **ANOVA** and **Tukey's HSD Post Hoc analysis** results show significant differences in the mean COVID-19 death rates across the six regions in Nigeria. Specifically:
- The **South West** and **South South** regions have significantly higher death rates compared to other regions.
- The findings highlight the need for **targeted policy interventions** and **strategic resource allocation** to address the high death rates in these regions.

The analysis provides important insights for public health officials to allocate resources more effectively in regions with the highest death tolls, aiming to mitigate the impact of the pandemic.

---

This **README.md** file is a structured summary of your analysis, providing an overview, methodology, statistical analysis, results, and conclusion in a concise format. It is useful for sharing with colleagues or anyone reviewing your work, and can easily be expanded with additional visualizations or more detailed descriptions if needed.
