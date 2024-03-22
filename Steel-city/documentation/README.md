# Project Name
Steel city stories team 25 - web platform for sharing and writing stories related to Sheffield and its culture.

## Overview - implemented 
<!-----



Conversion time: 2.732 seconds.


Using this Markdown file:

1. Paste this output into your source file.
2. See the notes and action items below regarding this conversion run.
3. Check the rendered output (headings, lists, code blocks, tables) for proper
   formatting and use a linkchecker before you publish this page.

Conversion notes:

* Docs to Markdown version 1.0β35
* Fri Mar 22 2024 06:45:28 GMT-0700 (PDT)
* Source doc: Group Project
* Tables are currently converted to HTML tables.
----->



# Stories From Steel City - Group 25

By Theo Johnson-Martin, Adam Bentley, Myron Sukhanov, James Godfrey, Nick Efe Oni, Jake Whiteley.

**Scope of the project:** \
We are going to create a website for sharing stories about Sheffield. Writer accounts will be able to submit these stories which will be displayed on the website. Writers will also be able to create and publish polls on what features readers would like to see more of in the stories e.g. which characters they would like to read more of or what direction they would like the story to head in. Readers should be able to subscribe to writers to gain the ability to vote in those writers' polls and be notified when a writer uploads a new chapter or story. The website will contain an online currency called popcorns which will be purchasable by readers using COM_Pounds. Readers will be able to spend popcorns to gain access to and read stories written by other users who will, in turn, receive a portion of the popcorns spent by the user to read the story. Users will also be able to buy a premium reader account which will increase the monthly free popcorns that they receive as well as get discounts to buy and read stories and users. Moreover, users will be capable of buying popcorns directly to get an immediate injection of popcorns into their account. Promotional campaigns will also be run on the website like things such as: the top 10% of readers would be offered a discount on purchasing popcorn credits and one lucky reader a month who correctly predicted a poll would receive a jackpot of popcorn credits.

**Stakeholders:**



* Owner: Steel Lee - Needs the website to have financial success.
* Steel Lee’s company: Peak District Prose (PDP) - Needs to ensure sufficient pay for employees.
* Shareholders invested in PDP: Needs to ensure investment is worthwhile to keep confidence in the owner and company.
* Users: Wants to enjoy Sheffield-centred stories provided by the website.
* Employees/staff: Need to receive payment in exchange for the work done within the company.

**Types of users:**



* Staff members:
    * Moderators - staff members that moderate the content, can delete all content from other users.
    * Management accounts - Run promotional campaigns to offer discounts to the top users and offer rewards to the user who guesses the outcome of a pole correctly each month.
    * Developer accounts - used in developing and testing the website - have access to all.
* Writers - can create, edit and delete chapters/stories from their own account.  
* Premium Readers - pay using popcorns to obtain a premium subscription where they get discounts on popcorns and stories.
* Readers - can read others content with the free popcorns they receive every month. Are notified when a writer they subscribe to, posts a new chapter or poll.


# **Stories**


```
Priority
We've chosen the dynamic/relative priority estimation. Since, the number of stories may change, we claster all the stories/features into 10 buckets, with bucket number 1 being the highest priority. That approach is considered to be more agile, and allows for dynamic bucket size. Higher priority stories will be worked on earlier than the lower priority stories. Stories with priority 10 are the non-compulsory, 'would be nice to include' requirements.
```



<table>
  <tr style="background-color: purple;">
   <td><strong>Priority</strong>
   </td>
   <td><strong>Type of user</strong>
   </td>
   <td><strong>Goal</strong>
   </td>
   <td><strong>Reason</strong>
   </td>
   <td><strong>Acceptance Criteria</strong>
   </td>
   <td><strong>Time estimation</strong>
   </td>
  </tr>
  <tr style="background-color: rgb(202, 98, 18);">
   <td>9
   </td>
   <td>User
   </td>
   <td>To be able to access the website on the internet.
   </td>
   <td>To be able to view the website.
   </td>
   <td>Verify that, if connected to the internet when I click on the website, link the website loads up.
