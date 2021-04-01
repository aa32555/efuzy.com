<template>
 <FUZPage v-bind="{baseStyle:'padding-right:0px;margin:0px;'}">
 <q-page  style="max-width:100vw;height:100vh;overflow:scroll;">
<div class="flex flex-center">
    <div :class="'q-pa-md'" bordered :style="'width:100vw;min-width:420px;'">
      <q-card>
    <div class="full-width">
      <div class="layout-view layout-padding">
        <center>
          <br />
          <q-btn-dropdown rounded outline :label="duration" size="lg">
            <q-list v-for="(duration,index) in durations" :key="index">
              <q-item clickable v-close-popup @click="handleDateChange(duration)">
                <q-item-section>
                  <q-item-label>{{duration.label}}</q-item-label>
                </q-item-section>
              </q-item>
            </q-list>
          </q-btn-dropdown>
        </center>
        <div class="input-card">
          <div
            :style="this.$q.platform.is.mobile?'margin:auto;max-width:300px;':'margin:auto;max-width: 776px;'"
          >
            <star-rating
              :rating="TotalStars"
              :read-only="true"
              :increment="0.01"
              :star-size="this.$q.platform.is.mobile? 50: 150"
            ></star-rating>
          </div>
          <br />
          <br />
          <br />
          <h5>Overall Rating</h5>
          <area-chart :data="StarsLineChart"></area-chart>
          <h5>Rating Breakdown</h5>
          <line-chart :data="StarsLineChartByStaff" :legend="true"></line-chart>
          <h5>Booking Source - {{totalClients}} Clients</h5>
          <div class="fit row wrap justify-center items-start content-start">
            <FUZDiv :colLG="6">
              <pie-chart :data="Channel"></pie-chart>
            </FUZDiv>
             <FUZDiv :colLG="6">
              <pie-chart :data="clientTypes"></pie-chart>
            </FUZDiv>
          </div>
          <div class="fit row wrap justify-center items-start content-start">
            <div class="col-12 self-center q-gutter-md">
              <column-chart :data="staffSources"></column-chart>
            </div>
          </div>
          <h5>Sales</h5>
          <h6>By Staff</h6>
          <div class="fit row wrap justify-center items-start content-start">
            <div class="col-12 self-center q-gutter-md">
              <column-chart prefix="$" :data="staffSales"></column-chart>
            </div>
          </div>
          <h6>Daily</h6>
          <div class="fit row wrap justify-center items-start content-start">
            <div class="col-12 self-center q-gutter-md">
              <area-chart prefix="$" :data="dailySales" ></area-chart>
            </div>
          </div>
          <h6>Monthly</h6>
          <div class="fit row wrap justify-center items-start content-start">
            <div class="col-12 self-center q-gutter-md">
              <area-chart prefix="$" :data="monthlySales"></area-chart>
            </div>
          </div>
        </div>
      </div>
    </div>
    </q-card>
  </div>
</div>
</q-page>
</FUZPage>
</template>
<script>
import Vue from 'vue'
import Chartkick from 'vue-chartkick'
import Chart from 'chart.js'
import StarRating from 'vue-star-rating'
import FUZDiv from '../../FUZ/FUZDiv'
import FUZPage from '../../FUZ/FUZPage/FUZPage'
Vue.use(Chartkick.use(Chart))

export default {
  components: {
    StarRating,
    FUZDiv,
    FUZPage
  },
  data () {
    return {
      totalExistingClients: '0',
      totalNewClients: '0',
      StarsLineChart: {},
      StarsLineChartByStaff: {},
      staffSources: {},
      staffSales: {},
      monthlySales: {},
      TotalStars: 0,
      totalClients: 0,
      Channel: {},
      dailySales: {},
      duration: 'Last 30 Days',
      durations: [
        { duration: '30', label: 'Last 30 Days' },
        { duration: '90', label: 'Last 90 Days' },
        { duration: '180', label: 'Last 6 Months' },
        { duration: '365', label: 'Last Year' },
        { duration: '*', label: 'All Time' }
      ]
    }
  },
  async mounted () {
    await this.getStarsLineChart()
    await this.getStarsLineChartByStaff()
    await this.getChannelPie()
  },
  computed: {
    clientTypes () {
      return {
        'New Clients': this.totalNewClients,
        'Existing Clients': this.totalExistingClients
      }
    }
  },
  methods: {
    async handleDateChange (duration) {
      this.duration = duration.label
      const dur = duration.duration
      await this.getStarsLineChart(dur)
      await this.getStarsLineChartByStaff(dur)
      await this.getChannelPie(dur)
    },
    async getStarsLineChart (duration) {
      const data = await this.$M('getStarsLineChart^DASHBOARD', { duration })
      if (data && data.data && data.data.Stars) {
        this.$set(this.$data, 'StarsLineChart', data.data.Stars)
      }
      if (data && data.data && data.data.TotalStars) {
        this.TotalStars = data.data.TotalStars
      }
    },
    async getStarsLineChartByStaff (duration) {
      const data = await this.$M('getStarsLineChartByStaff^DASHBOARD', { duration })
      if (data && data.data && data.data.Stars) {
        this.$set(this.$data, 'StarsLineChartByStaff', data.data.Stars)
      }
    },
    async getChannelPie (duration) {
      const data = await this.$M('getSourcesPie^DASHBOARD', { duration })
      if (data && data.data && data.data.channel) {
        this.$set(this.$data, 'Channel', data.data.channel)
      }
      if (data && data.data && data.data.totalClients) {
        this.totalClients = data.data.totalClients
      }
      if (data && data.data && data.data.totalExistingClients) {
        this.totalExistingClients = data.data.totalExistingClients
      }
      if (data && data.data && data.data.totalNewClients) {
        this.totalNewClients = data.data.totalNewClients
      }
      if (data && data.data && data.data.staffSources) {
        this.$set(this.$data, 'staffSources', data.data.staffSources)
      }
      if (data && data.data && data.data.staffSales) {
        this.$set(this.$data, 'staffSales', data.data.staffSales)
      }
      if (data && data.data && data.data.dailySales) {
        this.$set(this.$data, 'dailySales', data.data.dailySales)
      }
      if (data && data.data && data.data.monthlySales) {
        this.$set(this.$data, 'monthlySales', data.data.monthlySales)
      }
    }
  }
}
</script>
<style lang="stylus" scoped>
.input-card {
  border-radius: 5px;
  margin-top: -10px;
  margin: 20px;

  .layout-padding {
    margin: 0 32px;
  }
}

.submit {
  >.q-btn {
    margin: 5px;
  }
}
</style>
