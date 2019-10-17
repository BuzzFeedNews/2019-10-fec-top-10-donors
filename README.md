# Analysis of contributions to 2020 presidential candidates, as of 2019 Q3

This repository contains data and code supporting a [BuzzFeed News article examining donors](https://www.buzzfeednews.com/article/ryancbrooks/donald-trump-fundraising-impeachment) on campaign finance. Published October 16, 2019. See below for details.

## Data

All data in this repository comes from the campaigns' committee filings to the [Federal Election Commission](https://www.fec.gov/) (FEC), with assistance from [ProPublica's Campaign Finance API](https://projects.propublica.org/api-docs/campaign-finance/committees/#get-committee-filings).

- [`data/candidates.csv`](data/candidates.csv) contains a list of high and medium-profile presidential candidates (and primary campaign committees) for whom an "October Quarterly" filing was available on the FEC's website by 12:30pm Eastern on October 16, 2019. (The filing deadline was October 16 at midnight.)

- [`fetched/filings.csv`](fetched/filings.csv) contains a list of basic metadata for the aforementioned filings.

- The `fetched/filings/` directory is created automatically when running the `Makefile`. See the Reproducibility section below. When created, it contains the raw filing data for each of those filings, in the FEC's `.fec` format.
   
## Methodology

### Linking donors

The Federal Election Commission filings do not contain any truly-unique identifiers for campaign contributors. So, in order to identify unique donors per day, BuzzFeed News constructed a `donor_id`, created from the following fields:

- First name
- Last name
- 5-digit ZIP code

There are some limitations to this approach:

- If a donor changes their name, or misspells it occasionally, this approach will not cluster all of their contributions together
- If a donor moves to a new ZIP code, this approach will not cluster all of their contributions together
- If two or more donors in the same ZIP code share both a first and last name, this approach will assume (incorrectly) that they are the same person

For these reasons, the results of the analysis should be interpreted as approximations.

### The $200 threshold

The Federal Election Commission does not require campaigns to itemize contributions from donors who have given **$200 or less** during a given campaign cycle. In a small number of cases, however, campaigns have included such donors — often, it seems, because they gave a large amount of money and then were refunded. For the sake of equal comparison, BuzzFeed News excluded contributions from donors whose aggregate was listed as $200 or less.

### Contribution totals above legal limit

The FEC prohibits individual donors from giving more than $2,800 to any single committee. Even so, the data in the filings appear to indicate that some donors have given more than that amount. In some cases, this may be because the refunds have not yet been processed, or are declared elsewhere. Above-legal contributions have no effect on the analyses, which focus on the act of giving rather than how much money the campaigns have raised.

## Analysis

The [`notebooks/analyze-contributions.ipynb`](notebooks/analyze-contributions.ipynb) notebook contains the analysis, written in Python. Relevant outputs can be found there.

## Reproducibility

The code running the analysis is written in Python 3, and requires the following Python libraries:

- [pandas](https://pandas.pydata.org/) for data loading and analysis
- [fecfile](https://esonderegger.github.io/fecfile/) for parsing the raw FEC filings
- [jupyter](https://jupyter.org/) to run the notebook infrastructure
- [requests](https://requests.kennethreitz.org/en/master/) to download the FEC files

If you use Pipenv, you can install all required libraries with `pipenv install`.

The raw FEC files are too large to store in GitHub and must be downloaded from http://www.fec.gov. To do this automatically, run `make filings` to execute the download script.

Executing the notebook in the `notebooks/` directory should reproduce the findings.

## Licensing

All code in this repository is available under the [MIT License](https://opensource.org/licenses/MIT). Files in the `data/` directory are released into the public domain. 

## Questions / Feedback

Contact Scott Pham at [scott.pham@buzzfeed.com](mailto:scott.pham@buzzfeed.com).

Looking for more from BuzzFeed News? [Click here for a list of our open-sourced projects, data, and code.](https://github.com/BuzzFeedNews/everything)

