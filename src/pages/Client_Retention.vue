<template>
  <FUZPage>
    <q-card class="flex flex-center" style="width:80vw;min-width:380px;padding:10px;max-width:1200px">
    <div class="q-pa-md q-gutter-sm" style="width:80vw;min-width:380px;padding:10px;max-width:1200px;">
      <q-breadcrumbs>
        <q-breadcrumbs-el
          label="Home"
          to="/"
        />
        <q-breadcrumbs-el
          label="Client Retention"
          to="/Client_Retention"
        />
      </q-breadcrumbs>
    </div>
    <q-list
      dense
      bordered
    >
      <q-infinite-scroll
        @load="loadMore"
        :key="pageKey"
      >
        <div class="q-gutter-sm" >
          <p style="width:80vw;min-width:380px;padding:10px;max-width:1200px;">
            <center>
              <q-btn
                size="md"
                @click="handleSendMessages"
                color="black"
                icon="send"
                label="Send Messages"
              />
              <q-checkbox
                v-model="showSent"
                label="Show Sent List"
                @input="filterList"
              />
              <p class="text-purple text-bold text-h6">{{total + ' ' + type + ' Clients'}}</p>
            </center>
          </p>

          <div
            v-if="showSent"
            class="fit row wrap justify-center items-start content-start"
          >

            <q-btn
              icon="event"
              color="orange"
            >
              <q-popup-proxy
                transition-show="scale"
                transition-hide="scale"
              >
                <q-date
                  v-model="sentFrom"
                  @input="filterList"
                >
                  <div class="row items-center justify-end q-gutter-sm">
                    <q-btn
                      label="Cancel"
                      color="primary"
                      flat
                      v-close-popup
                    />
                    <q-btn
                      label="OK"
                      color="secondary"
                      flat
                      v-close-popup
                    />
                  </div>
                </q-date>
              </q-popup-proxy>
              Campaign Begining Date {{sentFrom}}
            </q-btn>
            <q-btn
              icon="event"
              color="accent"
            >
              <q-popup-proxy
                transition-show="scale"
                transition-hide="scale"
              >
                <q-date
                  v-model="sentTo"
                  @input="filterList"
                >
                  <div class="row items-center justify-end q-gutter-sm">
                    <q-btn
                      label="Cancel"
                      color="primary"
                      flat
                      v-close-popup
                    />
                    <q-btn
                      label="OK"
                      color="accent"
                      flat
                      v-close-popup
                    />
                  </div>
                </q-date>
              </q-popup-proxy>
              Campaign End Date {{sentTo}}
            </q-btn>

            <center>
              <pie-chart :data="sentStats"></pie-chart>
            </center>
          </div>

          <q-radio
            v-model="filterRule"
            val="*"
            label="All"
            @input="filterList"
          />
          <q-radio
            v-for="(rule,index) in crRules"
            :key="'f'+index"
            v-model="filterRule"
            :val="index"
            :label="rule.rule"
            @input="filterList"
          />
        </div>

        <div
          v-for="(client,cindex) in list"
          :key="'C'+cindex"
        >
          <q-item>
            <q-item-section top>
              <q-item-label lines="1">
                <q-item-label>
                  <q-avatar
                    color="primary"
                    text-color="white"
                    size="lg"
                  >{{ client.name[0] }}</q-avatar>&nbsp;
                  <q-btn
                    icon="chat_bubble"
                    color="secondary"
                    round
                    size="xs"
                    @click="handleChatBubbleClick(client.invoiceNo)"
                  /> &nbsp;&nbsp;
                  <span class="text-weight-medium">{{client.name}}</span>&nbsp;&nbsp;&nbsp;&nbsp;
                  <span>{{client.lastHere}}&nbsp;&nbsp;</span>

                </q-item-label>
              </q-item-label>

              <q-item-label
                caption
                lines="1"
                v-if="showSent"
              >
                <span class="text-purple text-bold">{{client.matchedRuleName}} on {{client.lastSentOn}} by {{client.lastSentBy}}</span>
                <div
                  v-for="(message,clindex) in client.messages"
                  :key="'clm'+clindex"
                >
                  <q-avatar size="sm">
                    <img src="statics\message.png" />
                  </q-avatar>&nbsp;
                  <span class="text-caption">{{message.TIME}}-{{message.USER}}</span>&nbsp;
                  <span :class="{'text-primary':true,'text-bold':true}">{{message.MESSAGE}}</span>
                </div>
              </q-item-label>
              <q-item-label
                caption
                lines="3"
                v-for="(service,sindex) in client.services"
                :key="'id'+client.id+'-'+sindex"
              >
                <span class="text-teal text-bold">{{service.time}}</span>
                &nbsp;-&nbsp;
                <span class="text-orange">{{service.matched}}</span>&nbsp;&nbsp;&nbsp; <span class="text-info">{{service.staff}}</span>
                <br />
                {{service.service}}
              </q-item-label>
            </q-item-section>
          </q-item>
          <q-separator spaced />
        </div>
        <invoiceChat
          v-model="chatDialog"
          :currentinvoice="currentInvoice"
        />
      </q-infinite-scroll>
    </q-list>
    </q-card>
  </FUZPage>
