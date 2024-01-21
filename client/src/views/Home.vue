<template>
  <div class="text-center">
    <div v-if="!textVariation || error" class="mt-20">
      <Loading />
      {{ this.error }}
    </div>
    <div v-else>
      <p class="font-bold text-4xl my-6">Check out the Blinkist app</p>
      
      <img
        width="300"
        src="../assets/hero_image.jpg"
        alt="Check out the Blinkist app"
        class="mx-auto"
      />
  
      <div>
        {{ this.textVariation }}
      </div>
  
      <div>
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
</template>

<script>
import { gql } from "graphql-request";
import Loading from "../components/Loading.vue";

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
    Loading
  },
  methods: {
    signUp() {
      this.trackEvent();
      this.$router.push("/signUp");
    },
    chooseRandomTextVariant() {
      if (Math.random() < 0.5) { return "controlVariationText"; };

      return "testVariationText";
    },
    fetchDataFromLocalStorage() {
      const storedData = localStorage.getItem("textVariation");
      if (storedData) { return this.setTextVariation(storedData); };
    },
    async fetchDataFromCMS() {
      if (this.textVariation) { return; };

      try {
        const query = gql`
          query Assets() {
            abTestingVariations {
              controlVariationText
              testVariationText
            }
          }
        `
        const data = await this.$cmsClient.request(query);
        this.setTextVariation(data.abTestingVariations[0]);
      } catch (e) {
        this.error = `Error trying to fetch data: ${e}. Please, try again later.`;
      }
    },
    setTextVariation(textVariation) {
      if (typeof(textVariation) === "object") {
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
      if (userIdFromLocalStorage) { return userIdFromLocalStorage; };

      let userId = Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15);
      localStorage.setItem("userId", userId);
      return userId;
    },
    trackPageView() {
      const params = {
        user_id: this.getUserId(),
        page: "home",
        displayed_text_variation: this.textVariation
      }

      this.$trackPageView(params);
    },
    trackEvent() {
      const params = {
        user_id: this.getUserId(),
        page: "home",
        action: "sign_up",
        displayed_text_variation: this.textVariation
      }

      this.$trackEvent(params);
    }
  },
};
</script>

<style scoped></style>