<p>
Verify that all pages of the site work as intended.
   </td>
   <td>1
   </td>
  </tr>
  <tr>
   <td>2
   </td>
   <td>User
   </td>
   <td>To be able to create an account.
   </td>
   <td>To be able to retain data of my progress on the website and what I have spent.
   </td>
   <td>Verify that upon entering correct details, those details are stored.
<p>
Verify that, after an account is created, the user can log in.
<p>
Verify that accounts can only be created if the user claims to be ≥13 years old.
   </td>
   <td>5
   </td>
  </tr>
  <tr style="background-color: darkgreen;">
   <td>4
   </td>
   <td>User
   </td>
   <td>To be able to register via a valid email address.
   </td>
   <td>To limit the amount of bots that can create accounts to prevent spam.
   </td>
   <td>Verify that the email is saved on a database. \
Verify that accounts have a verified property. \
Verify that an email is sent to the email of the user, and that email contains a link that sets the verified property of the account to true.
   </td>
   <td>5
   </td>
  </tr>
  <tr>
   <td>4
   </td>
   <td>User
   </td>
   <td>To be able to register a unique username.
   </td>
   <td>To be recognisable to other users on the website.
   </td>
   <td>Verify that the username is stored in a database of all usernames.
<p>
Verify that if the entered username is a duplicate of one on the database an error message is displayed to the user to convey this.
<p>
Verify that if the username contains profanity then it is declined from being used and an error message is shown.
   </td>
   <td>3
   </td>
  </tr>
  <tr>
   <td>4
   </td>
   <td>User
   </td>
   <td>To be able to register a valid and secure password for my account.
   </td>
   <td>To keep my account and data secure and stop anyone undesired from accessing it.
   </td>
   <td>Verify that when entering the password the characters are hidden.
<p>
Verify that the passwords are stored, transported and secured securely in a database.
<p>
Verify that when entering the password there is a strength checker which indicates how secure the password is.
   </td>
   <td>5
   </td>
  </tr>
  <tr>
   <td>3
   </td>
   <td>User
   </td>
   <td>To be able to choose if to have only a reader account or a reader & writer account.
   </td>
   <td>Not everyone wants to write stories.
   </td>
   <td>Verify that, during account creation, selecting the reader option creates a reader account.
<p>
Verify that, during account creation, selecting the writer option creates a writer account.
   </td>
   <td>1
   </td>
  </tr>
  <tr>
   <td>8
   </td>
   <td>Account Holder
   </td>
   <td>To be able to report stories as pirated/offensive or if there is a breach in copyright.
   </td>
   <td>So that moderation can review the stories and see whether they’re eligible for deletion.
   </td>
   <td>Verify that, upon clicking the report button, a report notification is sent to all staff accounts linking them to the story.
   </td>
   <td>2
   </td>
  </tr>
  <tr>
   <td>6
   </td>
   <td>Account Holder
   </td>
   <td>To be able to upvote/downvote posts.
   </td>
   <td>So that stories with more upvotes are recommended to more people.
   </td>
   <td>Verify that when the upvote/downvote button is clicked, the total number of upvotes/downvotes increases
<p>
Verify that stories with more upvotes are more likely to be recommended to readers and they appear higher on the feed of readers.
   </td>
   <td>8
   </td>
  </tr>
  <tr>
   <td>7
   </td>
   <td>Account Holder
   </td>
   <td>To be able to contact staff in order to rectify issues with the website.
   </td>
   <td>So that any bugs or suggestions on improvements can be made.
   </td>
   <td>Verify that when an account holder clicks the contact staff button, the details are sent to all staff accounts under a ‘user contact’ notification.
   </td>
   <td>2
   </td>
  </tr>
  <tr>
   <td>6
   </td>
   <td>Account Holder
   </td>
   <td>To be able to edit the details I entered to create my account.
   </td>
   <td>Users' personal information may change over time. Allowing them to edit their account details helps keep the information up to date.
   </td>
   <td>Verify that clicking the edit details button next to the relevant detail in the account tab allows the user to input a replacement.
