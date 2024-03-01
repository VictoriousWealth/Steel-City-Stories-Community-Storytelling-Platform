CREATE TABLE IF NOT EXISTS "users"(userid INTEGER PRIMARY KEY, username TEXT, password TEXT, email TEXT, dateofbirth TEXT, type TEXT, premium INTEGER, popcorns INTEGER, activediscount NUMERIC);
CREATE TABLE IF NOT EXISTS "premium_subscriptions"(userid INTEGER PRIMARY KEY, startdate TEXT, length TEXT);
CREATE TABLE IF NOT EXISTS "storys"(storyid INTEGER PRIMARY KEY, writerid INTEGER, title TEXT, content TEXT, price INTEGER, releasedate TEXT, genre TEXT, blurb TEXT);
CREATE TABLE IF NOT EXISTS "polls"(pollid INTEGER PRIMARY KEY, writerid INTEGER, storyid INTEGER, question TEXT, options TEXT);
CREATE TABLE IF NOT EXISTS "votes"(userid INTEGER, pollid INTEGER, votedoption TEXT, PRIMARY KEY (userid, pollid));
CREATE TABLE IF NOT EXISTS "subscriptions"(readerid INTEGER, writerid INTEGER, PRIMARY KEY (readerid,writerid));
CREATE TABLE IF NOT EXISTS "promotional_campaigns"(campaignid INTEGER PRIMARY KEY, managerid INTEGER, title TEXT, content TEXT, startdate TEXT, enddate TEXT);
