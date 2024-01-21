import ApiClient from "./api/axios.js";

export const trackPageview = async (params) => {
  try {
    await ApiClient().post("/track_pageview", params);
  } catch (error) {
    console.log(error);
  }
};

export const trackEvent = async (params) => {
  try {
    await ApiClient().post("/track_event", params);
  } catch (error) {
    console.log(error);
  }
};
