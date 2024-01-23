import axios from 'axios';

function ApiClient() {
  const baseURL = process.env.NODE_ENV === 'development'
    ? 'http://localhost:3000/v1'
    : 'https://vue-rails-ab-testing.onrender.com/v1';

  const api = axios.create({
    baseURL: baseURL
  });

  return api;
}

export default ApiClient;