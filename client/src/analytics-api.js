import ApiClient from "./api/axios.js";

export const trackPageView = (params) => {
  try {
    ApiClient().post("/track_page_view", params);
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
