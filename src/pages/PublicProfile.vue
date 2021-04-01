<template>
<q-layout view="lHh Lpr lFf">
    <q-page-container :class="(!this.$q.dark.isActive?' bg-grey-1':'')">
<q-page class="">
  <q-btn class="absolute-top-right" flat round @click="$q.dark.toggle();$q.localStorage.set('dark-mode',$q.dark.isActive)"
               :icon="$q.dark.isActive ? 'nights_stay' : 'wb_sunny'"/>
    <div :class="'q-pa-md col'">
       <div :class="' flex flex-center col'" v-if="($route.params.tab && $route.params.tab !== 'edit') ||($route.query.acct)">
        <MSProfile v-if="type==='STYLIST'" />
        <SProfile  v-if="type==='SALON'" />
    </div>
    </div>
</q-page>
    </q-page-container>
</q-layout>
</template>
<script>
import MSProfile from '../components/MSProfile'
import SProfile from '../components/SProfile'
import { Dark } from 'quasar'
import axios from 'axios'
import imgBlack from '../layouts/logo-black.png'
import imgWhite from '../layouts/logo-white.png'

export default {
  data () {
    return {
      type: ''
    }
  },
  computed: {
    logo () {
      return this.$q.dark.isActive ? imgWhite : imgBlack
    }
  },
  components: {
    MSProfile,
    SProfile
  },
  async mounted () {
    this.$q.dark.set(!!this.$q.localStorage.getItem('dark-mode'))
    if (this.$route.query.acct) {
      const acct = this.$route.query.acct
      const res = await axios({
        url: 'https://www.efuzy.com/salon/publicprofile',
        method: 'post',
        data: {
          acct,
          typeOnly: true
        }
      })
      this.type = res && res.data && res.data.data && res.data.data.type
    }
  },
  methods: {
    toggleDark () {
      Dark.toggle()
      this.$q.localStorage.set('dark-mode', Dark.isActive)
    }
  }
}
</script>
