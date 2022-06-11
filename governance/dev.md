# Power BI Developer Handbook
This handbook is for everyone who wants to develop Power BI reports.

## How to Get Started?
To get started, you can contact...

To start learning the basics, the best place is the [official Microsoft Power BI learning path](https://powerbi.microsoft.com/en-us/learning/).

## Purpose of Best Practices
- Minimize report memory usage
- Saves lisence costs
- Makes report faster & usable for end users
- Easier development of reports
- Enables that all developers understand reports made by other developers

## Best Practices

### ETL
- Shape as close to the source as possible (e.g. sql better than M)
- Shape with M (or before), model with DAX
- Filter out unnecessary history of data by dynamic date filters. For example 'select previous 2 years of data'
- Use import unless you have a good reason not to

#### ETL Dataflows
- Use dataflows when the benefits outweight the effort
- Split to separate dataflows by different refresh cycles
- Large tables should have own dataflows
- With Power BI Premium dataflows can take advantage of computed entities and enhanced compute engine
    - So called staging dataflow should include only steps that support query folding in data source. Usually this means filtering out unnecessary rows and columns.
    - Other transformations should be done in computed entity that is created by referring staging dataflow. In computed entity transformations are done separately from data source in data lake behind dataflow.
    - First steps in computed entity should be steps that can be done by enhanced compute engine. This means steps like filter, distinct, group by or join. Also enhaced compute engine optimizes memory usage of report.
    - Rest of query steps are also done in computed entity. Report's dataset gets data from computed entity.

#### ETL Power Query M
- Minimize Power Query transformations
- Document query steps well by naming and writing descriptions in step properties
- Filter out unnecessary columns and rows in the beginning of queries
- Use functions and parameters for reusability of queries
- Don't duplicate queries, use reference instead
- If column is needed in query transformations but not in data model, remove column after transformations.
- Avoid heavy operations like merge, group by
- Unpivot pivoted (month) data

### Data Model
- Favor star schema
- Use calendar table (mark as date table)
- Display measures in a separate table @ and organize them into display folders
- Use a single "dataset_master" (single source of truth)
    - Exception 1: performance issues
    - Exception 2: you are absolutely sure that the things reported are not needed in a single report

#### Data Model: Tables
- Prefer long and narrow fact tables 
- Prefer short and fat dimension tables 
- Don't use auto-date table

#### Data Model: Columns
- Remove unused columns
    - Usually fact table primary key consumes the most memory, but is not actually required in the model 
- Set the correct data type for columns
- Split columns if possible
    - date & time
    - any other that can be splitted to lower cardinality
    - -> vertipaq engine packs low cardinality columns very efficiently
- Do not use floating point data types (fixed decimal takes less space)
- Avoid columns with long or many distinct strings. Use number fields instead of strings.
- Avoid calculated columns
- Reduce usage of calculated columns that use the RELATED function

#### Data Model: Relationships
- Avoid bi-directional against high-cardinality columns
- Avoid excessive bi-directional or many-to-many
- Many-to-many should be single direction
- Favor data type integer for relationship columns

### Naming
- Use descriptive names so that anyone can understand them (even without knowledge of data sources ecc.)
- Object names must not contain special characters (Tabs, line breaks, etc.)

#### Naming Tables
- Favor single word names, use CamelCase for multiword names 
- Dimensions singular
- Facts plural
- Don't use prefixes (Fact, Dim ecc.)
- Don't use spaces or special letters

#### Naming Columns
- Rename all used columns so they make sense to the end user
- Use spaces in column names
- CamelCase columns not meant to be shown in the data model

#### Naming Calculated Columns
- How to separate from measures?

#### Naming Measures
- Start with what the result represents (€, %, # ecc.)
- Use spaces if needed

### Usability
- Hide relationship columns
- Hide column if there's a measure with the same content
- Reference measures without table ([measure]) and columns with table (table[column name])

### Measures
- Use variables. 
    - Do not calculate same thing twice inside measure
    - Split long calculations into reasonable steps
- Reference other measure when doing new modified measure based on other measure
- Avoid filters with full table, use columns instead
- Apply most restrictive filter first
- Avoid heavy filter context change functions like SUMX, SUMMARIZE or GROUP BY (still better than columns)
- Never add new columns or calculations with SUMMARIZE, always use SUMMARIZE + ADDCOLUMNS
- DIVIDE instead of /
- Avoid IFERROR
- Use the TREATAS function instead 
	- of INTERSECT for virtual relationships
	- IN
- Use thousands separators
- % with single decimal
- Comment well

### Maintenance
- Remove everything not used or needed

## Reports
- Always use measures for aggregations (not columns)
- Limit number of visuals on a report page
- Remove unnecessary interactions between visuals
- Add info page to every report:
    - Report owner
    - Technical contact person/support
    - Last data refresh
    - Version history
    - Description of report
    - Calculation rules (searchable table)

## Additional Tools
- Use performance analyser
- Possible to use Dax Studio (external tool)
- Possible to use Tabular Editor (external tool)
- Possible to use ALM Toolkit (external tool)

# Handling .pbix Files
- Pbix files have to managed in a secure way because they usuallly include the data of the report
- Secure place for development team
- Keep version history, 5 latest versions

## References / Links

### Modeling
https://docs.microsoft.com/en-us/power-bi/guidance/star-schema

### Dataflows
https://docs.microsoft.com/en-us/power-bi/transform-model/dataflows/dataflows-best-practices

### Model
https://powerbi.microsoft.com/en-us/blog/best-practice-rules-to-improve-your-models-performance/
https://exceleratorbi.com.au/best-practices-power-pivot-power-query-power-bi/
https://www.sqlbi.com/articles/data-import-best-practices-in-power-bi/

### Queries / Refresh
https://medium.datadriveninvestor.com/my-dataset-is-taking-too-long-to-refresh-843fd8fd4a51
https://blog.crossjoin.co.uk/2020/02/03/visualising-power-query-diagnostics-data-in-a-power-bi-decomposition-tree/

