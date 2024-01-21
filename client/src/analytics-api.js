import ApiClient from "./api/axios.js";

export const trackPageview = (params) => {
  try {
    ApiClient().post("/track_pageview", params);
  } catch (error) {
    console.log(error);
  }
};
  
export const trackEvent = (params) => {
  try {
    ApiClient().post("/track_event", params);
  } catch (error) {
    console.log(error);
  }
};
