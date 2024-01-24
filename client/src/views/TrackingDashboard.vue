<template>
  <Navbar />

  <div v-if="!chartsLoaded" class="flex justify-center mt-7">
    <div class="blinklist-background-color p-7 shadow-md rounded-md">
      <div class="bg-white rounded shadow-lg">
        <form @submit.prevent="checkForm">
          <div class="flex justify-center" style="color: red">
            <p v-if="errors.length">
              <b>Correct the errors below:</b>
            <ul>
              <li v-for="error in errors">{{ error }}</li>
            </ul>
            </p>
          </div>
          <div class="px-6 py-4">
            <div class="font-bold text-xl mb-2 blinklist-text-color">Choose the event name</div>
            <select class="blinklist-border-color	rounded-md shadow-md w-full mb-3" v-model="selectedEventName">
              <option disabled value="">Please select one</option>
              <option v-for="eventName in eventNames" :key="eventName">
                {{ eventName }}
              </option>
            </select>
            <div class="font-bold text-xl mb-2 blinklist-text-color">Choose the date range</div>
            <div class="flex items-center">
              <input name="start" type="date"
                class="blinklist-border-color bg-gray-50 border text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full ps-10 p-2.5  dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                v-model="startDate" placeholder="Select date start">
              <span class="mx-4 text-gray-500">to</span>

              <input name="end" type="date"
                class="blinklist-border-color	bg-gray-50 border text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full ps-10 p-2.5  dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                v-model="endDate" placeholder="Select date end">
            </div>
          </div>
          <div class="py-4 flex justify-center" style="margin-top: -15px;;">
            <button type="submit"
              class="blinklist-background-color bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
              Submit
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>

  <div v-else>
    <div class="py-4 flex justify-evenly">
      <div class="w-1/3">
        <div class="mb-10">
          <Bar :data="uniquePageViewsChart.data" :options="uniquePageViewsChart.chart_options" />
        </div>
        <div class="mb-10">
          <Bar :data="uniqueEventsChart.data" :options="uniqueEventsChart.chart_options" />
        </div>
        <div class="">
          <Bar :data="uniqueCtrChart.data" :options="uniqueCtrChart.chart_options" />
        </div>
      </div>

      <div class="w-1/3">
        <div class="mb-10">
          <Bar :data="totalPageViewsChart.data" :options="totalPageViewsChart.chart_options" />
        </div>
        <div class="mb-10">
          <Bar :data="totalEventsChart.data" :options="totalEventsChart.chart_options" />
        </div>
        <div class="mb-10">
          <Bar :data="totalCtrChart.data" :options="totalCtrChart.chart_options" />
        </div>
      </div>
    </div>

    <div class="py-4 flex justify-center">
      <button @click="reloadPage"
        class="blinklist-background-color bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
        Reload Page
      </button>
    </div>
  </div>
</template>

<script scoped>
import {
  Chart as ChartJS,
  Title,
  SubTitle,
  Tooltip,
  Legend,
  BarElement,
  CategoryScale,
  LinearScale
} from 'chart.js'
import { Bar } from "vue-chartjs";
import { Navbar } from "../components/index";

ChartJS.register(CategoryScale, LinearScale, BarElement, Title, Tooltip, SubTitle, Legend)

export default {
  components: { Bar, Navbar },
  data() {
    return {
      eventNames: [],
      startDate: null,
      endDate: null,
      errors: [],
      uniqueEventsChart: { data: null, chart_options: null },
      uniquePageViewsChart: { data: null, chart_options: null },
      uniqueCtrChart: { data: null, chart_options: null },
      totalEventsChart: { data: null, chart_options: null },
      totalPageViewsChart: { data: null, chart_options: null },
      totalCtrChart: { data: null, chart_options: null },
      selectedEventName: null,
      chartsLoaded: false
    };
  },
  mounted() {
    this.retrieve_event_names();
  },
  methods: {
    reloadPage() {
      this.$router.go("/trackingDashboard");
    },
    async trackingDashboard() {
      try {
        const params = {
          start_date: this.startDate,
          end_date: this.endDate,
          event_name: this.selectedEventName
        };
        const {
          unique_events_chart,
          unique_page_views_chart,
          unique_ctr_chart,
          total_events_chart,
          total_page_views_chart,
          total_ctr_chart
        } = await this.$trackingDashboard(params);
        this.uniqueEventsChart = unique_events_chart;
        this.uniquePageViewsChart = unique_page_views_chart;
        this.uniqueCtrChart = unique_ctr_chart;
        this.totalEventsChart = total_events_chart;
        this.totalPageViewsChart = total_page_views_chart;
        this.totalCtrChart = total_ctr_chart;
        this.chartsLoaded = true;
      } catch (e) {
        console.log(e)
      }
    },
    checkForm(event) {
      if (this.selectedEventName && this.startDate && this.endDate) {
        return this.trackingDashboard();
      }

      this.errors = [];
      if (!this.selectedEventName) {
        this.errors.push('The event name is mandatory');
      }
      if (!this.startDate || !this.endDate) {
        this.errors.push('The date rage is mandatory');
      }

      event.preventDefault();
    },
    async retrieve_event_names() {
      try {
        const { data: { event_names } } = await this.$apiClient.get("/list_event_names");
        this.eventNames = event_names;
      } catch (e) {
        console.log(e);
      }
    },
  },
};
</script>

<style scoped></style>