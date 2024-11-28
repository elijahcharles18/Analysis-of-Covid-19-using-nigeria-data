# Loading the required libraries

reticulate::py_config()
{
  library(janitor)
  library(dplyr)
  library(tidyr)
  library(BSDA)
  library(stringr)
  library(ggplot2)
  library(scales)
  library(tidyverse)
  library(tidygeocoder)
  library(mapview)
  library(plotly)
  library(sf)
  library(magrittr)
  library(usethis)
  library(leaflet)
  library(shiny)
  library(lubridate)
  library(DT)
  library(janitor)
  library(usethis)
  library(mapview)
}




# Read the data from the CSV file
covid_data2 <- read.csv("C:/Users/USER/Desktop/Project/SAIL Project/Geocoding/covid_19/covid19_nigeria_states.csv")
lat_lon <- read.csv("C:/Users/USER/Desktop/Project/SAIL Project/Geocoding/covid_19/lat_lon.csv")

colnames(covid_data2)
View(covid_data2)

# Check for missing values
missing_values <- is.na(covid_data2)

# Display missing values (TRUE = missing, FALSE = not missing)
View(missing_values)

# GEOCODING COVID-19 FOR AFFECTED STATE 

View(covid_data2)
str(covid_data2)


usethis::edit_r_environ()
Sys.setenv(GOOGLEGEOCODE_API_KEY = "GOOGLEAPIKEY")


geo_code_tbl <- covid_data2 %>% 
  tidygeocoder::geocode(
    address = states,
    method = "osm",
  )




geo_code_tbl1 <- covid_data2 %>% 
  tidygeocoder::geocode(
    address = states,
    method = "google",
  )

View(geo_code_tbl1)


geo_code_tbl2 <- geo_code_tbl1 %>% 
  drop_na(long, lat)


# Convert to an sf object
covid_data2_sf <- geo_code_tbl2 %>% 
  st_as_sf(
    coords = c("long", "lat"),
    crs = 4326
  )


mapview(covid_data_sf)

covid_data2_sf %>% 
  leaflet() %>% 
  addProviderTiles(providers$Esri.WorldImagery, group = "World Imagery") %>% 
  addProviderTiles(providers$Stadia.StamenTonerLite, group = "Toner Lite") %>% 
  addLayersControl(baseGroups = c("Toner Lite", "World Imagery")) %>% 
  addMarkers(label = covid_data2_sf$states,
             clusterOptions = markerClusterOptions(),
             popup = ifelse(covid_data2_sf$total_confirmed != NA,
                            covid_data2_sf$total_confirmed,
                            "Not sure of the covid's location"))

covid_data_sf %>% 
  leaflet() %>% 
  addProviderTiles(providers$Esri.WorldImagery, group = "World Imagery") %>% 
  addProviderTiles(providers$Stadia.StamenTonerLite, group = "Toner Lite") %>% 
  addLayersControl(baseGroups = c("Toner Lite", "World Imagery")) %>% 
  addMarkers(label = covid_data_sf$states,
             clusterOptions = markerClusterOptions(),
             popup = ifelse(covid_data_sf$total_confirmed != NA,
                            covid_data_sf$total_confirmed,
                            "Not sure of the covid's location"))








# Define regions and their respective states
regions <- list(
  "North Central" = c("Benue", "Kogi", "Kwara", "Nasarawa", "Niger", "Plateau", "FCT"),
  "North East" = c("Adamawa", "Bauchi", "Borno", "Gombe", "Taraba", "Yobe"),
  "North West" = c("Jigawa", "Kaduna", "Kano", "Katsina", "Kebbi", "Sokoto", "Zamfara"),
  "South East" = c("Abia", "Anambra", "Ebonyi", "Enugu", "Imo"),
  "South South" = c("Akwa Ibom", "Bayelsa", "Cross River", "Delta", "Edo", "Rivers"),
  "South West" = c("Ekiti", "Lagos", "Ogun", "Ondo", "Osun", "Oyo")
)

# Print the list of regions and states
print(regions)


# convert the list of states grouped by regions
regions_df <- stack(regions ) %>% 
  rename(states = values, region = ind)

#Merge the regions with original dataframe 

covid_data2_df <- covid_data2 %>% 
  left_join(regions_df, by = "states")

View(covid_data2_df)

# Save data frame as CSV
write.csv(covid_data2_df, file = "covid_data2_df.csv", row.names = FALSE)





#########################################################################
           

# Create the bar chart plot of total confirmed cases
ggplot(covid_data2_df, aes(x = region, y = total_confirmed, fill = region)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(title = "Number of Reported Total Confirmed of COVID-19 in Nigeria",
       x = "Region",
       y = "Number of Reported Total Confirmed") +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE, big.mark = ","))  # Format y-axis labels to show numbers with commas


# filtering and plotting the graph of total confirm  by regions      

# Filter the data for the "South South" region
South_south_rep_data <- covid_data2_df %>%
  filter(region == "South South")

# Plotting with ggplot
ggplot(South_south_rep_data, aes(x = states, y = total_confirmed, fill = states)) +
  geom_bar(stat = "identity") +
  labs(title = "Total confirmed Cases by States in the South South Region", 
       y = "Number of Total confirmed Cases", 
       x = "States") + 
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE, big.mark = ","))  # Format y-axis labels to show numbers with commas


# Filter the data for the "South West" region
South_West_rep_data <- covid_data2_df %>%
  filter(region == "South West")

# Plotting with ggplot
ggplot(South_West_rep_data, aes(x = states, y = total_confirmed, fill = states)) +
  geom_bar(stat = "identity") +
  labs(title = "Total confirmed Cases by States in the South West Region", 
       y = "Number of Total confirmed Cases", 
       x = "States") + 
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE, big.mark = ","))  # Format y-axis labels to show numbers with commas


