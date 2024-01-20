import { createApp } from 'vue'
import './style.css'
import App from './App.vue'
import router from './router/index.js'
import { trackPageview, trackEvent } from "./analytics-api.js";
import { GraphQLClient } from 'graphql-request';

const hygraphClient = new GraphQLClient(
  'https://api-sa-east-1.hygraph.com/v2/clrm4asx40h9y01w3qaztpy5a/master'
);

const app = createApp(App)
app.mixin({
  beforeCreate() {
    this.$hygraph = hygraphClient;
  },
});
app.use(router)
app.mount('#app')
