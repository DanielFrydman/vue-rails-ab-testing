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

## 🐳 Run the project
- In order to run the project you must: 
```shell
cd vue-rails-ab-testing
```
- Into the vue-rails-ab-testing folder, you'll find the docker-compose.yml. To start the Postgresql, run:
```shell
docker compose up -d
```
- Now we need to create the database and run the migrations:
```shell
rails db:create db:migrate
```
- You can start the server by running:
```shell
rails server
```
- To start the frontend, open another terminal and enter the client folder:
```shell
cd client
```
- Then install the dependencies with:
```shell
npm install
```
- Now, you can start the server by typing:
```shell
npm dev run
```
The backend will be running at **http://localhost:3000** and the frontend will be running at **http://localhost:5173**, but you only need to open the frontend link since the backend is Rails API-only.

## :books: Higher-level thoughts and Considerations
In developing this project, my aim was to explore Content Management Systems (CMS) and delve into the implementation of AB Testing with Hygraph. I meticulously tracked every page view and click on the signup button. The goal was to offer an easy way for anyone testing my system to comprehend the total and unique page views and clicks the website received. The tracking dashboard also displayed a Click-Through Rate (CTR) calculated with both total and unique data.

To calculate the CTR, I used two models. One for counting page views and another for counting events. To create charts for both total and unique data, I implemented a method in each model. This method returned the fetched data in a hash format, containing both total and unique data and this approach prevented unnecessary queries. The responsibility of calculating the CTR fell on presenters, which I used to generate data for the charts on the front end.

I thoroughly enjoy learning about Hygraph's CDN caching capabilities. Understanding how it strategically distributes and caches static assets across global servers has been not only enlightening but also invaluable in optimizing content delivery. This knowledge not only enhances the efficiency of the platform but also contributes significantly to my overall understanding of web development best practices.

## :microscope: Assumptions
Since the challenge did not explicitly require displaying all this information, I decided to go beyond the basics. I implemented a tracking dashboard, enhancing my understanding of chartjs and presenting a better way to gather backend data using the presenter pattern, an approach I hadn't used or created before. I assumed that this dashboard would prove useful when comparing the CTRs of the control and test texts and it offers an efficient way to verify that tracking all data works.

## :door: Limitations
This project allows only two texts to be changed in Hygraph for AB testing. If a third option (ABC) is desired, a refactor is necessary. Additionally, adding more AB tests on other pages might be better addressed by creating another schema in the project or a similar approach, along with updating/creating the GraphQL queries to fetch the data.

The main limitation lies in the lack of dynamism and ease when attempting to conduct more AB tests. The need to modify code and add components to the Hygraph project makes the process neither dynamic nor straightforward. Unfortunately, I didn't explore a solution for this challenge due to my lack of experience with this type of project.