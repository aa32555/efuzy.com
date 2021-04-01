<template>
  <FUZPage>
    <q-card style="width:80vw;min-width:380px;padding:10px;max-width:1200px;min-height:75vh;" >
      <q-tabs
        v-model="tab"
        dense
        class="text-grey"
        active-color="primary"
        indicator-color="black"
        align="justify"
        narrow-indicator
      >
        <q-tab
          name="general"
          label="General"
        />
        <q-tab
          name="client_retension"
          label="Client Retension"
        />
        <q-tab
          name="online_booking_prompts"
          label="Online Booking Prompts"
        />

      </q-tabs>

      <q-separator />

      <q-tab-panels
        v-model="tab"
        animated
      >
        <q-tab-panel name="online_booking_prompts" class="q-pa-md flex flex-center">
          <div

            :style="$q.platform.is.mobile?'width: 400px':'width:800px;'"
          >
            <q-form
              @submit="onSubmitOnlineBookingPrompts"
              class="q-gutter-md"
            >
              <q-input
                filled
                v-model="step1"
                label="Step 1"
                hint="Welcome to {salon} Let's start by looking you up in our system. Can you please provide us with your phone number?"
                lazy-rules
                :rules="[ val => val && val.length > 0 || 'Please type something']"
              />
              <q-input
                filled
                v-model="step2"
                label="Step 2"
                hint="Please enter the verfication code that was sent to {phone}"
                lazy-rules
                :rules="[ val => val && val.length > 0 || 'Please type something']"
              />
              <q-input
                filled
                v-model="step3a"
                label="Step 3a"
                hint="Let's start the booking process by entering your firstname, lastname, and your email"
                lazy-rules
                :rules="[ val => val && val.length > 0 || 'Please type something']"
              />
              <q-input
                filled
                v-model="step3b"
                label="Step 3b"
                hint="Welcome back {firstname}. Hope you enjoyed your last {lastService} on {serviceDate}. You have {appointmentsNumbers} upcoming appointments, you can reschedule, or book a new appointment."
                lazy-rules
                :rules="[ val => val && val.length > 0 || 'Please type something']"
              />
              <q-input
                filled
                v-model="step4"
                label="Step 4"
                hint="Your appointment is set for {appDate} at {appTime} with {appStaff}. the appointment is for {appServices}. the appointment will cost {this.appCost}"
                lazy-rules
                :rules="[ val => val && val.length > 0 || 'Please type something']"
              />
              <q-input
                filled
                v-show="false"
                v-model="step5"
                label="Step 5"
                hint="Your current appointment is scheduled for {appDate}, please choose a different date or proceed to change the time. Only available days are showing."
                lazy-rules
                :rules="[ val => val && val.length > 0 || 'Please type something']"
              />
              <q-input
                filled
                v-show="false"
                v-model="step6"
                label="Step 6"
                hint="your appointment date is set for {newResDate}. Now choose a time for the appointment"
                lazy-rules
                :rules="[ val => val && val.length > 0 || 'Please type something']"
              />
              <q-input
                filled
                v-show="false"
                v-model="step7"
                label="Step 7"
                hint="You're about to reschedule your appointment for {newResDate} at {resTime}"
                lazy-rules
                :rules="[ val => val && val.length > 0 || 'Please type something']"
              />
              <q-input
                filled
                v-show="false"
                v-model="step8"
                label="Step 8"
                hint="You're all set for {newResDate} at {resTime}"
                lazy-rules
                :rules="[ val => val && val.length > 0 || 'Please type something']"
              />
              <q-input
                filled
                v-show="false"
                v-model="step9"
                label="Step 9"
                hint="You're all set. Your appointment has been canceled"
                lazy-rules
                :rules="[ val => val && val.length > 0 || 'Please type something']"
              />
             <q-input
                filled
                v-model="step10"
                label="Step 5"
                hint="Welcome to the Salon {firstname}. Let's start the booking process."
                lazy-rules
                :rules="[ val => val && val.length > 0 || 'Please type something']"
              />
              <q-input
                filled
                v-model="step11"
                label="Step 6"
                hint="Please select a category, or multiple categories"
                lazy-rules
                :rules="[ val => val && val.length > 0 || 'Please type something']"
              />
              <q-input
                filled
                v-model="step12"
                label="Step 7"
                hint="Please select a service, or multiple services."
                lazy-rules
                :rules="[ val => val && val.length > 0 || 'Please type something']"
              />
                            <q-input
                filled
                v-model="step13"
                label="Step 8"
                hint='Please select a Stylist, or choose "No preference" for maximum availability'
                lazy-rules
                :rules="[ val => val && val.length > 0 || 'Please type something']"
              />
                                          <q-input
                filled
                v-model="step14"
                label="Step 9"
                hint='Please select a date for the appointment'
                lazy-rules
                :rules="[ val => val && val.length > 0 || 'Please type something']"
              />
                                                        <q-input
                filled
                v-model="step15"
                label="Step 10"
                hint='Please select a time for the appointment'
                lazy-rules
                :rules="[ val => val && val.length > 0 || 'Please type something']"
              />                                                      <q-input
                filled
                v-model="step16"
                label="Step 11"
                hint='Your stylist will be {stylist}'
                lazy-rules
                :rules="[ val => val && val.length > 0 || 'Please type something']"
              />
                                                                 <q-input
                filled
                v-model="step17"
                label="Step 12"
                hint="You\'re all set for {date} at {time} with {stylist}"
                lazy-rules
                :rules="[ val => val && val.length > 0 || 'Please type something']"
              />
              <div>
                <q-btn
                  label="Submit"
                  type="submit"
                  color="black"
                />
              </div>
            </q-form>
          </div>
        </q-tab-panel>
        <q-tab-panel name="general" class=" flex flex-center">
          <div
            class="q-pa-md"
            :style="$q.platform.is.mobile?'width: 400px':'width:800px;'"
          >
            <q-form
              @submit="onSubmitGeneral"
              @reset="onResetGeneral"
              class="q-gutter-md"
            >
              <q-input
                filled
                v-model="name"
                label="Your name"
                hint
                lazy-rules
                :rules="[ val => val && val.length > 0 || 'Please type something']"
              />
              <q-input
                filled
                v-model="salonTitle"
                label="Salon Name"
                hint
                lazy-rules
                :rules="[ val => val && val.length > 0 || 'Please type something']"
              />
              <!-- <q-toggle v-model="accept" label="I accept the license and terms" /> -->
              <q-input
                filled
                v-model="smsPhone"
                label="Assigned SMS Number"
                hint
                lazy-rules
                disable
                :rules="[ val => val && val.length > 0 || 'Please type something']"
              />
              <q-input
                filled
                v-model="globalDaysBetweenC"
                label="Number of Days since last visit for campaign to be sent!"
                mask="###"
                lazy-rules
                :rulesx="[ val => val && val.length > 0 || 'Please type something']"
              />
              <span class="text-grey">{{'You may use [[salon]], [[name]], [[coupon]] and [[staff]] to reference salon name, client name, unique coupon code and staff name'}}</span>
              <q-input
                v-model="feedBackText"
                filled
                label="Outgoing Feedback message"
                type="textarea"
                :rules="[ val => val && val.length > 0 || 'Please type something']"
              />
              <q-input
                filled
                v-model="numberMinFeedback"
                label="Number of Minutes before replying to the feedback request!"
                mask="###"
                lazy-rules
                :rulesx="[ val => val && val.length > 0 || 'Please type something']"

              />
              <q-input
                v-model="feedBackAnsG"
                filled
                label="No stars Feedback Answer"
                type="textarea"
                :rules="[ val => val && val.length > 0 || 'Please type something']"

              />
              <q-input
                v-model="feedBackAns1"
                filled
                label="1 Star Feedback Answer"
                type="textarea"
                :rules="[ val => val && val.length > 0 || 'Please type something']"

              />
              <q-input
                v-model="feedBackAns2"
                filled
                label="2 Star Feedback Answer"
                type="textarea"
                :rules="[ val => val && val.length > 0 || 'Please type something']"

              />
              <q-input
                v-model="feedBackAns3"
                filled
                label="3 Star Feedback Answer"
                type="textarea"
                :rules="[ val => val && val.length > 0 || 'Please type something']"

              />
              <q-input
                v-model="feedBackAns4"
                filled
                label="4 Star Feedback Answer"
                type="textarea"
                :rules="[ val => val && val.length > 0 || 'Please type something']"

              />
              <q-input
                v-model="feedBackAns5"
                filled
                label="5 Star Feedback Answer"
                type="textarea"
                :rules="[ val => val && val.length > 0 || 'Please type something']"

              />

              <div>
                <q-btn
                  label="Submit"
                  type="submit"
                  color="black"
                   @click="onSubmitGeneral"
                />
              </div>
            </q-form>
          </div>
        </q-tab-panel>
        <q-tab-panel
          name="client_retension" style="height:calc(100vh - 48px);"
        >
          <div class="text-h6">Client Retension Rules Setup</div>
          <q-toggle
            v-model="toggleDraggable"
            label="Reorder rules"
          />
          <component
            :is="draggable"
            v-model="crRules"
            @end="dragRulesend"
          >
            <li
              v-for="(rule,index) in crRules"
              :key="index"
            >
              <q-badge
                :key="'b'+index"
                color="primary"
                text-color="white"
                size="lg"
                style="width:250px"
              >{{rule.rule}} - {{rule.services.length + ' Services.'}}</q-badge>&nbsp;&nbsp;&nbsp;
              <q-btn
                style="width:15px"
                size="sm"
                :color="'secondary'"
                icon="edit"
                @click="editgRule(index)"
              ></q-btn>&nbsp;
              <q-btn
                round
                color="warning"
                text-color="black"
                @click="handleDeleteRule(index)"
                icon="delete_forever"
              />
            </li>
          </component>
            <q-btn
              fab
              icon="add"
              color="positive"
              @click="handleAddNewRule"
            />
          <q-dialog
            v-model="clientRetentionDialog"
            persistent
          >
            <q-card style="width: 800px">
              <q-card-section>
                <div class="text-h6">Client Retention Setup</div>
              </q-card-section>
              <q-form
                @submit="onSubmitCSR"
                @reset="onResetCSR"
                class="q-gutter-md"
              >
                <q-card-section>
                  <q-input
                    filled
                    v-model="crServicesNameSelected"
                    label="Rule Name"
                    hint
                    lazy-rules
                    :rules="[ val => val && val.length > 0 || 'Please type something']"
                  />
                  <q-select
                    filled
                    multiple
                    v-model="crServicesSelected"
                    :options="Object.keys(crServices)"
                    label="Please Select Service(s)"
                    behavior="menu"
                    required
                    :rules="[ val => val && val.length > 0 || 'Please type something']"
                  />
                  <q-input
                    filled
                    v-model="crServicesDaysSelected"
                    label="Number of Days since Service(s)"
                    mask="###"
                    lazy-rules
                    :rulesx="[ val => val && val.length > 0 || 'Please type something']"
                  />
                  <div class="q-pa-md">
                    <span>Associated Message</span>
                    <br />
                    <span class="text-grey">{{'You may use [[salon]], [[name]], [[coupon]] and [[staff]] to reference salon name, client name, unique coupon code and staff name'}}</span>
                    <q-input
                      v-model="crServiceMessage"
                      filled
                      type="textarea"
                      :rules="[ val => val && val.length > 0 || 'Please type something']"
                    />
                    <span class="text-grey">{{'If reply is 1. You may use [[salon]], [[name]], [[coupon]] and [[staff]] to reference salon name, client name, unique coupon code and staff name'}}</span>

                    <q-input
                      v-model="crServiceMessageReply1"
                      filled
                      type="textarea"
                      :rules="[ val => val && val.length > 0 || 'Please type something']"
                    />
                    <span class="text-grey">{{'if Reply is 2. You may use [[salon]], [[name]], [[coupon]] and [[staff]] to reference salon name, client name, unique coupon code and staff name'}}</span>

                    <q-input
                      v-model="crServiceMessageReply2"
                      filled
                      type="textarea"
                      :rules="[ val => val && val.length > 0 || 'Please type something']"
                    />

                  </div>

                </q-card-section>

                <q-card-actions
                  align="right"
                >
                  <q-btn
                    label="Save"
                    type="submit"
                    color="postitive"
                  />
                  <q-btn
                    label="Reset"
                    type="reset"
                    flat
                    class="q-ml-sm"
                  />
                  <q-btn
                    label="Close"
                    flat
                    class="q-ml-sm"
                    v-close-popup
                  />
                </q-card-actions>
              </q-form>
            </q-card>
          </q-dialog>
        </q-tab-panel>
      </q-tab-panels>
    </q-card>
  </FUZPage>