<p>
Verify that upon clicking the confirm button, the data is changed in all relevant locations.
   </td>
   <td>2
   </td>
  </tr>
  <tr>
   <td>4
   </td>
   <td>Writer
   </td>
   <td>To be able to set the price in popcorns to read my stories.
   </td>
   <td>Writers know how much their own stories are worth and what they are willing to charge the readers.
   </td>
   <td>Verify that once the writer has uploaded their chapter with its chosen price, a reader account will also see that they have to pay the same amount as selected by the writer.
   </td>
   <td>2
   </td>
  </tr>
  <tr>
   <td>1
   </td>
   <td>Writer
   </td>
   <td>To be able to post a story onto the website.
   </td>
   <td>So the website has some viewable content stimulating entertainment.
   </td>
   <td>Verify that when a writer submits a typed story to be posted that it appears on the site. \
Verify that a reader account can read the story that the writer has posted, and the text shown to the reader is the same as the text submitted by the writer.
   </td>
   <td>8
   </td>
  </tr>
  <tr>
   <td>1
   </td>
   <td>Writer
   </td>
   <td>To be able to type a story into the website.
   </td>
   <td>So the website has some viewable content.
   </td>
   <td>Verify that the writer can input text into the story box.
<p>
Verify that the writer can post the text to the website.
<p>
Verify the text is accessible by users upon payment of popcorns.
<p>
Verify the writer can access the story via the stories tab.
   </td>
   <td>3
   </td>
  </tr>
  <tr>
   <td>6
   </td>
   <td>Writer
   </td>
   <td>To be able to conduct a poll.
   </td>
   <td>To determine what reader accounts want.
   </td>
   <td>Verify that when the relevant buttons are selected a poll appears.
<p>
Verify that reader accounts can interact with the poll.
   </td>
   <td>5
   </td>
  </tr>
  <tr>
   <td>4
   </td>
   <td>Writer
   </td>
   <td>To be able to switch modes on my account.
   </td>
   <td>So that I can read other writers' stories.
   </td>
   <td>Verify that selecting the reader mode as a writer allows you access to the reader features.
<p>
Verify that when a writer account is in reader mode, it can switch back to writer mode.
   </td>
   <td>8
   </td>
  </tr>
  <tr>
   <td>5
   </td>
   <td>Writer
   </td>
   <td>To be able to receive a portion of the popcorns spent by each reader.
   </td>
   <td>To be rewarded for my work.
   </td>
   <td>Verify that when a reader selects to read a story, the popcorns in the writer account increases by the specified percentage of the popcorns removed from the reader account.
   </td>
   <td>3
   </td>
  </tr>
  <tr>
   <td>6
   </td>
   <td>Writer
   </td>
   <td>To be able to see all the stories I have published so far.
   </td>
   <td>Marking progress history and popcorns received.
   </td>
   <td>Verify that there is an accessible page that stores all of the writers published stories and that the writer can read these stories.
   </td>
   <td>3
   </td>
  </tr>
  <tr>
   <td>6
   </td>
   <td>Writer
   </td>
   <td>To be able to see all of the polls I have conducted so far.
   </td>
   <td>Keeping record of reader opinion about stories.
   </td>
   <td>Verify that the polls tab displays all the polls the writer has posted.
<p>
Verify that clicking on these polls takes you to the relevant story and displays the correct statistics.
   </td>
   <td>3
   </td>
  </tr>
  <tr>
   <td>8
   </td>
   <td>Writer
   </td>
   <td>To be able to see the monthly number of readers for each story.
   </td>
   <td>Recording popularity metrics of stories.
   </td>
   <td>Verify that the monthly viewers statistic displays the correct value.
   </td>
   <td>2
   </td>
  </tr>
  <tr>
   <td>9
   </td>
   <td>Writer
   </td>
   <td> I want to be able to see the total number of subscribers.
   </td>
   <td>Observing popularity & metrics of the writer.
   </td>
   <td>Verify that the total subscribers statistic displays the correct value.
   </td>
   <td>2
   </td>
  </tr>
  <tr>
   <td>8
   </td>
   <td>Writer
   </td>
   <td>To be able to see monthly and total earnings.
   </td>
   <td>Keeping track of money for banking and tax purposes.
   </td>
   <td>On the writer’s account tab, verify that the monthly earnings displayed is equal to the expected value.
