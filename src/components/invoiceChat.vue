<template>
  <q-dialog
    :value="value"
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
      </q-card-section>
    </q-card>
  </q-dialog>
</template>
<script>
export default {
  name: 'invoiceChat',
  props: ['currentinvoice', 'value'],
  data () {
    return {
      chatDialog: false,
      chatMaximizedToggle: !!this.$q.platform.is.mobile,
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
  watch: {
    async currentInvoice () {
      //  await this.handleBeforeChatShow()
    }
  },
  methods: {
    async sendFeedbackTextMessage () {
      await this.$M('sendFeedbackTextMessage^AR', {
        invoice: this.currentinvoice,
        chatText: this.chatText
      })
      this.chatText = ''
      await this.handleBeforeChatShow()
    },
    async handleBeforeChatShow () {
      const data = await this.$M('GetInvoiceDetails^AR', {
        invoice: this.currentinvoice
      })
      if (data && data.data && data.data.invoiceDetails) {
        this.$set(this, 'currentInvoiceDetails', data.data.invoiceDetails)
        this.currentInvoiceList = data.data.list
      } else {
        this.chatDialog = false
      }
    },
    async handleChatBubbleClick (invoice) {
      // this.currentinvoice = invoice
      this.$nextTick(() => {
        this.chatDialog = true
      })
    }
  }
}
</script>
