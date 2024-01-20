import { createRouter, createWebHistory } from 'vue-router'
import { Home, SignUp } from '../views/index'

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
];

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router;
