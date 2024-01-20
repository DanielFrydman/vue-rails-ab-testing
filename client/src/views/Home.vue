<template>
  <div class="text-center">
    <div v-if="abTestingVariations.length == 0" class="mt-20">
      <Loading />
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
        {{ this.abTestingVariations }}
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
import Loading from '../components/Loading.vue';

export default {
  data() {
    return {
      abTestingVariations: [],
      textVariation: null,
      loading: false,
    };
  },
  created() {
    this.fetchData();
  },
  components: {
    Loading
  },
  methods: {
    signUp() {
      this.$router.push("/signUp");
    },
    async fetchData() {
      this.loading = true;

      try {
        const data = await this.$hygraph.request(
          gql`
            query Assets() {
              abTestingVariations {
                controlVariationText
                testVariationText
              }
            }
          `,
        );

        this.abTestingVariations = data.abTestingVariations[0];
      } catch (e) {
        this.textVariation = "Meet the app that revolutionized reading.";
      } finally {
        this.loading = false;
      }
    },
  },
};
</script>

<style scoped></style>