</template>
<script>
import FUZPage from '../FUZ/FUZPage/FUZPage'
import draggable from 'vuedraggable'
export default {
  data () {
    return {
      staffOrder: [],
      tab: this.$q.localStorage.getItem('SETTINGS_TABS') || 'general',
      name: '',
      staff: '',
      staffOptions: {},
      adminPassword: '',
      smsPhone: '',
      staffList: [],
      clientRetentionDialog: false,
      crServices: {},
      crServicesSelected: [],
      crServicesNameSelected: '',
      crServicesDaysSelected: '',
      crServiceMessage: '',
      crServiceMessageReply1: '',
      crServiceMessageReply2: '',
      crRules: [],
      draggable: 'div',
      toggleDraggable: false,
      ruleIndex: '',
      feedBackText: '',
      salonTitle: '',
      globalDaysBetweenC: '',
      numberMinFeedback: '0',
      feedBackAnsG: '',
      feedBackAns1: '',
      feedBackAns2: '',
      feedBackAns3: '',
      feedBackAns4: '',
      feedBackAns5: '',
      staffDetails: [],
      list: [],
      step1: '',
      step2: '',
      step3a: '',
      step3b: '',
      step4: '',
      step5: '',
      step6: '',
      step7: '',
      step8: '',
      step9: '',
      step10: '',
      step11: '',
      step12: '',
      step13: '',
      step14: '',
      step15: '',
      step16: '',
      step17: ''
    }
  },
  components: {
    FUZPage,
    draggable
  },
  watch: {
    toggleDraggable (v) {
      if (v === true) {
        this.draggable = 'draggable'
      } else {
        this.draggable = 'div'
      }
    },
    tab (v) {
      this.$q.localStorage.set('SETTINGS_TABS', v)
    }
  },
  async mounted () {
    await this.handleMounted()
    // this.tab = this.$q.localStorage.getItem('SETTINGS_TABS') || 'general'
  },
  methods: {
    async onSubmitOnlineBookingPrompts () {
      const data = await this.$M('saveOnlinePrompts^SETTINGS', {
        step1: this.step1,
        step2: this.step2,
        step3a: this.step3a,
        step3b: this.step3b,
        step4: this.step4,
        step5: this.step5,
        step6: this.step6,
        step7: this.step7,
        step8: this.step8,
        step9: this.step9,
        step10: this.step10,
        step11: this.step11,
        step12: this.step12,
        step13: this.step13,
        step14: this.step14,
        step15: this.step15,
        step16: this.step16,
        step17: this.step17
      })
      if (data.data.status === 'saved') {
        this.$q.notify('Saved !')
      }
    },
    async saveStaffDetails () {
      const data = await this.$M('setStaffDetails^AR', {
        order: this.staffOrder,
        staffDetails: this.staffDetails
      })
      if (data && data.data && data.data.saved === true) {
        this.$q.notify('Saved !')
      }
    },
    handleAddNewRule () {
      this.ruleIndex = ''
      this.clientRetentionDialog = true
    },
    async handleDeleteRule (index) {
      this.$q
        .dialog({
          title: 'Confirm',
          message:
            'Are you user you want to delete this rule' +
            ' ?\nThis is permanent and cannot be undone',
          cancel: true,
          persistent: true
        })
        .onOk(async () => {
          const data = await this.$M('deleteCRRule^SETTINGS', { index: index })
          if (data && data.data && data.data.crRules) {
            this.$set(this, 'crRules', data.data.crRules)
          } else {
            this.crRules = []
          }
        })
    },
    async dragRulesend () {
      await this.$M('setCRRules^SETTINGS', { rules: this.crRules })
    },
    async editgRule (index) {
      this.ruleIndex = index
      this.crServicesSelected = this.crRules[index].services
      this.crServicesNameSelected = this.crRules[index].rule
      this.crServicesDaysSelected = Number(this.crRules[index].days)
      this.crServiceMessage = this.crRules[index].txt
      this.crServiceMessageReply1 = this.crRules[index].reply1
      this.crServiceMessageReply2 = this.crRules[index].reply2
      this.clientRetentionDialog = true
    },
    async onSubmitCSR () {
      await this.$M('setCRRulesAssign^SETTINGS', {
        rule: this.crServicesNameSelected,
        services: this.crServicesSelected,
        days: this.crServicesDaysSelected,
        txt: this.crServiceMessage,
        index: this.ruleIndex,
        reply1: this.crServiceMessageReply1,
        reply2: this.crServiceMessageReply2
      })
      this.clientRetentionDialog = false
      const tab = this.tab
      await this.handleMounted()
      this.tab = tab
    },
    onResetCSR () {
      this.crServicesSelected = []
      this.crServicesNameSelected = ''
      this.crServicesDaysSelected = ''
      this.crServiceMessage = ''
      this.crServiceMessageReply1 = ''
      this.crServiceMessageReply2 = ''
    },
    async handleDeleteStaff (staff) {
      this.$q
        .dialog({
          title: 'Confirm',
          message:
            'Are you user you want to delete ' +
            staff.email +
            ' ?\nThis is permanent and cannot be undone',
          cancel: true,
          persistent: true
        })
        .onOk(async () => {
          await this.$M('deleteStaffAssign^AR', {
            email: staff.email
          })

          const tab = this.tab
          await this.handleMounted()
          this.tab = tab
        })
    },
    async handleAssignStaff (staff, option) {
      await this.$M('setStaffAssign^AR', {
        email: staff.email,
        staff: option
      })
      const tab = this.tab
      await this.handleMounted()
      this.tab = tab
    },
    async handleMounted () {
      const data = await this.$M('getSettings^SETTINGS')
      this.name = data.data.name
      this.staff = data.data.staff
      this.smsPhone = data.data.smsPhone
      this.adminPassword = data.data.adminPassword
      this.salonTitle = data.data.salonTitle
      this.feedBackText = data.data.feedBackText
      this.globalDaysBetweenC = data.data.globalDaysBetweenC
      this.numberMinFeedback = data.data.numberMinFeedback
      this.feedBackAns1 = data.data.feedBackAns1
      this.feedBackAns2 = data.data.feedBackAns2
      this.feedBackAns3 = data.data.feedBackAns3
      this.feedBackAns4 = data.data.feedBackAns4
      this.feedBackAns5 = data.data.feedBackAns5
      this.feedBackAnsG = data.data.feedBackAnsG
      this.step1 = data.data.onlineBookingSteps.step1
      this.step10 = data.data.onlineBookingSteps.step10
      this.step2 = data.data.onlineBookingSteps.step2
      this.step3a = data.data.onlineBookingSteps.step3a
      this.step3b = data.data.onlineBookingSteps.step3b
      this.step4 = data.data.onlineBookingSteps.step4
      this.step5 = data.data.onlineBookingSteps.step5
      this.step6 = data.data.onlineBookingSteps.step6
      this.step7 = data.data.onlineBookingSteps.step7
      this.step8 = data.data.onlineBookingSteps.step8
      this.step9 = data.data.onlineBookingSteps.step9
      this.step11 = data.data.onlineBookingSteps.step11
      this.step12 = data.data.onlineBookingSteps.step12
      this.step13 = data.data.onlineBookingSteps.step13
      this.step14 = data.data.onlineBookingSteps.step14
      this.step15 = data.data.onlineBookingSteps.step15
      this.step16 = data.data.onlineBookingSteps.step16
      this.step17 = data.data.onlineBookingSteps.step17

      if (data && data.data && data.data.staffOptions) {
        this.$set(this, 'staffOptions', data.data.staffOptions)
      }
      if (data && data.data && data.data.crServices) {
        this.$set(this, 'crServices', data.data.crServices)
      }
      if (data && data.data && data.data.staffList) {
        this.$set(this, 'staffList', data.data.staffList)
      }
      if (data && data.data && data.data.crRules) {
        this.$set(this, 'crRules', data.data.crRules)
      }
      if (data && data.data && data.data.staffDetails) {
        this.staffDetails = data.data.staffDetails
      }
    },
    async onSubmitGeneral () {
      const data = await this.$M('setSettings^SETTINGS', {
        name: this.name,
        staff: this.staff,
        smsPhone: this.smsPhone,
        adminPassword: this.adminPassword,
        feedBackText: this.feedBackText,
        salonTitle: this.salonTitle,
        globalDaysBetweenC: this.globalDaysBetweenC,
        numberMinFeedback: this.numberMinFeedback,
        feedBackAnsG: this.feedBackAnsG,
        feedBackAns1: this.feedBackAns1,
        feedBackAns2: this.feedBackAns2,
        feedBackAns3: this.feedBackAns3,
        feedBackAns4: this.feedBackAns4,
        feedBackAns5: this.feedBackAns5
      })
      this.$q.notify(data.data.resp)
      this.$q.dialog({
        title: 'Settings',
        message:
          'You may need to logoff and login back again, for changes to take effect!'
      })
    },
    onResetGeneral () {
      // this.name = ''
      // this.adminPassword = ''
      // this.smsPhone = ''
      //  this.feedBackText = ''
      // this.salonTitle = ''
      // this.globalDaysBetweenC = ''
    }
  }
}
</script>
