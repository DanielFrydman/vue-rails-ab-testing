import HygraphClient from "./plugins/hygraph.js";
import ApiClient from "./api/axios.js";
import Router from "./router/index.js";
import App from "./App.vue";

import { trackPageview, trackEvent } from "./analytics-api.js";
import { createApp } from "vue";

import "./style.css";

const app = createApp(App)
app.mixin({
  beforeCreate() {
    this.$cmsClient = HygraphClient;
    this.$apiClient = ApiClient;
  },
});
app.use(Router)
app.mount('#app')
