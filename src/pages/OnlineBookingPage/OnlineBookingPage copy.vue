<template>
  <OnlineBookingLayout :key="key" v-bind="page" v-if="page && status" @nextStep="handleNextStep" />
</template>
<script>
import OnlineBookingLayout from './OnlineBookingLayout'
// import merge from 'lodash'
import { uid } from 'quasar'
import axios from 'axios'
export default {
  name: 'OnlineBookingPage',
  components: {
    OnlineBookingLayout
  },
  async created () {
    const res = await axios({
      url: 'https://www.hairsalonsystems.com/apps/account-details',
      method: 'post',
      data: {
        site: this.$route.params.sitename
      }
    })
    const status = res && res.data && res.data.status
    const url = res && res.data && res.data.data && res.data.data.url
    const page = res && res.data && res.data.data && res.data.data.page
    this.status = status
    this.$set(this.$data, 'page', page)
    this.url = url
  },
  methods: {
    async handleNextStep (event) {
      this.step = event.step
      const data = Object.assign(event.data, this.data)
      this.$set(this.$data, 'data', data)
      const res = await axios({
        url: this.url,
        method: 'post',
        data: {
          site: this.$route.params.sitename,
          step: event.step,
          data: this.data
        }
      })
      const page = res && res.data && res.data.data && res.data.data.page
      this.$set(this.$data, 'page', page)
      this.$nextTick(() => {
        this.key = uid()
      })
    }
  },
  data () {
    return {
      key: uid(),
      status: false,
      page: null,
      url: '',
      step: '',
      data: {
      }
    }
  }
}
</script>