# Filter the data for the "South East" region
South_East_rep_data <- covid_data2_df %>%
  filter(region == "South East")

# Plotting with ggplot
ggplot(South_East_rep_data, aes(x = states, y = total_confirmed, fill = states)) +
  geom_bar(stat = "identity") +
  labs(title = "Total confirmed Cases by States in the South East Region", 
       y = "Number of Total confirmed Cases", 
       x = "States") + 
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE, big.mark = ","))  # Format y-axis labels to show numbers with commas


# Filter the data for the "North Central" region
North_Central_rep_data <- covid_data2_df %>%
  filter(region == "North Central")

# Plotting with ggplot
ggplot(North_Central_rep_data, aes(x = states, y = total_confirmed, fill = states)) +
  geom_bar(stat = "identity") +
  labs(title = "Total confirmed Cases by States in the North Central Region", 
       y = "Number of Total confirmed Cases", 
       x = "States") + 
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE, big.mark = ","))  # Format y-axis labels to show numbers with commas



# Filter the data for the "North East" region
North_East_rep_data <- covid_data2_df %>%
  filter(region == "North East")

# Plotting with ggplot
ggplot(North_East_rep_data, aes(x = states, y = total_confirmed, fill = states)) +
  geom_bar(stat = "identity") +
  labs(title = "Total confirmed Cases by States in the North East Region", 
       y = "Number of Total confirmed Cases", 
       x = "States") + 
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE, big.mark = ","))  # Format y-axis labels to show numbers with commas


# Filter the data for the "North West" region
North_West_rep_data <- covid_data2_df %>%
  filter(region == "North West")

# Plotting with ggplot
ggplot(North_West_rep_data, aes(x = states, y = total_confirmed, fill = states)) +
  geom_bar(stat = "identity") +
  labs(title = "Total confirmed Cases by States in the North East Region", 
       y = "Number of Total confirmed Cases", 
       x = "States") + 
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE, big.mark = ","))  # Format y-axis labels to show numbers with commas

###################################################################
# Create the bar chart plot of total deaths
ggplot(covid_data2_df, aes(x = region, y = total_death, fill = region)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(title = "Number of Reported Total Deaths of COVID-19 in Nigeria",
       x = "Region",
       y = "Number of Reported Total Deaths") +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE, big.mark = ","))  # Format y-axis labels to show numbers with commas

# filtering and plotting the graph of total deaths by regions

# Filter the data for the "South South" region
South_south_rep_data <- covid_data2_df %>%
  filter(region == "South South")

# Plotting with ggplot
ggplot(South_south_rep_data, aes(x = states, y = total_death, fill = states)) +
  geom_bar(stat = "identity") +
  labs(title = "Total Death Cases by States in the South South Region", 
       y = "Number of Death Cases", 
       x = "States") + 
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE, big.mark = ","))  # Format y-axis labels to show numbers with commas


# Filter the data for the "South West" region
South_West_rep_data <- covid_data2_df %>%
  filter(region == "South West")

# Plotting with ggplot
ggplot(South_West_rep_data, aes(x = states, y = total_death, fill = states)) +
  geom_bar(stat = "identity") +
  labs(title = "Total Death Cases by States in the South west Region", 
       y = "Number of Death Cases", 
       x = "States") + 
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE, big.mark = ","))  # Format y-axis labels to show numbers with commas


# Filter the data for the "South East" region
South_East_rep_data <- covid_data2_df %>%
  filter(region == "South East")

# Plotting with ggplot
ggplot(South_East_rep_data, aes(x = states, y = total_death, fill = states)) +
  geom_bar(stat = "identity") +
  labs(title = "Total Death Cases by States in the South East Region", 
       y = "Number of Death Cases", 
       x = "States") + 
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE, big.mark = ","))  # Format y-axis labels to show numbers with commas


# Filter the data for the "North Central" region
North_Central_rep_data <- covid_data2_df %>%
  filter(region == "North Central")

# Plotting with ggplot
ggplot(North_Central_rep_data, aes(x = states, y = total_death, fill = states)) +
  geom_bar(stat = "identity") +
  labs(title = "Total Death Cases by States in the North Central Region", 
       y = "Number of Death Cases", 
       x = "States") + 
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE, big.mark = ","))  # Format y-axis labels to show numbers with commas



# Filter the data for the "North East" region
North_East_rep_data <- covid_data2_df %>%
  filter(region == "North East")

# Plotting with ggplot
ggplot(North_East_rep_data, aes(x = states, y = total_death, fill = states)) +
  geom_bar(stat = "identity") +
  labs(title = "Total Death Cases by States in the North East Region", 
       y = "Number of Death Cases", 
       x = "States") + 
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE, big.mark = ","))  # Format y-axis labels to show numbers with commas


# Filter the data for the "North West" region
North_West_rep_data <- covid_data2_df %>%
  filter(region == "North West")

# Plotting with ggplot
ggplot( North_West_rep_data, aes(x = states, y = total_death, fill = states)) +
  geom_bar(stat = "identity") +
  labs(title = "Total Death Cases by States in the  North West Region", 
       y = "Number of Death Cases", 
       x = "States") + 
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE, big.mark = ","))  # Format y-axis labels to show numbers with commas





######################


summary(covid_data2_df)
summary(covid_data2_df$region)

str(covid_data2_df)

mean_by_region <- tapply(covid_data2_df$total_death, covid_data2_df$region, mean)
mean_by_region




# Perform one-way ANOVA
anova_result <- aov(total_death ~ region, data = covid_data2_df)
anova_result

tukey_result <- TukeyHSD(anova_result)

tukey_result

# Summary of ANOVA results
summary(anova_result)



