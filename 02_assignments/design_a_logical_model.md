# Assignment 1: Design a Logical Model

## Question 1
Create a logical model for a small bookstore. 📚

At the minimum it should have employee, order, sales, customer, and book entities (tables). Determine sensible column and table design based on what you know about these concepts. Keep it simple, but work out sensible relationships to keep tables reasonably sized. Include a date table. There are several tools online you can use, I'd recommend [_Draw.io_](https://www.drawio.com/) or [_LucidChart_](https://www.lucidchart.com/pages/).



![Logical_ERD_Q1](..\03_homework\bookStoreLogical1.jpeg)

## Question 2
We want to create employee shifts, splitting up the day into morning and evening. Add this to the ERD.


![Logical_ERD_Q2](..\03_homework\bookStoreLogical2.jpeg)

## Question 3
The store wants to keep customer addresses. Propose two architectures for the CUSTOMER_ADDRESS table, one that will retain changes, and another that will overwrite. Which is type 1, which is type 2?

_Hint, search type 1 vs type 2 slowly changing dimensions._

Type 1 Slowly changing dimension does not preserve history. Only the most recent version of the data is available.

Type1 SCD  

![Type1-Slowly_changing_dim](..\03_homework\CUSTOMER_ADDRESS_TYPE1.png)

Type 2 Slowly changing dimension does preserves history. New version of the customer address in inserted as a new row with addition columns like eff_strt_date and End date signifying which record in the current version.  

![Type2-Slowly_changing_dim](..\03_homework\CUSTOMER_ADDRESS_TYPE2.png)

Bonus: Are there privacy implications to this, why or why not?
```
Customer address is a personal data field. In order to prevent and privacy or ethical implications we must ensure this information is only available on the need basis. In all testing and development system this field should be masked. In production system there should be stringent data access rules to ensure that only those users who need the information should have access to the customer address details. 
```

## Question 4
Review the AdventureWorks Schema [here](https://i.stack.imgur.com/LMu4W.gif)

Highlight at least two differences between it and your ERD. Would you change anything in yours?
```
The AdventureWorks schema is an extremly detailed ER design, while our book store design is very simple. It seems the the Adventure works schema is normalised and each entity is defined taking into consideration all the factors around system performance and the ability to implement stringent data access policies. The two major differences i see are 
1. Our bookstore schema design was a simple star schema model, while the adventure works schema design looks like at least a 3NF schema design.  
2. Our bookstore model only has one schema while AdventureWorks model has multiple schemas each having a group of tables. 
```

# Criteria

[Assignment Rubric](./assignment_rubric.md)

# Submission Information

🚨 **Please review our [Assignment Submission Guide](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md)** 🚨 for detailed instructions on how to format, branch, and submit your work. Following these guidelines is crucial for your submissions to be evaluated correctly.

### Submission Parameters:
* Submission Due Date: `June 1, 2024`
* The branch name for your repo should be: `model-design`
* What to submit for this assignment:
    * This markdown (design_a_logical_model.md) should be populated.
    * Two Entity-Relationship Diagrams (preferably in a pdf, jpeg, png format).
* What the pull request link should look like for this assignment: `https://github.com/<your_github_username>/sql/pull/<pr_id>`
    * Open a private window in your browser. Copy and paste the link to your pull request into the address bar. Make sure you can see your pull request properly. This helps the technical facilitator and learning support staff review your submission easily.

Checklist:
- [ ] Create a branch called `model-design`.
- [ ] Ensure that the repository is public.
- [ ] Review [the PR description guidelines](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md#guidelines-for-pull-request-descriptions) and adhere to them.
- [ ] Verify that the link is accessible in a private browser window.

If you encounter any difficulties or have questions, please don't hesitate to reach out to our team via our Slack at `#cohort-3-help`. Our Technical Facilitators and Learning Support staff are here to help you navigate any challenges.
