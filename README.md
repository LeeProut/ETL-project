# U.S. Election 2020 

## Project Proposal

The ETL process will be based on 2020 election result data for major races; Governors, House of Representatives, President, and Senate, across the U.S. GitHub will be used as a base of collaboration operations and Jupyter Notebook will be accompanied to clean the csv files and create new composite tables using Pandas, and eventually store our cleaned tables in PostgreSQL.

## Extract

**Source:** https://www.kaggle.com/unanimad/us-election-2020
**Format:** CSV
**No. of datasets:** 11 

- Using Pandas to read in CSV files and performing other following processes.

## Transform

- A Pandas DataFrame was created for each dataset.

- Rename function (`df.rename(columns={})`) was applied to rename the columns for “votes” or “total_votes” to “candidate_votes” for clarity and consistency.

- Calculated and assigned a column for each candidate’s percentage of the total vote, both by county and by state. 

- For the house representatives' race, the datasets did not initially contain columns for “State”. For the purpose of consistency, the datasets were added the column using the numpy function `.select`. Also, removed all the 'nan' value which was found in 'state' column. As the observation of dataset, removing 'nan' would not be resulting in the lack of information of the dataset.

- For the senate's race, the datasets did not initially contain columns for “won”. For the purpose of consistency and later analysis, the dataset was added that column using the `.transform` and `.iloc` functions. 

- Reordered the columns for each dataset to fit a consistent and logical pattern. 

## Load

- Created database diagram via [QuickDatabase](https://app.quickdatabasediagrams.com/#/d/Vj5DcU)



Created a SQL database in pgAdmin, where we created tables for each of the dataframes.

Then, we went back to our Jupyter Notebook and loaded each dataframe into their respective pgAdmin tables.

We created the following tables for the President, Governor, and Senate races: 
Election result by county
Election result by state 
Election’s total votes by county
Election’s total votes by state 

We created the following tables for the House race: 
Election result by district
Election’s total votes by district