<p>
On the writer’s account tab, verify that the total earnings displayed is equal to the expected value.
   </td>
   <td>3
   </td>
  </tr>
  <tr>
   <td>3
   </td>
   <td>Writer
   </td>
   <td>To be able to buy extra popcorns when I’m in reader mode.
   </td>
   <td>So that low earning writers can still read other stories if they want to.
   </td>
   <td>Verify that a reader/writer account in reader mode can attempt to buy popcorns. \
Verify that the correct amount of COM_pounds is subtracted from the user total, and the correct amount of popcorns is added to the user total.
   </td>
   <td>8
   </td>
  </tr>
  <tr>
   <td>6
   </td>
   <td>Writer
   </td>
   <td>To be able to write a blurb for my story.
   </td>
   <td>To attract readers to spend popcorns on it.
   </td>
   <td>Verify that the writer can input a blurb into the relevant text box.
<p>
Verify that the entered blurb is displayed under the story title.
   </td>
   <td>2
   </td>
  </tr>
  <tr>
   <td>3
   </td>
   <td>Writer
   </td>
   <td>To be able to edit my stories after they’ve been posted.
   </td>
   <td>So that I can fix typos and grammatical errors.
   </td>
   <td>Verify that a writer can go on any of their previously posted stories and select an edit button.
<p>
Verify that when the button is selected an editor is opened which can be used to change the content of stories.
<p>
Verify that when the edits are confirmed the stories are actually changed on the website.
   </td>
   <td>8
   </td>
  </tr>
  <tr>
   <td>7
   </td>
   <td>Writer
   </td>
   <td>To be able to choose the genres that the story is in.
   </td>
   <td>So that people will be able to find my story by searching by genre.
   </td>
   <td>Verify that once the genres have been selected the story shows up to be in those genres.
   </td>
   <td>3
   </td>
  </tr>
  <tr>
   <td>2
   </td>
   <td>Reader
   </td>
   <td>To be able to purchase popcorns using COM_pounds.
   </td>
   <td>Get popcorns for further usage.
   </td>
   <td>Verify that when the option is selected, the correct amount of COM_pounds is subtracted from the user total and the correct amount is added to the popcorn user total.
   </td>
   <td>3
   </td>
  </tr>
  <tr>
   <td>3
   </td>
   <td>Reader
   </td>
   <td>To be able to subscribe to writers I enjoy.
   </td>
   <td>Allowing the reader to more easily find stories to read.
   </td>
   <td>Verify that upon clicking the subscribe button, the writer is added to the users subscriptions.
<p>
Verify that a subscribed user gets a notification upon a subscription posting a story.
   </td>
   <td>13
   </td>
  </tr>
  <tr>
   <td>3
   </td>
   <td>Reader
   </td>
   <td>To be able to spend popcorns to unlock chapters of stories.
   </td>
   <td>To be able to read stories.
   </td>
   <td>Verify that the chapter price value of popcorns is removed upon spending popcorns on a story.
