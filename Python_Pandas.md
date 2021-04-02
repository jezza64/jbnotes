<LINK href="jb1.css" rel="stylesheet" type="text/css">

#### [Back to index](index.html)

- [Pandas](#pandas)
  - [Sources](#sources)
  - [Pandas series](#pandas-series)
  - [Pandas Dataframe](#pandas-dataframe)
    - [Dataframe Indexing](#dataframe-indexing)
    - [Boolean masks](#boolean-masks)
    - [Index](#index)
    - [Unique](#unique)
    - [To remove cols](#to-remove-cols)
    - [Get info](#get-info)
    - [Missing values](#missing-values)
    - [Selecting data using loc, iloc, ix](#selecting-data-using-loc-iloc-ix)
      - [iloc](#iloc)
      - [loc](#loc)
      - [loc with Boolean indexing](#loc-with-boolean-indexing)
      - [Slicing conventions](#slicing-conventions)
    - [Numpy Arrays to Lists](#numpy-arrays-to-lists)
      - [1D list to array](#1d-list-to-array)
      - [2D list of lists to array](#2d-list-of-lists-to-array)
      - [Numpy array indexing](#numpy-array-indexing)
    - [Slicing](#slicing)
    - [Reshaping](#reshaping)
      - [Reshape 1D to 2D with no change to data](#reshape-1d-to-2d-with-no-change-to-data)
      - [Reshape 2d to 3d array](#reshape-2d-to-3d-array)
    - [Simple pandas operations](#simple-pandas-operations)
      - [To create from arrays](#to-create-from-arrays)
      - [To get the index of the max](#to-get-the-index-of-the-max)
      - [To select the rows equal to a value](#to-select-the-rows-equal-to-a-value)
      - [To select first 3 rows](#to-select-first-3-rows)
      - [To Select rows with row criteria, and subset of columns between 2 values](#to-select-rows-with-row-criteria-and-subset-of-columns-between-2-values)
      - [To Select rows with row criteria, all columns](#to-select-rows-with-row-criteria-all-columns)
      - [To Select rows matching 2 criteria](#to-select-rows-matching-2-criteria)
      - [To select rows with id column between 100 and 200, and just return named columns](#to-select-rows-with-id-column-between-100-and-200-and-just-return-named-columns)
      - [To select via a a lambda function that yields True/False values](#to-select-via-a-a-lambda-function-that-yields-truefalse-values)
      - [To add a new col without the endless warning: use assign](#to-add-a-new-col-without-the-endless-warning-use-assign)
      - [To drop a column](#to-drop-a-column)
      - [To return a string rather than a dataframe](#to-return-a-string-rather-than-a-dataframe)
      - [To create a series from a result](#to-create-a-series-from-a-result)
      - [To get the data values from a series into an array](#to-get-the-data-values-from-a-series-into-an-array)
      - [To take subset of cols](#to-take-subset-of-cols)
      - [To group by and get aggregates:](#to-group-by-and-get-aggregates)
      - [To list unique values](#to-list-unique-values)
      - [To count unique values](#to-count-unique-values)
      - [To count non null values](#to-count-non-null-values)
      - [To count all values including nulls](#to-count-all-values-including-nulls)
      - [To count per unique value](#to-count-per-unique-value)
      - [To sort (and maybe reindex)](#to-sort-and-maybe-reindex)
      - [To sort on something with a 2 level index](#to-sort-on-something-with-a-2-level-index)
      - [Add a col with known values](#add-a-col-with-known-values)
      - [Join (merge) on index](#join-merge-on-index)
      - [Merge with key which is not the index](#merge-with-key-which-is-not-the-index)
      - [Merge on multiple keys](#merge-on-multiple-keys)
      - [Method chaining](#method-chaining)
      - [Control row printing](#control-row-printing)
    - [Map](#map)
      - [map to replace values with sparse dictionary lookup](#map-to-replace-values-with-sparse-dictionary-lookup)
      - [Map to lookup in a dictionary when the index is the key](#map-to-lookup-in-a-dictionary-when-the-index-is-the-key)
      - [Apply map](#apply-map)
    - [Apply](#apply)
    - [Group by](#group-by)
    - [Agg](#agg)
    - [Datatypes in dataframe](#datatypes-in-dataframe)
  - [Lambda functions](#lambda-functions)
    - [Apply / Lambda](#apply--lambda)
  - [Stats in Numpy](#stats-in-numpy)
  - [Hypothesis testing](#hypothesis-testing)
    - [Usage](#usage)
    - [Remedies](#remedies)
  - [Microsoft reactor on pandas](#microsoft-reactor-on-pandas)

# Pandas

## Sources

McKinney: Python for Data analysis  
University of Michigan Data Science Specialization - Intro to data science

---

## Pandas series

- one dimensional array, sequence of values with associated array of data labels called index.
- Like a fixed length ordered dictionary.
- The order is maintained.
- NaNs / NA / null are all sentinel values, all are false.

Create from list, dictionary etc
Index created with ints if not provided with index parameter.

Query with attributes  
Can Iterate with `for item in series:`

But quicker to use vectorized functions, e.g. np.sum(series).  
Can create your own vectorized functions.  
Also broadcast, e.g. s += 2 adds 2 to each item.  
When iterating through series, use broadcast / vectorized instead.

.loc can also add values.

Append returns a new series, original unchanged.

Index can be duplicated!

## Pandas Dataframe

- Rectangular table of data
- Ordered collection of columns. Columns can have different data types.
- Has a row and column index.
- Like a dict of series, all sharing the same index.
- Can make multi dimensional with hierarchical indexing.
- Index created 0.. if not assigned on creation.

### Dataframe Indexing

Column label, row index. Can be non unique.
Quickly select based on row and col.

query by position
>`s.iloc[3]`

query by label
>`s.loc['country']`

Can call with s[3] or s['country'] and it works out if you're querying by position or value

cell
>`Df.loc[row, col]`

Chaining returns copy of the dataframe.
>`df[][]`

Slicing better. 
>`df.loc[:,['Name', 'Cost']]`

Drop: doesn't change the df, returns a copy without the row.  
Can say inplace, not a copy. Axis = 1 means drop a col.

>`Del df['Name']`

Drop a column: best method is
>'df.drop('column_name', axis=1, inplace=True)'

Views are generally faster, don't impact on underlying data. Use copy method to avoid this.

list of cols. Can set the header row on the import.
>`Df.columns`

Can also rename with
>`Df.rename`

---

### Boolean masks

Combines an array of true / false with original data. True included in final result. Heavily used in pandas.

Create by applying operators to df, produces same shape df with the true values
>`df['Gold'] > 0`

Where function applies mask at the same time
>`only_gold = df.where(df['Gold'] > 0)`

Includes values not meeting criteria as NaN, but most functions ignore these rows. Use dropna to get rid.

Boolean mask can be used as value for indexing.
>`only_gold = df[df['Gold'] > 0]`

Can chain Boolean masks
>`len(df[(df['Gold'] > 0) | (df['Gold.1'] > 0)])`  
>`df[(df['Gold.1'] > 0) & (df['Gold'] == 0)]`

Extremely important, and often an issue for new users, is to remember that each Boolean mask needs to be encased in parenthesis because of the order of operations.

---

### Index

Index can be set by set_index function. Reset_index gets back to integer indexes.

Index can be multiple cols. Call set _index with list of cols. Finds distinct combinations and sets index.

To create a 2 level index, need to query with args in order of index, level 0 first.

>`Df = df.set_index(['state name', 'county name'])`  
>`df.loc['Michigan', 'Washtenaw County']`

Can have multi level cols also.

---

### Unique

shows unique values in a col
>`Df['sumlevel'].unique()`

### To remove cols

>`cols_to_keep = ['col 1', 'col 2']`
>`Df = df(cols_to_keep)`

### Get info

>`df.info()`

### Missing values

loading from files use na_values to indicate which values loaded are actually None. Use na_filter to turn off whitespace filtering.

Fill_na to fill missing data forward and back relative to rows. Can e.g. reset index to a timestamp and use Df.sort_index() to sort on index. Then fill missing data forwards. Can also fill with series of this same size.

Maths ignore missing values.

### Selecting data using loc, iloc, ix

#### iloc

For integer based position selection. Data.iloc[<row selection>, <column selection>]. Column selection is optional. Don't really use, always use name selection with .loc.

>`Data.iloc[-1]` gets last row  
>`Data.iloc[:, 0]` gets first column  
>`Data.iloc[0:5]` gets first 5 rows  
>`Data.iloc[:, 0:2]` gets all rows first 2 columns  
>`Data.iloc[[0, 3, 6, 24], [0, 5, 6]]` for complex.  

Returns series when one row selected, Df when multiple selected. To get around this, pass a list of values
>`Data.iloc[[100]]` returns one row as a dataframe.

#### loc

Used for selecting by label / index, or selecting with Boolean mask. Column selection is optional.
>`Df.loc[<row selection>, <column selection>]`

Selections with data.loc are based on the index of the dataframe. Set the index with 
>`df.set_index("last_name")`

To Access 
>`df.loc['Jeremy']`  
>`df.loc[['Jeremy', 'Lucy']]`

Again pass single row requests with a list using [[]] to make the result a DF not a series.

To get the cols between col 1 and col 3  
>`Data.loc[:, ['col1' : 'col 3:']]`

#### loc with Boolean indexing

Most common method in practice.

Pass an array or series of true / false values to select rows where
true.

Select matching rows on a condition
>`df.loc['first_name' == 'Jeremy']`

Select some columns from rows matching a condition
>`df.loc['first_name' == 'Jeremy', ['col1', 'col2']]`

#### Slicing conventions

0:3 runs from 0 to row before 3.  
The last limit is not included.  
for position based selection.  
>`df.iloc[row selection, column selection]`

### Numpy Arrays to Lists

#### 1D list to array

>`Data = [1, 2, 3]`  
>`From numpy import array`  
>`Data = array(data)`  

#### 2D list of lists to array

>`Data = [[11, 22], [33, 44], [55, 66]]`  
>`Data = array(data)`

#### Numpy array indexing

>`Data[4]` # zero base, 5th element  
>`Data[-1]` # gets last item  
>`Data[-2]` # gets last but one  
>`Data[4, 1]` # gets 5th row, 2nd col  
>`Data[0, ]` # gets 1st row all cols

### Slicing

>`Data[start: end]` 
>`Data[-2: ]` # gets data starting 2 before the end

### Reshaping

Lots of Scikit learn models need targets as 2d arrays.  
Common to reshape 1d array to 2d, but no change to the data. Just a 2d array with one column.

#### Reshape 1D to 2D with no change to data

>`rehsape(rows, 1)` # rows is data.shape[0]

#### Reshape 2d to 3d array

Often you have 2d data (sequence in each row), but model expects 3d, including multiple timestep dimension or multiple features.

>`Reshape(rows, columns, 1)` # no change to data, but different dimensions

### Simple pandas operations

#### To create from arrays

>`Pd.DataFrame(data = .., columns = .., index = ..)`

#### To get the index of the max

>`df['Gold'].idxmax()`

#### To select the rows equal to a value

>`max = df1['abs diff gold'].max()`  
>`val_mask = df1['abs diff gold'] == max`  
>`df1[val_mask]`

#### To select first 3 rows

>`dfc67 = dfc66.iloc[0:3]`

#### To Select rows with row criteria, and subset of columns between 2 values

>`data.loc[data['first_name'] == 'Antonio', 'city':'email']`

#### To Select rows with row criteria, all columns

>`data.loc[data['first_name'].isin(['France', 'Tyisha','Eric'])]`

#### To Select rows matching 2 criteria

>`data.loc[data['email'].str.endswith("gmail.com") & (data['first_name'] == 'Antonio')]`

#### To select rows with id column between 100 and 200, and just return named columns

>`data.loc[(data['id'] > 100) & (data['id'] <= 200), ['postal', 'web']]`

#### To select via a a lambda function that yields True/False values

>`data.loc[data['company_name'].apply(lambda x: len(x.split(' ')) == 4)]`

(Select rows where the company name has 4 words in it. Can select outside of the main .loc for clarity
>`idx = data['company_name'].apply(lambda x: len(x.split(' ')) == 4))`

#### To add a new col without the endless warning: use assign

>`dfg32 = dfg3.assign(q3 = (dfg3['Gold'] - dfg3['Gold.1']) / dfg3['Gold.2'])`

#### To drop a column

>`del df['column_name']`

#### To return a string rather than a dataframe

>`max = dfg32['q3'].max()`  
>`mask = dfg32['q3'] == max`  
>`return (dfg32[mask].index)[0]`  

#### To create a series from a result

>`Points = pd.Series(df['Gold.2'] * 3 + df['Silver.2'] * 2 + df['Bronze.2'] * 1)`

#### To get the data values from a series into an array

>`s.values`

#### To take subset of cols

>`columns_to_keep = ['STNAME', 'CTYNAME']`
>`dfc52 = dfc5[columns_to_keep]`

#### To group by and get aggregates:

>`df_state = dfc52.groupby(['STNAME']).count()`

#### To list unique values

>`df['target'].unique()`

#### To count unique values

>`df['hID'].nunique()`

#### To count non null values

>`df['hID'].count()`

#### To count all values including nulls

>`df['hID'].size`

#### To count per unique value

>`df['target'].value_counts()`

#### To sort (and maybe reindex)

>`dfc62.sort_values(by = ['STNAME', 'CENSUS2010POP'], ascending = [True, False], inplace = True)`  
>`df.sort_values(by=['count'], ascending=False)`

#### To sort on something with a 2 level index

>`grouped = Df2.groupby('Markets')`  
>`grouped.describe(percentiles = []).sort_values(by=[('PP Complete > Ad Cost', 'count')])`

#### Add a col with known values

>`df['Date'] = ['December 1', 'January 1', 'mid-May']`

#### Join (merge) on index

>`pd.merge(staff_df, student_df, how='outer', left_index=True, right_index=True)`

#### Merge with key which is not the index

>`pd.merge(staff_df, student_df, how='left', left_on='Name', right_on='Name')`

#### Merge on multiple keys

>`pd.merge(staff_df, student_df, how='inner', left_on=['First Name','Last Name'], right_on=['First Name','Last Name'])`

Merge preserves different cols same name with _x for left, _y for right.

#### Method chaining

good! Methods on objects return reference to the object.
>`(df.where(df['SUMLEV']==50)`  
>`.dropna()`  
>`.set_index(['STNAME','CTYNAME'])`  
>`.rename(columns={'ESTIMATESBASE2010': 'Estimates Base 2010'}))`

Multi line statements need parentheses  

Chain indexing (E.G. df.loc[KEY1][KEY2]) this is a bad code smell!!!

#### Control row printing

>`pandas.set_option('display.max_rows', None)`  
>`pandas.set_option('display.max_rows', 5)`

You can also reset an option back to its default value like this:

>`pd.reset_option('display.max_rows')`

or set directly:
>`pd.options.display.max_rows = 100`

### Map

Pass function and iterable, returns a list after running function on each object.

#### map to replace values with sparse dictionary lookup

>`GDP['Country Name'] = GDP['Country Name'].map(r2).fillna(GDP['Country Name'])`

#### Map to lookup in a dictionary when the index is the key

>`t6['Continent'] = t6.index.to_series().map(ContinentDict)`

#### Apply map

Pass function to operate on each cell of dataframe, returns a dataframe.  
Not so often used as all cells.

### Apply

Pass function, and dataframe axis to operate on. Good for function on rows.  
Operates on entire rows or cols.

>`apply(**lambda** x:1 **if** x **else** 0)`

To Create and return a series:

>`pd.Series({'min': np.min(data), 'max': np.max(data)})`

### Group by

Takes column names, splits into chunks, returns dataframe group by object. Tuple, first item is group condition, second item is the dataframe reduced by that condition. Could also give a function to group the data.

### Agg

Split data, apply function, then combine -- use group by .agg. Pass dictionary of cols interested in, and a function to apply. The dictionary can be used to either to identify the columns to apply a function on or to name an output column if there's multiple functions to be run. The difference depends on the keys that you pass in from the
dictionary and how they're named.

```conts = t6.groupby('Continent')  
con = conts['population'].agg({  
    'size': np.count_nonzero,  
    'sum': np.sum,
    'mean': np.mean,
    'std': np.std})
```

### Datatypes in dataframe

Often come out as object.  
prints the types of all cols
>`t2.dtypes`

to cast to different type with a dictionary:
>`df.astype({'col1': 'int32'}).dtypes`

## Lambda functions

>`Lambda x: x + 3`  

Here, x is the bound variable (argument), and the body is x+3. It's an expression, so it can be named, can't include
statements. Single line. Can take multiple parameters, comma separated.

>`Add_three = lambda x: x+ 3`  
>`Add_three(2)`  
>`5`

### Apply / Lambda

use apply/lambda pattern for complex manipulation

```Python
def custom_rating(genre,rating):
if 'Thriller' in genre:
return min(10,rating+1)
elif 'Comedy' in genre:
return max(0,rating-1)
else:
return rating

df['CustomRating'] = df.apply(lambda x: custom_rating(x['Genre'],x['Rating']),axis=1)
```

The general structure is:

- You define a function that will take the column values you want to play with to come up with your logic. Here the only two columns we end up using are genre and rating.

- You use an apply function with lambda along the row with axis=1. The general syntax is:

>`df.apply(lambda x: func(x['col1'],x['col2']),axis=1)`

You should be able to create pretty much any logic using apply/lambda since you just have to worry about the custom function.

Example:

```python
#creating a function and call on each row with apply
def checkrenew(x):
if (x > med):
return 1
else:
return 0
t6['HighRenew'] = t6['% Renewable'].apply(checkrenew)
```

## Stats in Numpy

Good to simulate an experiment and look at the results to get to conclusions without doing lots of maths. E.g. chance of a tornado is 1% on a day, whats the chance of 2 in a row. Simulate with numpy

```python
chance_of_tornado = 0.01
tornado_events = np.random.binomial(1, chance_of_tornado, 1000000)
two_days_in_a_row = 0
for j in range(1,len(tornado_events)-1):
    if tornado_events[j]==1 and tornado_events[j-1]==1:
        two_days_in_a_row+=1
print('{} tornadoes back to back in {}
years'.format(two_days_in_a_row, 1000000/365))
```

## Hypothesis testing

- Also called A/B testing. Experimentation, measure the impact of a change.  
- Set a hypotheses, including a null hypothesis.  
- Find evidence against the null hypo.  
- Choose significance level (alpha) for the amount of chance that the effect is noise you're happy to accept.  
- Typical values are 0.01, 0.1.  

### Usage

- Depends on the cost of the downside of wrong result, and the amount of noise.
- Scipi library has lots of significance tests. Use ttest to test this hypothesis. Tests expect a particular shape of data.
- P value is the value from the distribution to test against alpha.
- p-hacking / dredging: data science flaw - try lots of tests, when you try enough some will pass alpha. But you've done lots of tests!

### Remedies

- Bonferroni correction to decrease alpha by 1 / number of tests
- hold out sets (experiment on one set, test against the other)
- investigation pre-registration.

## Microsoft reactor on pandas

Look at NeilShamby68 on git.

Gitbhut: https://github.com/microsoft/reactors

To get to local env:  

- go to git, select fork, and that creates a fork of the repository in my git account.  
- Then need to get the code locally: clone a repository.  
- Then still need to pull. Connects to git, clones locally.  

good Pandas exercise: 
https://github.com/microsoft/Reactors/blob/main/Data_Science_1/Full_Day/3-Pandas.ipynb.  

https://notebooks.azure.com/jeremy-bates64

Open azure project, upload a file from github url.  
Can run jupyter from there.  

VS code is good. Lots of intellisense, built in git, can debug, extensions.  
Installed azure tools for vs code

Microsoft azure portal offers machine learning service to run Jupyter. Azure machine learning studio.  

numpy arrays are implicit index, pandas series is explicit. Series keys are ordered.  

resources: https://pandas.pydata.org/docs/getting_started/10min.html
