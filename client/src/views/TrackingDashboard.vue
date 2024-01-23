<template>
  <Navbar />

  <div v-if="!pageViewsChartData && !eventsChartData && !ctrChartData" class="flex justify-center mt-7">
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

  <div v-else class="flex items-center flex-col mt-5">
    <div class="w-1/2 mb-10">
      <Bar :data="pageViewsChartData" :options="pageViewsChartOptions" />
    </div>
    <div class="w-1/2 mb-10">
      <Bar :data="eventsChartData" :options="eventsChartOptions" />
    </div>
    <div class="w-1/2 mb-10">
      <Bar :data="ctrChartData" :options="ctrChartOptions" />
    </div>
    <div>
      <button @click="reloadPage"
        class="blinklist-background-color bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
        Reload Page
      </button>
    </div>
  </div>
</template>

<script lang="ts">
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
      pageViewsChartData: null,
      pageViewsChartOptions: null,
      eventsChartData: null,
      eventsChartOptions: null,
      ctrChartData: null,
      ctrChartOptions: null,
      selectedEventName: null,
    };
  },
  created() {
    this.retrieve_event_names();
  },
  methods: {
    reloadPage() {
      window.location.reload();
    },
    async trackingDashboard() {
      try {
        const params = {
          start_date: this.startDate,
          end_date: this.endDate,
          event_name: this.selectedEventName
        };
        const { data: { page_views_chart, events_chart, ctr_chart } } = await this.$trackingDashboard(params);
        this.pageViewsChartData = page_views_chart.data;
        this.pageViewsChartOptions = page_views_chart.chart_options;
        this.eventsChartData = events_chart.data;
        this.eventsChartOptions = events_chart.chart_options;
        this.ctrChartData = ctr_chart.data;
        this.ctrChartOptions = ctr_chart.chart_options;
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
      if (!this.startDate && !this.endDate) {
        this.errors.push('The date rage is mandatory');
      }

      event.preventDefault();
    },
    async retrieve_event_names() {
      try {
        const {
          data: { event_names },
        } = await this.$apiClient.get("/list_event_names");
        this.eventNames = event_names;
      } catch (e) {
        console.log(e);
      }
    },
  },
};
</script>