<p>
Verify that the reader is not allowed to buy a chapter if they have insufficient popcorns.
   </td>
   <td>3
   </td>
  </tr>
  <tr>
   <td>6
   </td>
   <td>Reader
   </td>
   <td>To be able to vote in writer polls.
   </td>
   <td>To show to the writer what I prefer as a reader.
   </td>
   <td>Verify that voting in a poll updates the statistic and that update is provided to the writer.
   </td>
   <td>3
   </td>
  </tr>
  <tr>
   <td>6
   </td>
   <td>Reader
   </td>
   <td>To be able to view the results of concluded polls.
   </td>
   <td>Allowing the reader to check public opinion of stories that may shape future stories.
   </td>
   <td>Verify that the displayed statistic of the poll is the same as the statistic the poll gathered.
   </td>
   <td>2
   </td>
  </tr>
  <tr>
   <td>4
   </td>
   <td>Reader
   </td>
   <td>To receive an amount of free popcorns every month.
   </td>
   <td>To be able to read some of the payable stories.
   </td>
   <td>Verify that the amount of popcorns in every reader account increases by the specified amount at the correct time.
   </td>
   <td>2
   </td>
  </tr>
  <tr>
   <td>4
   </td>
   <td>Reader
   </td>
   <td>To be able to purchase a premium account.
   </td>
   <td>Being allowed to read a greater amount of stories without paying to read specific stories.
   </td>
   <td>Verify that the user can attempt to switch their account to a premium reader account. \
Verify that the correct amount of COM_poounds is subtracted from the user total and the premium attribute of the user account is set to true.
   </td>
   <td>5
   </td>
  </tr>
  <tr>
   <td>7
   </td>
   <td>Reader
   </td>
   <td>To be able to read a blurb of any story that I choose.
   </td>
   <td>So that I can decide which stories I want to spend my popcorns on.
   </td>
   <td>Verify that reader accounts can click on stories and read the blurb the writer has inputted.
   </td>
   <td>2
   </td>
  </tr>
  <tr>
   <td>4
   </td>
   <td>Premium Reader
   </td>
   <td>To receive a greater amount of free popcorns every month.
   </td>
   <td>To be able to read more of the payable stories.
   </td>
   <td>Verify that a reader account with the premium attribute as true receives the specified greater amount of popcorns due to a premium reader account, when free popcorns are given out to reader accounts.
   </td>
   <td>1
   </td>
  </tr>
  <tr>
   <td>4
   </td>
   <td>Premium Reader
   </td>
   <td>To receive discounts to read stories.
   </td>
   <td>So that the premium reader can read more stories.
   </td>
   <td>Verify that for reader accounts with the premium attribute true, the popcorn cost of stories is shown as discounted by the specified value, and that this discounted value is subtracted from the account upon the premium reader unlocking a story.
   </td>
   <td>3
   </td>
  </tr>
  <tr>
   <td>4
   </td>
   <td>Reader
   </td>
   <td>To be able to choose the length of the subscription: \
one-time, monthly or yearly payment.
   </td>
   <td>To choose between various tradeoffs manually.
   </td>
   <td>Verify that the subscription will run out after the correct amount of time by testing with a smaller number. 
<p>
Verify that the different subscriptions cost the appropriate amounts.
   </td>
   <td>3
   </td>
  </tr>
  <tr>
   <td>8
   </td>
   <td>Moderator
   </td>
   <td>To be able to delete accounts.
   </td>
   <td>To remove outdated accounts, offensive or problematic accounts that violate rules.
   </td>
   <td>Verify that upon clicking the delete account button, all the users personal and account details are removed from storage.
<p>
Verify that only staff accounts or the account holder themself can do this action.
   </td>
   <td>3
   </td>
  </tr>
  <tr>
   <td>8
   </td>
   <td>Moderator
   </td>
   <td>To be able to alter popcorn credits from accounts.
   </td>
   <td>To remove illegally gained popcorns and add popcorns in the event of a failed transaction or such.
   </td>
   <td>Verify that upon clicking the alter popcorns option, the staff member can input a new value of popcorns.
<p>
Verify that the inputted value is displayed and stored as the value of the users popcorns.
<p>
Verify that only staff accounts can do this action.
   </td>
   <td>3
   </td>
  </tr>
  <tr>
   <td>7
   </td>
   <td>Moderator
   </td>
   <td>To make other accounts staff accounts.
   </td>
   <td>Allows for better moderation/control on the platform.
   </td>
   <td>Verify that upon clicking the make staff option, the selected account is converted into a staff account.
