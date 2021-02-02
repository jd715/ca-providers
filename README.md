# CA Providers ETL Service

This service creates a standardized data set of CA Providers.
It pulls data from a variety of sources - a heroku applications API, an HTML table on the NACCRR webpage, and a CSV provided in the repo.
It then cleans this data and lastly calculates a couple of metrics.

## Installation

You will need to download the repo and have python and various python packages installed to run these .py files.
You will need jupyter notebook or jupyter lab installed to explore the .ipynb file.   I seperated the key scripts out of the notebook to their own dedicated .py files.

## Usage

1.  Run a web scraper that will pull down the data within the NACCRR table.
```retrive_web.py```

2.  Run a web scraper that will pull down the data from the Heroku API.
```retrive_api.py```

3.  Run the following script to clean up and standardize data formats, deduplicate the data, and create a final combined data set.
```clean_data.py```


*Optional*

To generate HTML data profiles of the various input data sets for EDA / general exploration run the following.  This utilizes the pandas-profiling package.
```generate_profiles.py```

## Which language, framework and libraries you chose and why

I initially chose R, and created scripts to pull both web data sources.  I did this primarily because I've been doing a lot of coding in R lately.  I realized that using Python might make more sense here though considering its in the Brightwheel stack and I knew all of this could also be done in Python just as easily.  Python in general is a great glue language - talks to almost everything and has packages that span all areas of software.  I knew of BeautifulSoup and use pandas regularly so it was an easy choice for this.

BeautifulSoup -> standard web scraping package.  Lots of resources online, chances are any weird edge cases, someone else has had and answer's on stackoverflow.
Pandas -> standard for working with data, does a million things (though I actually prefer R's tidyverse framework for EDA)


## Tradeoffs you might have made, anything you left out, or what you might do differently if you were to spend additional time on the project

Big tradeoffs here are mainly due to limited time and not having a database pre-spun up.  If I had a DB to work with - or had the time to set up a DB that I could share with the team - I'd rather send all the raw data right to the DB and do all transformation work in SQL.  I think its preferable to have the raw data, all of the transformation steps, and the final data sets all within one language (SQL).  Allows you to easier trace back the lineage of the data and you can also throw dbt on top of it for documentation & DAGs to understand the flows better.


## Other notes
By the time I got all of the data gathered, I didn't have much time to actually consider the data standardization step.  The requirements were also not entirely clear to me. 

-  It requests all data to be in the final table but for it also to be standardized in some way and a source of truth.  I would assume at the very least we want to get rid of duplication - which can be found in the csv provided.
-  I'd also note that without any context around these data sources its not entirely clear to me what the source of truth data set should represent.  The grains in these data sets seem to represent contacts at various providers.  There are providers with various locations and contacts.  If the source of truth is a list of providers, then that is different than a source of truth for a list of contacts.  Both require ommiting certain information.

i.e.  A table/view *providers* might just be provider_name and type .  A table/view *providers_site* or *provider_location* might include provider_name (ideally provider_id , connecting to *providers*) and the address / location based attribuets.  Lastly *provider_contacts* would join to *provider_sites* and have the contact info for people at that provider.

-  Without the context around these data sets it isn't clear what to use as a base here.  Do we trust one of these source more than the other?  Do we trust the internal API data for instance but want to join in fields that doesn't have like email by joining on the scraped data by the provider name & zip ?  Lots of various ways to go but none are explicity clear.

Happy to proceed with these ideas if you'd like - would just require more time and would want to check to make sure I'm going in the right direction for what you are looking for before proceeding.

