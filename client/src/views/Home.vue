<template>
  <div class="text-center">
    <p class="font-bold text-4xl my-6">Check out the Blinkist app</p>
  
    <img
      width="300"
      src="../assets/hero_image.jpg"
      alt="Check out the Blinkist app"
      class="mx-auto"
    />
  
    <div>
      <!-- Control variation -->
      Meet the app that revolutionized reading.
    </div>
  
    <div>
      <!-- Test variation -->
      Meet the app that has 18 million users.
    </div>
  
    <div>
      Thanks a lot for reading the article! <button @click=signUp()>SIGN UP</button> for
      Blinkist.
    </div>
  </div>
</template>

<script>
import { gql } from 'graphql-request';

export default {
  data() {
    return {
      abTestingVariations: [],
      textVariation: null,
      loading: false
    };
  },
  created() {
    this.fetchData();
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
          `
        );

        this.loading = false;
        console.log(data.abTestingVariations[0])
      } catch (e) {
        this.textVariation = "Meet the app that revolutionized reading.";
      }
    },
  },
};
</script>

<style scoped>
</style>