<p>
Verify that only staff accounts can do this action.
   </td>
   <td>2
   </td>
  </tr>
  <tr>
   <td>7
   </td>
   <td>Moderator
   </td>
   <td>To be able to read, delete and edit any stories.
   </td>
   <td>Allows for moderation of stories that could contain offensive content.
   </td>
   <td>Verify that a staff account is able to alter and view any story without the popcorn value being removed from their total. \
Verify that an edit made by a staff account is viewable by a reader account.
<p>
Verify that only staff accounts can do this action.
   </td>
   <td>5
   </td>
  </tr>
  <tr>
   <td>8
   </td>
   <td>Management
   </td>
   <td>To be able to run promotional campaigns.
   </td>
   <td>To draw new users into the website and keep existing users active.
   </td>
   <td>Verify that a staff account can upload a promotional campaign.
<p>
Verify that only staff accounts can do this action. \
Verify that both reader and writer accounts can view the promotional campaign.
<p>
Verify that a promotional campaign is removed after its allotted time slot, and that non-staff accounts do not view the campaign after the time slot is over.
   </td>
   <td>13
   </td>
  </tr>
  <tr>
   <td>8
   </td>
   <td>Management
   </td>
   <td>To be able to identify the top users of the website by stories read and polls interacted.
   </td>
   <td>To select which users are valid from promotional campaigns.
   </td>
   <td>Verify that the interactions a user does are stored and accessible by staff.
<p>
Verify that applying a percentage filter produces the correct list of users.
<p>
Verify that only staff accounts can do this action.
   </td>
   <td>5
   </td>
  </tr>
  <tr>
   <td>8
   </td>
   <td>Account Holder
   </td>
   <td>Promotional campaigns should be able to offer discounts to the top 10% of users.
   </td>
   <td>To reward those users and keep them even more engaged.
   </td>
   <td>Verify that, upon selecting the promotional campaign, the user is given the relevant discount.
<p>
Verify that only the top 10% from interaction users are presented with promotional campaigns.
   </td>
   <td>3
   </td>
  </tr>
  <tr>
   <td>8
   </td>
   <td>Management
   </td>
   <td>Promotional campaigns should be able to give a popcorn jackpot to a random reader who correctly predicted a poll outcome.
   </td>
   <td>To reward those users and keep them even more engaged.
   </td>
   <td>Verify that only a person who predicted correctly can win the jackpot.
<p>
Verify the credits are delivered to that account only.
   </td>
   <td>3
   </td>
  </tr>
  <tr>
   <td>5
   </td>
   <td>Account Holder
   </td>
   <td>To be able to search for specific stories in a search bar on the webpage.
   </td>
   <td>So that I can find the stories I want to read.
   </td>
   <td>Verify that when you load the homepage there is a search bar at the top of the screen.
<p>
Verify that when a specific story is typed into the search bar all stories with that name or similar will appear in a list below starting with the most similar/exact same name. Verify that when no results are returned show a message box ‘No results found’.
   </td>
   <td>8
   </td>
  </tr>
  <tr>
   <td>7
   </td>
   <td>Reader 
   </td>
   <td>To be able to select the genres of stories that I’m most interested in when I first create my account.
   </td>
   <td>So the suggested stories for the reader are actually engaging for them so they will keep coming back to the website.
   </td>
   <td> Verify that when a user creates a reader account they have the option to select different genres of fictional writing.
