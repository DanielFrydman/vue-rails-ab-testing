import HygraphClient from "./plugins/hygraph.js";
import ApiClient from "./api/axios.js";
import Router from "./router/index.js";
import App from "./App.vue";

import { trackPageView, trackEvent, trackingDashboard } from "./services/analytics-api.js";
import { createApp } from "vue";

import "./style.css";

const app = createApp(App)
app.mixin({
  beforeCreate() {
    this.$cmsClient = HygraphClient;
    this.$apiClient = ApiClient();
    this.$trackPageView = trackPageView;
    this.$trackEvent = trackEvent;
    this.$trackingDashboard = trackingDashboard;
  },
});
app.use(Router)
app.mount('#app')
