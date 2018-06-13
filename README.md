# README

Please check out a demo of this project: http://subtract.online


A few features to note:

1. The site is intended for child users and complies with the [Children's Online Privacy Protection Act](https://www.ftc.gov/enforcement/rules/rulemaking-regulatory-reform-proceedings/childrens-online-privacy-protection-rule). We do not collect personal information. Keeping the registration process as simple as possible, we do not require an email addresses to sign up. Restrictions on usernames and passwords are kept to a minimum: usernames must be unique (validated with ajax) and passwords must be at least 6 characters.

2. By default, the program selects 10 problems at a time to work on. This can be changed using the query parameter "problems" once the user has logged in. For example, if my username were "Name" and I wanted to practice only 3 problems, I could go to subtract.online/Name?problems=3

3. Additional problems can be selected for practice by clicking on them in the list.

4. A problem is "mastered" when it has been answered two times in less than 5 seconds each time.

5. The practice period runs until all selected problems have been mastered, or after a set time limit. The default time limit is 3 minutes, but the time limit can be changed using the query parameter "seconds" after the user has logged in. For example, subtract.online/Name?seconds=20

6. After a problem has been displayed for 5 seconds, a set of dots appears that can be used to help solve the problem. Each dot changes color when clicked.

7. The app keeps a record in the database of how many seconds a user has practiced each day, and how many problems have been answered that day. For now this information is only used in a greeting message, but in the future it could be displayed in a chart or graph.

8. For insight into how this app was designed, see [this blog post](https://medium.com/@kristenfletcherwilde/building-subtract-online-8db236689bb8).