</template>
<script>
import Vue from 'vue'
import FUZPage from '../FUZ/FUZPage/FUZPage'
import Chartkick from 'vue-chartkick'
import Chart from 'chart.js'
import invoiceChat from '../components/invoiceChat'
import { uid } from 'quasar'

Vue.use(Chartkick.use(Chart))

export default {
  data () {
    return {
      doNotSend: {},
      list: [],
      total: '',
      type: '',
      done: false,
      crRules: [],
      filterRule: '*',
      sendMessages: false,
      showSent: false,
      currentInvoice: '',
      chatDialog: false,
      sentStats: {},
      sentFrom: '',
      sentTo: '',
      pageKey: uid()
    }
  },
  components: {
    FUZPage,
    invoiceChat
  },
  async mounted () {
    await this.handleMounted()
  },
  methods: {
    async handleChatBubbleClick (id) {
      this.currentInvoice = id
      this.chatDialog = false
      this.$nextTick(() => {
        this.chatDialog = true
      })
    },
    async filterList () {
      this.list = []
      this.total = ''
      this.type = ''
      this.done = false
      this.sendMessages = false
      this.pageKey = uid()
      this.chatDialog = false

      // await this.loadMore(1)
    },
    async handleSendMessages () {
      this.sendMessages = true
      this.list = []
      this.total = ''
      this.type = ''
      this.done = false
      await this.loadMore(1)
      this.sendMessages = false
      await this.filterList()
    },
    async updateDonotSendList () {
      await this.$M('updateDonotSendList^AR', {
        doNotSend: this.doNotSend
      })
      await this.handleMounted()
    },
    async handleMounted () {
      const list = await this.$m('GENREFERALS^CLIENTRETENTION', { mounted: true })
      console.log(list)
      if (list && list.data && list.data.crRules) {
        const crRules = list.data.crRules

        // this.$set(this.$data, 'crRules', crRules)
        this.crRules = crRules
      }
    },
    async loadMore (index, done) {
      if (this.done === true && typeof done === 'function') {
        done()
        return
      }

      const list = await this.$M('GENREFERALS^CLIENTRETENTION', {
        index,
        rule: this.filterRule,
        sendMessages: this.sendMessages,
        showSent: this.showSent,
        sentTo: this.sentTo,
        sentFrom: this.sentFrom
      })
      if (list && list.data && list.data.crRules) {
        const crRules = list.data.crRules

        // this.$set(this.$data, 'crRules', crRules)
        this.crRules = crRules
      }

      if (list && list.data && list.data.LIST) {
        this.list = this.list.concat(list.data.LIST)
      }
      if (list && list.data && list.data.total) {
        this.total = list.data.total
      }
      if (list && list.data && list.data.type) {
        this.type = list.data.type
      }
      if (list && list.data && list.data.sentStats) {
        this.$set(this.$data, 'sentStats', list.data.sentStats)
      } else {
        this.$set(this.$data, 'sentStats', {
          Claimed: '0',
          OptedOut: '0'
        })
      }
      if (list && list.data && list.data.done) {
        this.done = list.data.done

        if (typeof done === 'function') {
          done()
        }

        return
      }

      if (list && list.data && list.data.donotSend) {
        const donotSend = list.data.donotSend
        this.$set(this, 'doNotSend', donotSend)
      }
      if (typeof done === 'function') {
        done()
      }
    }
  }
}

</script>