<p>
 Verify when the reader looks at their suggested stories it mainly consists of their preferred genres.
   </td>
   <td>3
   </td>
  </tr>
  <tr>
   <td>7
   </td>
   <td>User
   </td>
   <td>To be able to view high contrast text on the website.
   </td>
   <td>So that the text isn’t difficult to read especially for visually impaired users.
   </td>
   <td>Verify that all text on the website has a significant contrast ratio to the background colour it is in front of.
   </td>
   <td>1
   </td>
  </tr>
  <tr>
   <td>6
   </td>
   <td>User
   </td>
   <td>To be able to view fonts at the appropriate size for the browser width I am accessing it on.
   </td>
   <td>So that the content of the website is easy to read for any user and the website is aesthetically pleasing to keep users engaged.
   </td>
   <td>Verify that when the browser width is changed significantly so does the font-size to at least a readable size.
   </td>
   <td>5
   </td>
  </tr>
  <tr>
   <td>8
   </td>
   <td>Account Holder
   </td>
   <td>To be able to change their personal details that they entered when registering for an account.
   </td>
   <td>So that if any information changes or was inputted wrong, the account can reflect the correct data for the users details.
   </td>
   <td>Verify that the user can open a menu that allows them to alter their account details in the website. \
Verify that when the user alters these account details using the website menu, the details change on the user database and the changes are permanent.
   </td>
   <td>2
   </td>
  </tr>
  <tr>
   <td>8
   </td>
   <td>Account Holder
   </td>
   <td>To be able to contact staff if they face any issues with their account.
   </td>
   <td>So that if any issues occur a site worker can be contacted to solve them on the fly.
   </td>
   <td>Verify that the website has a support system accessible by users that sends a ticket for staff to see. \
Verify that tickets can be seen by staff and the user is also transferred along so that staff can fix the issue that has come up.
<p>
Verify the user can access the form from their account menu.
   </td>
   <td>3
   </td>
  </tr>
  <tr>
   <td>5
   </td>
   <td>Account Holder
   </td>
   <td>To be able to login securely and passwords must be stored and accessed securely.
   </td>
   <td>So that the website is secure to attacks and users can safely trust their details with the website, also a legal requirement.
   </td>
   <td>Verify that passwords are stored in the database as hashes and are not saved in plaintext or non hashed anywhere.
<p>
Verify that the user can log in using their password and the server verifies the login by using the database hashed passwords.
<p>
Verify that no other passwords work for users other than the correct one.
   </td>
   <td>5
   </td>
  </tr>
  <tr>
   <td>7
   </td>
   <td>Reader
   </td>
   <td>To be able to view a page of similar stories to previously read stories.
   </td>
   <td>To allow the user to easily find stories they may enjoy.
   </td>
   <td>Verify that the stories recommended are similar to those read using genre, writer etc.
   </td>
   <td>13
   </td>
  </tr>
  <tr>
   <td>7
   </td>
   <td>Reader
   </td>
   <td>To be able to view a page of current promotional campaigns and polls if relevant.
   </td>
   <td>To promote user engagement and inform them of currently running promotions.
   </td>
   <td>Verify that promotional campaigns are only promoted to users that fit the requirements (I.E. Top 10%).
<p>
Verify that only polls related to read chapters are displayed.
<p>
Verify the user is notified when a subscription posts a poll.
   </td>
   <td>5
   </td>
  </tr>
  <tr>
   <td>10
   </td>
   <td>Premium Reader
   </td>
   <td>To allow premium readers early access to chapters from their subscriptions.
   </td>
   <td>To encourage more users to purchase premium.
   </td>
   <td>Verify only the writer premium readers can access the chapter early.
<p>
Verify the writer can set the date to be released to the public.
<p>
Verify the writer can set the date to be released to premium readers.
   </td>
   <td>5
   </td>
  </tr>
  <tr>
   <td>10
   </td>
   <td>Writer
   </td>
   <td>To allow writers to use formatting methods (I.E. Italics, underline etc).
   </td>
   <td>To allow writers more freedom when inputting their stories.
   </td>
   <td>Verify that when a formatting method is selected, it is applied to the relevant text.
<p>
Verify these changes are displayed on the public story.
   </td>
   <td>5
   </td>
  </tr>
</table>



## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Documentation Contents](#documentation-contents)
- [Additional Information](#additional-information)
- [License](#license)

## Installation
```bash
$ bundle install
$ git pull
$ cd project/Steel-city/src/app.rb
$ sinatra app.rb
```
## Usage


## Folder Structure
