import { createRouter, createWebHistory } from 'vue-router'
import { Home, SignUp, TrackingDashboard } from '../views/index'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/signUp',
    name: 'Sign Up',
    component: SignUp
  },
  {
    path: '/trackingDashboard',
    name: 'Tracking Dashboard',
    component: TrackingDashboard
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router;
