# Power BI Governance

## Purpose of Power BI Governance
Deploying Power BI is a complex task and it requires a lot of thought and planning. The purpose of this document is to store the practices and principles for successfully operating Power BI.

### Intended Audience
This document is a must read for every one involved with Power BI

### Scope of Power BI Governance Model
This document will cover only governance related Power BI topics.
- Reports are documented in a separete section called Reports.
- Report creation details are found Power BI Handbook.
- No data platform or source data architecture is covered here.
- This document describes only details about official data, unofficial data excluded.

### Principles and Vision of Power BI
- Identified Issues ?
- There should be no data silos
- Self-service and innovation is encouraged
- ...

### NDA Reminder
- All data, insights and visualizations available in Power BI are only for internal use and not to be shared with external users.

### Client Software
- There is no managed distribution. Power BI desktop can be downloaded freely, there's no Mac-version.

## Power BI Terminology

### Power BI Desktop
- Possible to build whole report
- Connect to dataset
- A lot of connectors to data sources
- Create queries
- Create data model
- Create measures, visuals & report pages
- Report can be saved as pbix file and published to Power BI Service as dataset and report.
- Developer can see all data
- Row level security roles are defined in PBI Desktop
- Using Power BI Desktop is free

### Power BI Service

#### Workspace
- Place where reports, datasets and dataflows are in Power BI Service
- Usually only admin users get access to workspaces
- Reports with different user rights are placed to different workspaces
- Power BI Pro license required
- My workspace is personal workspace that is meant for personal reports or testing purposes. You can schedule reports’ refreshes for free. Pro license is needed when sharing - report.
- Workspace can be assigned to different Power BI licenses
- Modern workspaces should be used

#### Dataset
- Includes report’s data, data model, measures
- Report is always based on dataset
- Refreshing report’s data is done through dataset settings
- Data model or data set’s queries can’t be modified in Power BI Service
- Workspace admins can see datasets.
- Dataset can be shared to Power BI developers, no need to share them to end users.
- End users are assigned to RLS roles

#### Report
- Report based on dataset
- In Power BI Service it is possible to create or edit report. It is not possible to create or edit measures or dataset. 
- It is not recommended to do any report editing in Power BI service
- Report can be shared from workspace but if sharing is done in Power BI Service it is better to use Power BI App
- Alerts, email subscriptions etc are done here

#### Power BI App
- App based on selected reports in one workspace
- Way to share reports to end users
- Easy to handle and good end user experience in Power BI service


#### Power BI Dataflow
- Way to load and transform data (query, replacing work done in PBI Desktop)
- Store data (Azure Data Lake Storage Gen 2)
- Using dataflows have many benefits compared to normal way of connecting data source via dataset
- It is easy to share transformed data to other reports and users
- Premium capacity optimizing is easy with dataflows. Performance of queries is better
- Dataflow integrates directly to Azure Machine learning and Cognitive Services

#### Data Gateway
- Agent installed within corporate network
- Enables secure and automated update of datasets using data sources that require a gateway
- For example on-prem database requires a gateway to automatically refresh data in Power BI service
        
## People & Responsibilities
Without responsibilities the result will just be a big mess. Here you can see who is reponsible and for what.

<table>
    <tr>
        <th>Role</th>
        <th>Responsibilities</th>
        <th>Person(s) Responsible</th>
    </tr>
    <tr>
        <td>Product Owner</td>
        <td> 
            <ul>
                <li>Project approval and sign-off</li>
                <li>Owns the Data transformation initiative at Company</li>
                <li>Tool assessment</li>
                <li>Prioritization of business areas</li>
            </ul>
        </td>
        <td>"Names..."</td>
    </tr>
    <tr>
        <td>Microsoft 365 Admin</td>
        <td>
            <li>Azure AD</li> 
            <li>Licenses</li> 
        </td>
        <td></td>
    </tr>
    <tr>
        <td>Data solution owner</td>
        <td>
            <li>Grant access to data for Power BI Developers</li> 
        </td>
        <td></td>
    </tr>
    <tr>
        <td>Data engineer</td>
        <td> 
            <li>Create and maintain business data</li>
            <li>Enhance data quality</li>
            <li>Maintain the Data Catalogue and the Data Dictionary</li>
        </td>
        <td></td>
    </tr>
    <tr>
        <td>Power BI environment manager (Admin)</td>
        <td> 
            <li>Tenant settings</li>
            <li>Service status monitoring and issue resolution</li>
            <li>Premium capacity monitoring</li>
            <li>Gateway support and access management</li>
            <li>Developing an architecture that meets the security and governance standards of the organization</li>
        </td>
        <td></td>
    </tr>
    <tr>
        <td>Power BI dataset/dataflow developer</td>
        <td> 
            <li>Create dataflows</li>
            <li>Make new data sources available for self-service (new datasets)</li>
            <li>Enhance existing solutions</li>
            <li>Release management process</li>
        </td>
        <td></td>
    </tr>
    <tr>
        <td>Power BI report author</td>
        <td> 
            <li>Build reports</li>
            <li>Build report themes</li>
            <li>Support business users & report owners</li>
        </td>
        <td></td>
    </tr>
    <tr>
        <td>Power BI report owner</td>
        <td> 
            <li>Testing of the reports and validating the data</li>            
            <li>Approving report for production use</li>            
            <li>Managing development requirements for reports</li>            
            <li>Managing distribution of reports</li>            
            <li>Introduce reports organization</li>            
        </td>
        <td></td>
    </tr>
   
