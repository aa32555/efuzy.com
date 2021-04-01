<template>
   <q-card class="flex flex-center" style="">
  <q-pull-to-refresh
        @refresh="reload"
        >
            <q-infinite-scroll @load="loadMore" :key="isKey">
            <q-timeline color="primary" layout="dense" :style="'width:80vw;min-width:380px;padding:10px;max-width:1200px;'">

               <q-breadcrumbs :style="'width:80vw;min-width:380px;padding:10px;max-width:1200px;'">
        <q-breadcrumbs-el
          label="Home"
          to="/"
        />
        <q-breadcrumbs-el
          label="Activity"
          to="/activity"
        />
      </q-breadcrumbs>
    <q-timeline-entry
          :titlex="item.name"
        :subtitle="item.rcvd"
        :avatar="getAvatar(item.stars)"
        v-for="(item,index) of statsList" :key="index"
      >
        <div>
        <q-chip style="width:170px;" color="positive" text-color="white">
                        <q-avatar>
                        <img src="..\assets\user.png">
                        </q-avatar>
                     <router-link class="text-white" :to="'/client/'+item.id">   {{item.name}}</router-link>
                    </q-chip><br>
            <span v-if="Number(item.stars)>0">
            <q-icon :style=" Number(star) <= Number(item.stars)?'color:#ffd055':'color:#d8d8d8'" name="star" :size="'sm'" v-for="star in 5" :key="star" />
            </span>
             <q-chip color="primary" text-color="white" style="width:164px;">
                        <q-avatar>
                        <img src="..\assets\stylist.png">
                        </q-avatar>
                        {{item.staff}}
                    </q-chip>
                    <br>
                         <q-chip color="primary" text-color="white">
                        <q-avatar>
                        <img src="..\assets\reciept.jpg">
                        </q-avatar>
                        {{item.paid + '  ' + item.method}}
                    </q-chip>
                    <br>
                   <q-chip color="primary" text-color="white" icon="book">
                        {{item.time}}
                    </q-chip>
            <p style="max-width:600px;padding:0px;margin:0 0 0px">
            <q-chip color="primary" text-color="white">
                        <q-avatar>
                        <img src="..\assets\message.png">
                        </q-avatar>
                    </q-chip>
            <span style="text-bold bg-primary"> {{item.reply}} </span>
            </p>
            <div style="font-size:12px;color:grey" :lines="1" v-for="(sitem,sindex) in item.item" :key="'sindex_'+sindex">{{sitem}}</div>
        </div>
      </q-timeline-entry>
            </q-timeline>
            <template v-slot:loading v-if="!done">
                <div class="row justify-center q-my-md">
                <q-spinner-dots color="primary" size="40px" />
                </div>
            </template>
                  </q-infinite-scroll>
  </q-pull-to-refresh>
            </q-card>
</template>
<script>

import { uid } from 'quasar'

import stars5Pic from '../assets/happy.png'
import stars4Pic from '../assets/happy4.png'
import stars3Pic from '../assets/star3.jpg'
import stars2Pic from '../assets/star2.png'
import stars1Pic from '../assets/star1.png'
import messagePic from '../assets/message.png'

export default {
  data () {
    return {
      latestDate: '',
      statsList: [],
      prompt: false,
      date: this.getToday(),
      doNotSend: {},
      last: 'ZZ,ZZ',
      done: false,
      isKey: uid()
    }
  },
  components: {
  },
  async mounted () {
    // await this.loadMore(0, function () {})
  },
  methods: {
    async reload (rdone) {
      this.latestDate = ''
      this.statsList = []
      this.prompt = false
      this.date = this.getToday()
      this.doNotSend = {}
      this.last = 'ZZ,ZZ'
      this.done = false
      this.isKey = uid()
      this.$nextTick(() => {
        rdone()
      })
    },
    async loadMore (i, done) {
      if (this.done === true) {
        done()
        return
      }
      const last = this.last
      const date = this.date
      const data = await this.$M('getStatsLog^ACTIVITY', {
        date,
        last
      })
      if (data && data.data && data.data.last === this.last) {
        this.done = true
        return
      }
      this.last = data.data.last
      const list = data.data.list
      if (list) this.statsList = this.statsList.concat(list)
      //  setTimeout(() => {
      if (typeof done === 'function') {
        done()
      }
      // }, 100)
    },
    async filterDate (done) {
      await this.getStats()
      if (typeof done === 'function') {
        done()
      }
    },
    getToday () {
      var today = new Date()
      var dd = String(today.getDate()).padStart(2, '0')
      var mm = String(today.getMonth() + 1).padStart(2, '0') // January is 0!
      var yyyy = today.getFullYear()

      today = yyyy + '/' + mm + '/' + dd
      return today
    },
    getAvatar (stars) {
      stars = Number(stars)
      if (stars >= 5) {
        return stars5Pic
      } else if (stars === 4) {
        return stars4Pic
      } else if (stars === 3) {
        return stars3Pic
      } else if (stars === 2) {
        return stars2Pic
      } else if (stars === 1) {
        return stars1Pic
      } else {
        return messagePic
      }
    }
  }
}
</script>
