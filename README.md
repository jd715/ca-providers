# CA Providers ETL Service

This service creates a standardized data set of CA Providers.
It pulls data from a variety of sources - a heroku applications API, an HTML table on the NACCRR webpage, and a CSV provided in the repo.
It then cleans this data and lastly calculates a couple of metrics.

## Installation

You will need to download the repo and have python and various python packages installed to run these .py files.
You will need jupyter notebook or jupyter lab installed to explore the .ipynb file.  I seperated the key scripts to their own dedicated .py files.

## Usage

1.  Run a web scraper that will pull down the data within the NACCRR table.
```retrive_web.py```

2.  Run a web scraper that will pull down the data from the Heroku API.
```retrive_api.py```

3.  Run the following script to clean up and standardize data formats, deduplicate the data, and create a final combined data set.
```clean_data.py```

Optional

To generate HTML data profiles of the various input data sets for EDA / general exploration run the following.  This utilizes the pandas-profiling package.
```generate_profiles.py```
