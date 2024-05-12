About The Task


Based on the management requirements, various perspectives for product sales can be identified. On the one hand, articles are grouped into product categories 1 (alcoholic, nonalcoholic). Furthermore, it should be possible to analyze product sales by day, week, month, quarter, and year. In addition, each branch is assigned to a geographical region, according to which it should also be possible to aggregate:
• branch 1: east
• branch 2: west
• branch 3: north
• branch 4: north
• branch 5: east
• branch 6: west
For all customers, there is reference data to uniquely identify them:
• first name and family name
• address: street, number, ZIP code, city
• gender
• date of birth
Customers should be able to be classified by gender. Furthermore, it should be possible to to
aggregate by age group.
• child : 0 – 15 years
• youngster: 16 – 19 years
• young adult: 20 – 29 years
• adult: 30 – 49 years
• old adult: over 50 years

The data from the analyzed branch databases shall be loaded into the data warehouse. Here you will not just use simple data integration and normalization, but also duplicate detection. Below is an overview of the things to do in this task: 

1. Read customers, normalize their attributes, and clean them. 
2. Detect duplicate customer tuples, i. e. when a customer is registered in multiple branches and would thus be multiple times in your database if you simply copied the data. 
3. Read products, normalize, and clean their attributes. 
4. Calculate the turnover (sales volume) 
5. Calculate the amount of sales in liters for the turnover calculation 
6. Determine the age groups of customers Once found mappings of customers to branches should be saved separately. This way the mapping stays consistent and can be used to simplify repeated loading and/or duplicate detection procedures. 


Further advice: 

Assume that there was never an address change of a customer, i. e. the same customer always has the same address, no matter the branch or time. 

Every customer is only once registered per branch, i. e. inside a branch you do not have to find duplicate
