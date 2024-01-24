## :rocket: Project
The developed application is a standalone AB Testing made in Ruby on Rails and VueJS.
<br>
Its goal is to assist the non-technical users to modify AB Testing and monitor the tracked data to check Clickthrough Rate(CTR).

## :tada: Features
- Visitor sees only one variation (assigned randomly) when they land on the page.
- The assigned variation doesn’t change after the page reloads.
- Track a pageview via the `analytics-api.js` method when a visitor lands on the page.
- Track an event via the `analytics-api.js` method when a visitor clicks on the “Sign up” button.
- Every single page view and click shall be tracked.
- Calculate CTR by unique users and event name.
- Tracking Dashboard to see unique page views and events per user by event name and in chosen period.
- Allow non-technical users to modify the control variation or the test variation texts in Hygraph CMS (Content management system).
- P.S.: The sign up page is for viewing only, it doesn't work like a real page

## :technologist: Used Technologies
- `Ruby`: Version 3.3.0
- `Rails`: Version 7.1.3
- `PostgreSQL`: Latest
- `Node`: Version 21.6.0
- `Vue`: Version 3.3.11
- `Vite`: Version 5.0.8
- `Tailwindcss`: Version 3.4.1
- `Docker`: Version  24.0.7
- `Docker Compose`: Version 1.29.2
- `Npm`: Version 10.3.0
- `Git`: Version 2.39.3
- `Hygraph`: Version -

## :wrench: Gems added
- `rspec-rails`: Added for testing the backend
- `factory_bot_rails`: Added to create factories for testing
- `faker`: Added to create fake data for testing
- `byebug`: Added to debug the project
- `rack-cors`: Added to allow external requests to the API
- `rubocop`: Added to lint the project (to ensure the same code style)
- `simplecov`: Added to check test coverage report

## :hammer: Libs added
- `eslint`: Added to lint the project (to ensure the same code style)
- `prettier`: Added to ensure code consistency and readability through automatic formatting.
- `graphql`: Added to enable efficient API queries and flexible data retrieval.
- `graphql-request`: Added to have a lightweight client for simplified GraphQL server requests.
- `vue-axios`: Added to have streamlines HTTP requests in Vue.js applications
- `vue-chartjs`: Added to facilitate integration of interactive charts in Vue.js projects.
- `vue-router`: Added to have the official Vue.js routing library for seamless navigation.
- `flowbite`: Added to have an utility-first CSS framework for rapid Vue.js interface development(in this case, I just used a datepicker).

## :roller_coaster: Results
![Screen-Recording-2024-01-23-at-21 15 30](https://github.com/DanielFrydman/vue-rails-ab-testing/assets/43658712/a1fb5f01-0874-468f-ba9a-15e331665d42)

## :pushpin: Information
You can test the application in the following URL: **https://vue-rails-ab-testing-3mmd.onrender.com**.
<br>
The page may take a while to load as it is a free service and the system sleeps but once it loads, it is quick.
<br>
The PostgreSQL DB in Render will be erased after 90 days.
<br>
***Please be aware that the link may be inactive, depending on when you access my repository, as the Render database associated with the free version could potentially have expired. Thank you for your understanding.***

## :postbox: Hygraph Project
If you want to change the `Control variation text` or the `Test variation text`, just send me a message with your email and I will add you to my Hygraph project. With the free version, I can only add two people.
![image](https://github.com/DanielFrydman/vue-rails-ab-testing/assets/43658712/3169d131-e7a9-41b9-a6bb-155a7471edd1)
<br>
It only has one model in the schema called AB Testing Variation with two single-line text fields: the first is `Control variation text` and the second is `Test variation text`.
![image](https://github.com/DanielFrydman/vue-rails-ab-testing/assets/43658712/653c6c26-a734-4574-9475-883658d16954)
<br>
The current content is the one below:
![image](https://github.com/DanielFrydman/vue-rails-ab-testing/assets/43658712/f2628fc8-4f6f-4062-ab81-ff492c82b499)


## 📁 Access to the project
```shell
git@github.com:DanielFrydman/vue-rails-ab-testing.git
```

## 🐳 Run the project with Docker
to do
