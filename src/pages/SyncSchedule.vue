<template>
<q-page class="">
   <q-card>
    <div class="flex flex-center">
    <div style="padding:15px">
      <q-card
        class="my-card"
        :style="'width:380px;'"
      >
        <FUZIcon key="syncing" path="Syncing" v-if="syncing"
         :loop="true"
         :width="300"
         :height="300"
         />
        <q-card-actions>
          <q-btn
            class="full-width"
            :size="'xl'"
            :loading="syncing"
            @click="startSyncing"
          >Sync
            <template v-slot:loading>
              {{'Syncing using ' + '   PID:'+syncPID}}
            </template>
          </q-btn>
        </q-card-actions>
      </q-card>
    </div>
    <div class="flex flex-center">
      <h4>{{latestDate}}</h4>
    </div>
  </div>
  </q-card>
  </q-page>
</template>
<script>
import FUZIcon from '../components/FUZIcon'

export default {
  data () {
    return {
      latestDate: '',
      statsList: [],
      syncing: false,
      syncPID: null,
      killChecker: false

    }
  },
  components: {
    FUZIcon
  },
  async mounted () {
    await this.onMounted()
  },
  computed: {
  },
  beforeRouteLeave (to, from, next) {
    this.killChecker = true
    next()
  },
  methods: {
    uploaded () {
      // alert('uploaded')
    },
    async startSyncing () {
      const checkStatus = await this.$M('getSyncStatus^SYNC')
      console.log()
      if (checkStatus && checkStatus.status === true) {
        this.$q.notify('Syncing Is already running with PID' + checkStatus.pid)
        await this.onMounted()
      } else {
        const startSync = await this.$M('startSync^SYNC')
        if (startSync && startSync.status === true) {
          this.$q.notify('Syncing Started with PID' + startSync.pid)
          await this.onMounted()
        } else {
          this.$q.notify('Syncing Could not be started!')
        }
      }
    },
    async onMountedxx () {},
    async onMounted () {
      const syncStatus = await this.$M('getSyncStatus^SYNC')
      if (syncStatus && syncStatus.status === true) {
        this.syncing = true
        this.syncPID = syncStatus.pid
      } else {
        this.syncing = false
      }
      const checker = async () => {
        const syncSt = await this.$M('getSyncStatus^SYNC')
        if (syncSt && syncSt.status === true && this.killChecker === false) {
          this.syncing = true
          this.syncPID = syncSt.pid
          setTimeout(async () => { await checker() }, 3000)
        } else {
          this.syncing = false
        }
      }
      await checker()
    }
  }
}
</script>
