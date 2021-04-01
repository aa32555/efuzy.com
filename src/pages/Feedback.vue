<template>
<q-pull-to-refresh
        @refresh="$store.dispatch('app/updateRouterKey')"
        >
 <q-page class="">
   <q-card>
         <div class="q-pa-md q-gutter-sm" style="width:80vw;min-width:380px;padding:10px;max-width:1200px;">
      <q-breadcrumbs>
        <q-breadcrumbs-el
          label="Home"
          to="/"
        />
        <q-breadcrumbs-el
          label="Feedback"
          to="/feedback"
        />
      </q-breadcrumbs>
    </div>
        <div class="flex flex-center">
    <q-list
      dense
      bordered
      :style="'width:80vw;min-width:380px;padding:10px;max-width:1200px;'"
    >
      <br />
      <div class="flex flex-center">
        <q-btn
          rounded
          outline
          style="width:40px;font-size:13px;height:40px;"
          icon="skip_previous"
          @click="goBackOne"
        />
        <q-btn
          style="width:45px;font-size:13px;height:40px;"
          @click="goToday"
          :label="'Today'"
          rounded
          outline

        />
        <q-btn
          style="width:230px;font-size:13px;height:40px;"
          icon="calendar_today"
          :label="latestDate"
          @click="prompt=true"
          rounded
          outline

        />
        <q-btn
          style="width:40px;font-size:13px;height:40px;"
          icon="skip_next"
          rounded
          outline
          @click="goForwardOne"
        />
      </div>

      <div class="flex flex-center">
        <q-btn
          style="width:380px;font-size:13px;height:40px;margin-top:5px"
          icon="send"
          :label="'Send Feedback Request'"
          rounded
          outline
          @click="confirm = true"
        />
      </div>
      <br />

      <div
        v-for="(item,index) of statsList"
        :key="index"
      >
        <q-item>
          <q-item-section>
            <q-item-label>
              <q-toggle
                v-model="doNotSend['ID-'+item.id]"
                checked-icon="check"
                color="teal"
                unchecked-icon="clear"
                @input="updateDonotSendList"
              />
              <q-btn
                icon="chat_bubble"
                color="grey"
                round
                size="xs"
                @click="handleChatBubbleClick(item.invoiceId)"
              />
              &nbsp;
              {{item.name}}
            </q-item-label>

            <q-item-label
              caption
              :lines="1"
              v-for="(sitem,sindex) in item.item"
              :key="'sindex_'+sindex"
            >{{sitem}}</q-item-label>
            <q-item-label
              caption
              :lines="10"
              v-if="item.rejected && item.rejected.length"
              style="color:red;font-size:14px"
            >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{{item.rejected}}</q-item-label>
            <div v-if="item.reply && item.reply.length">
              <q-item-label
                caption
                :lines="10"
                v-for="(reply,indx) in item.reply"
                :key="'reply-'+indx"
              >
                <q-avatar size="sm">
                  <img src="..\assets\message.png" />
                </q-avatar>&nbsp;
                <span class="text-caption">{{reply.TIME}}-{{reply.USER}}</span>&nbsp;
                <span :class="{'text-primary':(reply.TYPE==='R'?true:false),'text-bold':true}">{{reply.MESSAGE}}</span>
              </q-item-label>
            </div>
          </q-item-section>
          <q-item-section
            side
            top
          >
            <span>
              <q-icon
                :style=" Number(star) <= Number(item.stars)?'color:#ffd055':'color:#d8d8d8'"
                name="star"
                :size="'sm'"
                v-for="star in 5"
                :key="star"
              />
            </span>
            <q-badge
              color="black"
              :label="item.staff"
            />
            <q-badge
              color="black"
              :label="item.paid + ' ' +item.method"
            />
            <q-badge
              color="black"
              :label="item.time"
            />
            <q-badge
              :color="item.status === 'delivered'?'green':(item.status === 'Not Sent'?'red':'orange')"
              :label="item.status"
            />
          </q-item-section>
        </q-item>
        <q-separator
          spaced
          inset
        />
      </div>
    </q-list>
    </div>

    <q-dialog
      v-model="prompt"
      persistent
    >
      <q-card>
        <q-card-section>
          <div class="text-h6">Select a date</div>
        </q-card-section>
        <q-card-section>
          <q-date
            color="black"
            v-model="date"
            autofocus
          />
        </q-card-section>
        <q-card-actions
          align="right"
          class="text-primary"
        >
          <q-btn
            flat
            label="Cancel"
            v-close-popup
            @click="prompt=false"
            color="black"
          />
          <q-btn
            flat
            label="Submit"
            v-close-popup
            @click="filterDate"
            color="black"
          />
        </q-card-actions>
      </q-card>
    </q-dialog>

    <q-dialog
      v-model="confirm"
      persistent
    >
      <q-card>
        <q-card-section class="row items-center">
          <q-avatar
            icon="send"
            color="black"
            text-color="white"
          />
          <span class="q-ml-sm">Send Feedback Request for Current Date ?</span>
        </q-card-section>

        <q-card-actions align="right">
          <q-btn
            flat
            label="Cancel"
            color="black"
            v-close-popup
          />
          <q-btn
            flat
            label="Send"
            color="black"
            v-close-popup
            @click="sendFeedback"
          />
        </q-card-actions>
      </q-card>
    </q-dialog>

    <q-dialog
      v-model="chatDialog"
      persistent
      :maximized="chatMaximizedToggle"
      transition-show="slide-up"
      transition-hide="slide-down"
      @before-show="handleBeforeChatShow"
    >
      <q-card class>
        <q-bar>
          <q-space />

          <q-btn
            dense
            flat
            icon="minimize"
            @click="chatMaximizedToggle = false"
            v-if="chatMaximizedToggle"
          >
            <q-tooltip
              v-if="chatMaximizedToggle"
              content-class="bg-white text-primary"
            >Minimize</q-tooltip>
          </q-btn>
          <q-btn
            dense
            flat
            icon="crop_square"
            @click="chatMaximizedToggle = true"
            v-if="!chatMaximizedToggle"
          >
            <q-tooltip
              v-if="!chatMaximizedToggle"
              content-class="bg-white text-primary"
            >Maximize</q-tooltip>
          </q-btn>
          <q-btn
            dense
            flat
            icon="close"
            v-close-popup
          >
            <q-tooltip content-class="bg-white text-primary">Close</q-tooltip>
          </q-btn>
        </q-bar>
        <q-card-section>
          <q-pull-to-refresh
            @refresh="realodChat"
            :disable="true"
          >
            <div class="q-pa-md row justify-center">
              <div :style="'width: 100%; max-width: 400px;'+(this.$q.platform.is.mobile?'overflow-y:scroll;':'')">
                <q-chat-message
                  v-for="(message,index) in currentInvoiceDetails.invoiceMessages"
                  :key="'M'+index"
                  :text="[message.MESSAGE]"
                  :sent="message.TYPE==='R'?true:false"
                  :name="message.USER"
                  :stamp="message.TIME"
                  :bg-color="message.TYPE==='S'?'black':'primary'"
                  :text-color="message.TYPE==='S'?'white':'white'"
                />
                <br />
                <br />
                <q-input
                  class="vertical-bottom"
                  v-model="chatText"
                  filled
                  type="textarea"
                >
                  <template v-slot:hint>Type something...</template>

                  <template
                    v-slot:after
                    class="vertical-bottom"
                  >
                    <q-btn
                      round
                      dense
                      flat
                      icon="send"
                      @click="sendFeedbackTextMessage"
                    />
                  </template>
                </q-input>
              </div>
            </div>
          </q-pull-to-refresh>
        </q-card-section>
      </q-card>
    </q-dialog>
  </q-card>
  </q-page>
  </q-pull-to-refresh>
