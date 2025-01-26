Project Overview
Steel City Stories is a web platform designed for sharing and writing stories centered around Sheffield's culture. The project features a rich set of functionalities, including user management, story publishing, and database-driven interactions, with a focus on community engagement.

Key Features
User Management:

User roles: Supports regular users, premium members, and admin accounts.
Account functionalities: Login, registration, and profile management.
Premium subscriptions: Includes features like subscription tracking and additional perks for premium users.
Story Management:

Users can write, share, and publish stories with customizable attributes (e.g., price, genre, and release date).
Stories include metadata such as titles, blurbs, and genres.
Community Engagement:

Users can interact with stories using features like ratings, reviews, or social sharing (as inferred from context).
Database-Driven Architecture:

Designed using SQLite3 for robust data storage and management.
Schema includes tables for users, premium subscriptions, stories, and interactions (e.g., ratings and purchases).
Frontend-Backend Integration:

Built using Sinatra, a lightweight Ruby framework for web applications.
Backend integrates seamlessly with database models and controllers.
Technical Implementation
Backend:

Written in Ruby, using the Sinatra framework for HTTP request handling.
Leveraged Sequel ORM for database interactions and schema migrations.
Implements session management for secure user authentication and state tracking.
Database Schema:

Users: Stores user details, subscription status, and account types.
Stories: Tracks story details like writer, title, content, and associated metadata.
Premium Subscriptions: Handles subscription data for premium members.
Purchases: Manages user interactions with paid stories.
Frontend:

Views are likely implemented using embedded Ruby templates (ERB), rendering dynamic content for users.
Testing:

Includes RSpec and Capybara tests for robust end-to-end testing of user journeys and functionality.
