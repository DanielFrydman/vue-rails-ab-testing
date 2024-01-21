<template>
  <Navbar />
  <div class="text-center">
    <div v-if="!textVariation || error" class="mt-20">
      <Loading />
      {{ this.error }}
    </div>

    <div v-else class="bg-white">
      <div
        class="mx-auto grid gap-x-8 gap-y-16 px-4 py-24 sm:px-6 sm:py-32 lg:max-w-7xl lg:grid-cols-2 lg:px-8"
      >
        <div class="flex items-center">
          <div>
            <p class="font-bold text-4xl my-6 blinklist-text-color">
              Check out the Blinkist app
            </p>

            <div class="blinklist-text-color">
              {{ this.textVariation }}
            </div>
            <div class="blinklist-text-color">
              Thanks a lot for reading the article!
              <button
                @click="signUp()"
                class="font-medium text-blue-600 dark:text-blue-500 hover:underline"
              >
                SIGN UP
              </button>
              for Blinkist.
            </div>
          </div>
        </div>
        <div>
          <img
            width="900"
            src="../assets/hero_image.jpg"
            alt="Check out the Blinkist app"
            class="mx-auto"
          />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { gql } from "graphql-request";
import Loading from "../components/Loading.vue";
import Navbar from "../components/Navbar.vue";

export default {
  data() {
    return {
      textVariation: null,
      error: null,
    };
  },
  created() {
    this.fetchDataFromLocalStorage();
    this.fetchDataFromCMS();
    this.trackPageView();
  },
  components: {
    Loading,
    Navbar,
  },
  methods: {
    signUp() {
      this.trackEvent();
      this.$router.push("/signUp");
    },
    chooseRandomTextVariant() {
      if (Math.random() < 0.5) {
        return "controlVariationText";
      }

      return "testVariationText";
    },
    fetchDataFromLocalStorage() {
      const storedData = localStorage.getItem("textVariation");
      if (storedData) {
        return this.setTextVariation(storedData);
      }
    },
    async fetchDataFromCMS() {
      if (this.textVariation) {
        return;
      }

      try {
        const query = gql`
          query Assets() {
            abTestingVariations {
              controlVariationText
              testVariationText
            }
          }
        `;
        const data = await this.$cmsClient.request(query);
        this.setTextVariation(data.abTestingVariations[0]);
      } catch (e) {
        this.error = `Error trying to fetch data: ${e}. Please, try again later.`;
      }
    },
    setTextVariation(textVariation) {
      if (typeof textVariation === "object") {
        const randomTextVariant = this.chooseRandomTextVariant();
        this.textVariation = textVariation[randomTextVariant];
        this.setLocalStorage();
        return;
      }

      this.textVariation = textVariation;
      this.setLocalStorage();
    },
    setLocalStorage() {
      localStorage.setItem("textVariation", this.textVariation);
    },
    getUserId() {
      let userIdFromLocalStorage = localStorage.getItem("userId");
      if (userIdFromLocalStorage) {
        return userIdFromLocalStorage;
      }

      let userId =
        Math.random().toString(36).substring(2, 15) +
        Math.random().toString(36).substring(2, 15);
      localStorage.setItem("userId", userId);
      return userId;
    },
    trackPageView() {
      const params = {
        user_id: this.getUserId(),
        url: window.location.href,
        displayed_text_variation: this.textVariation,
      };

      this.$trackPageView(params);
    },
    trackEvent() {
      const params = {
        user_id: this.getUserId(),
        event_name: "sign_up",
        url: window.location.href,
        displayed_text_variation: this.textVariation,
      };

      this.$trackEvent(params);
    },
  },
};
</script>

<style scoped></style>
