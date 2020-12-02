# U.S. Election 2020 

## Project Proposal

The ETL process will be based on 2020 election result data for major races; Governors, House of Representatives, President, and Senate, across the U.S. GitHub will be used as a base of collaboration operations and Jupyter Notebook will be accompanied to clean the csv files and create new composite tables using Pandas, and eventually store our cleaned tables in PostgreSQL.

Note: All ETL processes accompanied by Jupyter Notebook and PostgreSQL. 

- Click to view data management in [Jupyter Notebook](https://nbviewer.jupyter.org/github/LeeProut/ETL-project/blob/main/election2020.ipynb)

- Click to view data management in [PostgreSQL](schemas.sql)

## Extract

**Source:** https://www.kaggle.com/unanimad/us-election-2020

**Format:** CSV

**No. of datasets:** 11 

- Using Pandas to read in CSV files to perform other following processes as an example below.

        # File paths
        gov_cn_path = 'Resources/governors_county.csv'
        gov_cand_path = 'Resources/governors_county_candidate.csv'
        gov_ste_path = 'Resources/governors_state.csv'
    
        # Read csv files
        gov_cn_df = pd.read_csv(gov_cn_path)
        gov_cand_df = pd.read_csv(gov_cand_path)
        gov_ste_df = pd.read_csv(gov_ste_path)

- Checked that CSV files successfully read in by Pandas as an example below.

        # View first 5 rows of dataframe
        gov_cn_df.head()

## Transform

- Used dataframe created for each dataset from the previous method (extract).

- Created dataframes that contain states and states-and-counties as an example below. Also, the data in these tables are unique for using as the foreign key in the following method (load).

        # Retrieve only states 
        state_df = psd_cn_df[['state']].drop_duplicates(subset=['state'])

        # Retrieve only states and counties
        state_county_df = psd_cn_df[['state', 'county']].drop_duplicates(subset=['state', 'county'])

- For the house representatives' race, the datasets did not initially contain columns for **`state`**. For the purpose of consistency, the datasets were added to the column using the numpy function **`.select`**. Also, removed all the *nan* value which was found in **`state`** column. As the observation of dataset, removing *nan* would not be resulting in the lack of information of the dataset.
    
        # Add state column
        conditions = [hse_cand_df['district'].str.contains('Alabama'), hse_cand_df['district'].str.contains('Alaska'), 
                    hse_cand_df['district'].str.contains('Arizona'), hse_cand_df['district'].str.contains('Arkansas'), 
                    hse_cand_df['district'].str.contains('California'), hse_cand_df['district'].str.contains('Colorado'), 
                    hse_cand_df['district'].str.contains('Connecticut'), hse_cand_df['district'].str.contains('Delaware'), 
                    hse_cand_df['district'].str.contains('Florida'), hse_cand_df['district'].str.contains('Georgia'), 
                    hse_cand_df['district'].str.contains('Hawaii'), hse_cand_df['district'].str.contains('Idaho'), 
                    hse_cand_df['district'].str.contains('Illinois'), hse_cand_df['district'].str.contains('Indiana'), 
                    hse_cand_df['district'].str.contains('Iowa'), hse_cand_df['district'].str.contains('Kansas'), 
                    hse_cand_df['district'].str.contains('Kentucky'), hse_cand_df['district'].str.contains('Louisiana'), 
                    hse_cand_df['district'].str.contains('Maine'), hse_cand_df['district'].str.contains('Maryland'), 
                    hse_cand_df['district'].str.contains('Massachusetts'), hse_cand_df['district'].str.contains('Michigan'), 
                    hse_cand_df['district'].str.contains('Minnesota'), hse_cand_df['district'].str.contains('Mississippi'), 
                    hse_cand_df['district'].str.contains('Missouri'), hse_cand_df['district'].str.contains('Montana'), 
                    hse_cand_df['district'].str.contains('Nebraska'), hse_cand_df['district'].str.contains('Nevada'), 
                    hse_cand_df['district'].str.contains('New Hampshire'), hse_cand_df['district'].str.contains('New Jersey'), 
                    hse_cand_df['district'].str.contains('New Mexico'), hse_cand_df['district'].str.contains('New York'), 
                    hse_cand_df['district'].str.contains('North Carolina'), hse_cand_df['district'].str.contains('North Dakota'), 
                    hse_cand_df['district'].str.contains('Ohio'), hse_cand_df['district'].str.contains('Oklahoma'), 
                    hse_cand_df['district'].str.contains('Oregon'), hse_cand_df['district'].str.contains('Pennsylvania'), 
                    hse_cand_df['district'].str.contains('Rhode Island'), hse_cand_df['district'].str.contains('South Carolina'), 
                    hse_cand_df['district'].str.contains('South Dakota'), hse_cand_df['district'].str.contains('Tennessee'), 
                    hse_cand_df['district'].str.contains('Texas'), hse_cand_df['district'].str.contains('Utah'), 
                    hse_cand_df['district'].str.contains('Vermont'), hse_cand_df['district'].str.contains('Virginia'), 
                    hse_cand_df['district'].str.contains('Washington'), hse_cand_df['district'].str.contains('West Virginia'), 
                    hse_cand_df['district'].str.contains('Wisconsin'), hse_cand_df['district'].str.contains('Wyoming')]
        choices = ['Alabama', 'Alaska', 'Arizona', 'Arkansas', 'California', 'Colorado', 'Connecticut', 'Delaware', 
                'Florida', 'Georgia', 'Hawaii', 'Idaho', 'Illinois', 'Indiana', 'Iowa', 'Kansas', 'Kentucky', 
                'Louisiana', 'Maine', 'Maryland', 'Massachusetts', 'Michigan', 'Minnesota', 'Mississippi', 'Missouri', 
                'Montana', 'Nebraska', 'Nevada', 'New Hampshire', 'New Jersey', 'New Mexico', 'New York', 'North Carolina', 
                'North Dakota', 'Ohio', 'Oklahoma', 'Oregon', 'Pennsylvania', 'Rhode Island', 'South Carolina', 'South Dakota', 
                'Tennessee', 'Texas', 'Utah', 'Vermont', 'Virginia', 'Washington', 'West Virginia', 'Wisconsin', 'Wyoming']

        hse_cand_df['state'] = np.select(conditions, choices, default=np.nan) 

- Created dataframe that contain states-and-districts as an example below. Also, the data in these tables are unique for using as the foreign key in the following method (load).

        # Retrieve only states and districts
        state_district_df = hse_result_cleaned_df[['state', 'district']].drop_duplicates(subset=['state', 'district'])

- For the senate's race, the datasets did not initially contain columns for **`won`**. For the purpose of consistency and further analysis, the dataset was added to the column using the `.transform` and **`.iloc`** functions. 

        # Locate all the winner for each county using index
        sen_cand_win_df = sen_cand_df[sen_cand_df['total_votes'] == sen_cand_df.groupby(['state','county'])['total_votes'].transform('max')]
        sen_winner_index = sen_cand_win_df.index

        # Assign result to 'won' column
        sen_cand_df['won'] = False
        for i in sen_cand_df.index:
            if i in sen_winner_index:
                sen_cand_df.iloc[i, 5] = True

- Rename function (**`df.rename(columns={})`**) was applied to rename the columns for “votes” or “total_votes” to “candidate_votes” for the purpose of clarity and consistency as an example below.

        # Rename column and make a copy from original dataframe
        gov_result_df = gov_cand_df.rename(columns={'votes':'candidate_votes'}).copy()

        # Rename column and make a copy from original dataframe
        hse_result_df = hse_cand_df.rename(columns={'total_votes': 'candidate_votes'}).copy()

- Calculated and assigned a column for each candidate’s percentage of the total vote, both by counties and by states as an example below. 

        # Assign column of each candidate's percentage vote
        gov_result_df = gov_result_df.assign(percent_votes = round(gov_result_df.candidate_votes/gov_result_df\
                                                                .groupby(['state','county']).candidate_votes\
                                                                .transform('sum')*100, 2))

- Rearraged the columns for each dataset to fit a consistent and logical pattern.

        # Rearrage columns
        gov_result_cleaned_df = gov_result_df[['state', 'county','candidate', 'party',
                                       'candidate_votes', 'percent_votes', 'won']].copy()

## Load

Working as a team, it is important to have a powerful tool to apply for ETL process. PostgreSQL is a convenient and efficient tool that will be applied to this process. Also, there are 3 tables that will be used as a foreign key to other tables. Created query by PostgreSQL and shared it among team member to have a standard and consistency of ELT process is considered to be the best way. 

- Created database diagram and PostgreSQL query via [QuickDatabase](https://app.quickdatabasediagrams.com/#/d/Vj5DcU)

<p align="center">
  <img src="Images/QuickDBD-election_dbd.png" />
</p>

- Created a **SQL database** in Postgres (relational database), which contains tables for each dataframe. The query was extracted from the previous step. ([Schema-text](schema_physical),[Schema-query](schemas.sql)) An example is presented as below.

    * The composite key as the primary key between **state and county** will be applied to tables which contain column **`state`** and **`county`**, due to the duplication of county names.
    * The composite key as the primary key between **state and district** will be applied to tables which contain column **`state`** and **`district`**, due to the duplication of district names.

            # Table that contains state and county columns
            CREATE TABLE "governor_result_county" (
            "state" VARCHAR(255)   NOT NULL,
            "county" VARCHAR(255)   NOT NULL,
            "candidate" VARCHAR(255)   NOT NULL,
            "party" VARCHAR(255)   NOT NULL,
            "candidate_votes" INT   NOT NULL,
            "percent_votes" DECIMAL   NOT NULL,
            "won" BOOL   NOT NULL,
            CONSTRAINT "pk_governor_result_county" PRIMARY KEY (
                "state","county"
                )
            );

            # Table that contains state and district columns
            CREATE TABLE "house_result" (
                "state" VARCHAR(255)   NOT NULL,
                "district" VARCHAR(255)   NOT NULL,
                "candidate" VARCHAR(255)   NOT NULL,
                "party" VARCHAR(255)   NOT NULL,
                "candidate_votes" INT   NOT NULL,
                "percent_votes" DECIMAL   NOT NULL,
                "won" BOOL   NOT NULL,
                CONSTRAINT "pk_house_result" PRIMARY KEY (
                    "state","district"
                )
            );           

- Created the master data for states, state-county and state-district as an example presented below.

    * The purpose of creation is the data in these tables will be used as a foreign key for the tables that contain states, counties and districts.
    * Table state_county and state_district will use the state table for state column as the foreign key.

            CREATE TABLE "states" (
                "state" VARCHAR(255)   NOT NULL,
                CONSTRAINT "pk_states" PRIMARY KEY (
                    "state"
                )
            );

            CREATE TABLE "governor_total_votes_state" (
                "state" VARCHAR(255)   NOT NULL,
                "total_votes" INT   NOT NULL,
                CONSTRAINT "pk_governor_total_votes_state" PRIMARY KEY (
                    "state"
                )
            );

            ALTER TABLE "governor_total_votes_state" ADD CONSTRAINT "fk_governor_total_votes_state_state" FOREIGN KEY("state")
            REFERENCES "states" ("state");
                
- Created the following tables for the President, Governor, and Senate races: 

    * Election result by county: To analyze the win-lose possibility by county
    * Election result by state: To compare the win-lose possibility with election result by county
    * Election’s total votes by county: To keep the record of how many people vote compared to county population 
    * Election’s total votes by state: To keep the record of how many people vote compared to state population

- Created the following tables for the House race: 

    * Election result by district: To analyze the win-lose possibility by county
    * Election’s total votes by district: To keep the record of how many people vote compared to district population

- Connected with PostgreSQL database accompanied by **Jupyter Notebook** 

        # Connect to database
        connection_string = f"{username}:{password}@localhost:5432/election2020_db"
        engine = create_engine(f'postgresql://{connection_string}')       

        # Check all tables in database
        engine.table_names()

        # Load data to election2020_db database
        state_df.to_sql(name='states', con=engine, if_exists='append', index=False)

- There are 17 tables loaded into their respective tables in the database as an example presented below.

    * Tables that are required to be stored first in the database because of the foreign key condition are **`state`**, **`state_county`** and **`state_district`**.
    * After storing the first 3 table above, other tables will be stored in the database regardless of their order.

            # States
            state_df.to_sql(name='states', con=engine, if_exists='append', index=False)

            # States and counties 
            state_county_df.to_sql(name='state_county', con=engine, if_exists='append', index=False)

            # States and districts 
            state_district_df.to_sql(name='state_district', con=engine, if_exists='append', index=False)

            # Store election result by county to database
            gov_result_cleaned_df.to_sql(name='governor_result_county', con=engine, if_exists='replace', index=False)

            # Store election result by district to database
            hse_result_cleaned_df.to_sql(name='house_result', con=engine, if_exists='replace', index=False)

- Checked the completion of loading process as an example presented below.

        # Retrive table from database
        pd.read_sql_query('select * from states', con=engine).head()

*Note:* In a limited timeframe, population data will be for further ETL processes. 

---

Contributors

© Atcharaporn Puccini: b.atcharaporn@gmail.com |
© Shay O'Connell: shay.oconnell7@gmail.com |
© Akilah Hunte: ahunt173@gmail.com |
© Lee Prout: wleeprout@gmail.com