</template>
<script>
import { date } from 'quasar'

export default {
  data () {
    return {
      latestDate: '',
      statsList: [],
      prompt: false,
      date: this.$q.localStorage.getItem('feedback-date') || this.getToday(),
      doNotSend: {},
      confirm: false,
      chatDialog: false,
      chatMaximizedToggle: !!this.$q.platform.is.mobile,
      currentInvoice: '',
      chatText: '',
      currentInvoiceDetails: {
        'Client Name': '',
        Note: '',
        'Mobile Number': '',
        invoiceMessages: []
      },
      currentInvoiceList: []
    }
  },
  components: {
  },
  watch: {
    date (v) {
      this.$q.localStorage.set('feedback-date', v)
    }
  },
  async mounted () {
    await this.getStats()
  },
  methods: {
    async sendFeedbackTextMessage () {
      await this.$M('sendFeedbackTextMessage^AR', {
        invoice: this.currentInvoice,
        chatText: this.chatText
      })
      this.chatText = ''
      await this.handleBeforeChatShow()
    },
    async handleBeforeChatShow () {
      const data = await this.$M('GetInvoiceDetails^AR', {
        invoice: this.currentInvoice
      })
      if (data && data.data && data.data.invoiceDetails) {
        this.$set(this, 'currentInvoiceDetails', data.data.invoiceDetails)
        this.currentInvoiceList = data.data.list
      } else {
        this.chatDialog = false
      }
    },
    async handleChatBubbleClick (invoice) {
      this.currentInvoice = invoice
      this.$nextTick(() => {
        this.chatDialog = true
      })
    },
    async realodChat (done) {
      await this.handleBeforeChatShow()
      done()
    },
    async goBackOne () {
      await this.getStats('-1')
    },
    async goForwardOne () {
      await this.getStats('1')
    },
    async goToday () {
      await this.getStats('T')
    },
    async getStats (dir) {
      if (!dir) {
        dir = 0
      }
      if (dir === '-1') {
        let newDate = date.subtractFromDate(this.date, { days: 1 })
        newDate = date.formatDate(newDate, 'YYYY/MM/DD')
        this.date = newDate
      } else if (dir === '1') {
        let newDate = date.addToDate(this.date, { days: 1 })
        newDate = date.formatDate(newDate, 'YYYY/MM/DD')
        this.date = newDate
      } else if (dir === 'T') {
        this.date = this.getToday()
      }
      const data = await this.$M('getStats^FEEDBACK', {
        date: this.date,
        dir: dir
      })

      const donotSend = data.data.donotSend
      this.latestDate = data.data.latestDate
      // this.donotSend = donotSend
      this.$set(this, 'doNotSend', donotSend)
      const list = data.data.list
      this.statsList = list
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
    async sendFeedback (dir) {
      await this.$M('sendFeedBack^AR', {
        date: this.date
      })
      await this.getStats()
    },
    async updateDonotSendList () {
      await this.$M('updateDonotSendList^AR', {
        doNotSend: this.doNotSend
      })
      await this.getStats()
    }
  }
}
</script>
