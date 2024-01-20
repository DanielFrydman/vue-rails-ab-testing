import { createApp } from 'vue'
import './style.css'
import App from './App.vue'
import { trackPageview, trackEvent } from "./analytics-api.js";

createApp(App).mount('#app')