</table>


## Continuous Adoption
Time to look at what is currently possible.

If you want to know how to get started, see support.

### Official Reports and Self-Service Reports
<table>
    <tr>
        <th></th>
        <th>Official</th>
        <th>Self-service</th>
    </tr>
    <tr>
        <td>Creation</td>
        <td>Dataset developers / report authors</td>
        <td>Anyone</td>
    </tr>
    <tr>
        <td>Sharing</td>
        <td>Via Official workspaces / apps</td>
        <td>Via My Workspace</td>
    </tr>
    <tr>
        <td>License</td>
        <td>Premium/Embedded/Pro</td>
        <td>Free (publish to web)/Pro (shared)</td>
    </tr>
</table>

### Licensing
Everyone can use Power BI Service and Power BI desktop with free per-user license for personal BI purposes.

Pro license is required to connect to available datasets and pro licenses are assigned by Power BI administrator.

"Our company" uses "type of licensing" for report viewers. If you need a license check section support.

### Support

- Licensing requests
support@company.com or helpdesk.

- Help with official reports
report owners

- Help with building reports
check Power BI developer handbook (link)

- Other 
try the Slack channel ...

## Environment

### Overview
- Data Sources
- Data Sources Available for Self-Service
- How to Get New Data Available

### Authentication
- Authentication is managed in Azure AD


### Power BI Service

#### Access Control
- Tenant Settings
- Workspaces
    - Roles
- Data Pipeline
- Data Availability for Official Reports (source, location, expert, content)
    - Object Level Security
    - Row Level Security
- Dataflows (name, content, refresh schedule, approved by?)
- Reports
    - Link to report documentation

### Power BI Desktop
- Secure File Handling, There is no built-in version control .pbix files. Best way is to store individual files containing the changes. Power BI Desktop files are stored in Google Drive in a folder under Internal projects > Power BI where only Power BI developers and selected individuals have access. 

Files should never be stored on personal computers.
- Version Control, Although the .pbix file does not have version control it is possible to use GIT for the contents of the files. All sql queries, images, m queries and themes are stored in
- Custom Visuals, It is possible to create custom visuals, if the standard visuals don't meet all the requirements.

### Gateways
- Name / Owner

## Development

### Development Flow
- Use dev/test/prod workspaces

### Who can do what?
<table>
    <tr>
        <th> </th>
        <th>Dataset Developer</th>
        <th>Report Author</th>
        <th>Report Viewer</th>
        <th>Citizen Dev / Personal BI</th>
        <th>External User</th>
    </tr>
    <tr>
        <td>
            Create datasets
        </td>
        <td>
            - Yes
        </td>
        <td>
            - No
        </td>
        <td>
            - No
        </td>
        <td>
            - No
        </td>
        <td>
            - Not allowed
        </td>
    </tr>
    <tr>
        <td>
            Create official reports
        </td>
        <td>
            - Yes
        </td>
        <td>
            - Yes
        </td>
        <td>
            - No
        </td>
        <td>
            - Via validation process
        </td>
        <td>
            - Not allowed
        </td>
    </tr>
    <tr>
        <td>
            Create unofficial reports
        </td>
        <td>
            - Yes
        </td>
        <td>
            - Yes
        </td>
        <td>
            - Yes
        </td>
        <td>
            - Yes
        </td>
         <td>
            - Not allowed
        </td>
    </tr>
    <tr>
        <td>
            Share reports
        </td>
        <td>
            - Yes*
        </td>
        <td>
            - Yes*
        </td>
        <td>
            - No
        </td>
        <td>
            - From My Workspace
        </td>
         <td>
            - Not allowed
        </td>
    </tr>
    <tr>
        <td>
            Access to data
        </td>
        <td>
            - Directly to data sources
        </td>
        <td>
            - Power BI datasets*
        </td>
        <td>
            - Via Reports only
        </td>
        <td>
           - Power BI datasets*
        </td>
         <td>
            - Not allowed
        </td>
    </tr>
    <tr>
        <td>
            License
        </td>
        <td>
            - Pro
        </td>
        <td>
            - Pro
        </td>
        <td>
            - Premium/Embedded/Pro
        </td>
        <td>
            - Free
        </td>
         <td>
            - Not allowed
        </td>
    </tr>
</table>
* Reports and datasets are shared by O365 Admin via AD user groups.

### Deployment
1. Develop the report in test environment (test workspaces)
2. Report owner will test the report
3. Report owner will approve the report
4. Go into production
5. Distribute via correct Microsoft 365 groups
		
## Maintenance

### Data Refresh in Power BI Service
- Set email notification if any Dataflow / dataset refresh fails
- Don't schedule everything to refress at the same time
- Add support to copy as each fail notification?

### Monitoring Report Usage
- Usage metrics
- Power BI Governance report (custom)

### Monitoring Power BI Tenant
- Premium / Embedded capacity
- Audit Log

### Gateway to Power BI Service
- Gateway updates
- Gateway server

### Other
- Tenant settings
- Licenses
- Power BI handbook updates
- Official report changes
- Roadmap and new features