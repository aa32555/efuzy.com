<template>
<div>
  <cv-modal
    style="z-index:2;"
  :ref="'modal'"
  :close-aria-label="'Close'"
  :size="'large'"
  :primary-button-disabled="false"
  @modal-shown="()=>{}"
  @modal-hidden="()=>{}"
  @modal-hide-request="()=>{}"
  @primary-click="handleBook"
  @secondary-click="()=>{}"
  :auto-hide-off="true">
  <template slot="label">New Appointment</template>
  <template  slot="title">&nbsp;
  </template>
  <template slot="content">
       <FUZPage class="flex" styleLTLG="width:100%;">
           <FUZDiv :colLG="4" :colMD="6"  :colSM="6" baseStyle="padding-bottom:10px;max-height:75vh;overflow-y:auto">
                <FUZDiv :colLG="12" baseStyle="padding-bottom:10px;padding-top:10px"  baseClass="bg-primary">
            <FUZListSearchMini :rules="['Required']" v-model="appointment.location" routine="List^LOCATIONS" type="LOCATIONS" label="Location" :selectItems="{avatar:'image',label:'name'}" />
      </FUZDiv>
                <FUZDiv :colLG="12" baseStyle="padding-bottom:10px"  baseClass="bg-primary">
                   <FUZDiv :colLG="12" baseStyle="padding-bottom:10px">
              <q-input
                style="padding-bottom:10px;min-width:200px;"
                rounded
                outlined

                v-model="appointment.date"
                label="Appointment Date"
                mask="##/##/####"
              >
                <template v-slot:append>
                  <q-icon
                    name="event"
                    class="cursor-pointer"
                  >
                    <q-popup-proxy
                      ref="qDateProxy"
                      transition-show="scale"
                      transition-hide="scale"
                    >
                      <q-date
                        v-model="appointment.date"
                        mask="MM/DD/YYYY"
                        @input="() => $refs.qDateProxy.hide()"
                      />
                    </q-popup-proxy>
                  </q-icon>
                </template>
              </q-input>
              </FUZDiv>
               <FUZDiv :colLG="12" baseStyle="padding-bottom:10px;min-width:200px" >
              <q-input
              style="padding-bottom:10px;"
                rounded
                outlined
                v-model="appointment.time"

                label="Start Time"
              >
                <template v-slot:append>
                  <q-icon
                    name="access_time"
                    class="cursor-pointer"
                  >
                    <q-popup-proxy
                      transition-show="scale"
                      transition-hide="scale"
                    >
                      <q-time
                        mask="hh:mmA"
                        v-model="appointment.time"
                      />
                    </q-popup-proxy>
                  </q-icon>
                </template>
              </q-input>
              </FUZDiv>
          </FUZDiv>
      <FUZDiv :colLG="12" baseStyle="padding-bottom:10px;min-width:200px" baseClass="bg-primary">
          <FUZListSearchMini   v-model="appointment.client" routine="List^CLIENTS" type="CLIENTS" label="Client" :selectItems="{avatar:'image',label:'name',caption:['phone']}" />
      </FUZDiv>
    <FUZDiv :colLG="12" baseStyle="padding-bottom:10px;" baseClass="bg-secondary" >
          <q-input type="textarea" rounded autogrow outlined label="Notes" v-model="appointment.notes" @input="debounce(handleVueTypedComplete,1000)()" />
      </FUZDiv>
            <FUZDiv :colLG="12" baseStyle="padding-bottom:10px;padding-top:10px" v-for="service in serviceCount" :key="'service-'+service" baseClass="bg-warning">
    <q-bar :style="'background-color:var(--c-ui-01);'"  v-if="appointment.services[service-1]" @click="appointment.services.length>1?appointment.services.splice(service-1, 1):undefined">
      <q-space />
      <q-btn dense flat icon="close" />
    </q-bar>
                    <FUZDiv :colLG="12" baseStyle="padding-bottom:10px;"  v-if="appointment.services[service-1]">
          <FUZListSearchMini  v-model="appointment.services[service-1].staff"  routine="List^STAFF" type="STAFF" label="Stylist" :selectItems="{avatar:'image',label:'name'}" />
      </FUZDiv>
          <FUZListSearchMini v-model="appointment.services[service-1].service"  v-if="appointment.services[service-1]" routine="List^SERVICES" type="SERVICES" label="Service" :selectItems="{avatar:'image',label:'name'}"
          @change="appointment.services[service-1].option = getOptions(appointment.services[service-1].service)[0]
          ;appointment.services[service-1].duration = appointment.services[service-1].option.duration
          ;appointment.services[service-1].processing = appointment.services[service-1].option.processing"

          />

                     <FUZDiv :colLG="12" baseStyle="padding-bottom:10px;"  v-if="appointment.services[service-1]">
          <FUZSelect v-model="appointment.services[service-1].option" :options="getOptions(appointment.services[service-1].service)" :label="'Service Options'"
           @input="v => appointment.services[service-1].duration = v.duration"
           />
            <FUZDiv :colLG="12" baseStyle="padding-bottom:10px;"  v-if="appointment.services[service-1]">
          <q-list bordered padding class="rounded-borders" >
      <q-item
        clickable
        v-ripple
        class="flex flex-center text-center"
        @click="appointment.services[service-1].requested=!appointment.services[service-1].requested"
      >
        <q-item-section avatar>
          <q-icon :name="appointment.services[service-1].requested?'img:/redheart.png':'favorite_border'" size="lg"  />
        </q-item-section>
        <q-item-section >Requested ?</q-item-section>
      </q-item>
      </q-list>
      </FUZDiv>
          <FUZDiv :colLG="12" baseStyle="padding-bottom:10px;"  v-if="appointment.services[service-1]">
             <q-badge color="primary">
      Duration: {{appointment.services[service-1].duration}} mins
    </q-badge>
        <q-slider v-model="appointment.services[service-1].duration" :min="0" :max="1440" :label="true"/>
        </FUZDiv>
      <FUZDiv :colLG="12" baseStyle="padding-bottom:10px;"  v-if="appointment.services[service-1]">
             <q-badge color="accent">
      Processing: {{appointment.services[service-1].processing}} mins
    </q-badge>
        <q-slider v-model="appointment.services[service-1].processing" :min="0" :max="1440" :label="true"/>
        </FUZDiv>
      </FUZDiv>
       <FUZDiv :colLG="12" baseStyle="padding-bottom:10px;"  v-if="appointment.services[service-1]">
          <FUZListSearchMini :donotSelectFist="true" v-model="appointment.services[service-1].discount"  routine="List^DISCOUNTS" type="DISCOUNTS" label="Discounts" :selectItems="{label:'name'}" />
      </FUZDiv>
      </FUZDiv>

          <FUZDiv :colLG="12" baseStyle="padding-bottom:10px;">
          <q-list bordered padding class="rounded-borders bg-secondary" >
      <q-item
        clickable
        v-ripple
        class="flex flex-center text-center"
        @click="handleAddService"
      >
        <q-item-section avatar >
          <q-icon name="add" size="lg" />
        </q-item-section>
        <q-item-section >Add Service</q-item-section>
      </q-item>
      </q-list>
      </FUZDiv>

      </FUZDiv>
      <FUZDiv :colLG="8" :colMD="6" :colSM="6" baseStyle="padding-bottom:10px;padding-right:0;margin-right:0;">
          <div class="container" >
      <div class="grid invoice" style="min-width:35vw;">
       <div class="grid-body">
        <div class="invoice-title">
         <div class="row">
          <div class="bx--col-lg-12 flex flex-center">
      <q-card class="my-card flex flex-center" style="width:100%;margin:0 auto" v-if="$q.screen.gt.md">
           <q-img :src="typeof salonLogo === 'object' && salonLogo.join('')"  style="width:100%;" />
                  <FUZLottie
                            :animationData="'animations/25276-calendar-table.json'"
                            :loop="true"
                            style="width:50%;height:50%;"
                          />
      </q-card>
          </div>
         </div>
         <br>
           <div class="row">
          <div class="bx--col-lg-6">
           <FUZImg :value="appointment.client.image" :imgProps="{avatar:true,size:'100px','font-size':'52px'}" />
             <p class="text-h5">{{appointment.client.name}}</p>
             <p class="text-caption">{{appointment.client.phone}}</p>
                           <FUZDiv :colLG="12">
                            <cv-inline-notification v-if="appointment.discount" class="full-width"
                            :title="'Discount Applied:' + appointment.discount.code"
                            :sub-title="(appointment.discount.type==='off'?'$':'') + (appointment.discount.value) + (appointment.discount.type==='percent'?'% Off':' Off')"
                            :low-contrast="false">

                          </cv-inline-notification>
                            </FUZDiv>
         </div>
         <div class="bx--col-lg-6 text-right">
               <address>
                        <strong>{{appointment.location.name}}</strong>
                        <br>
                        {{appointment.location.address}}
                        <br>
                        {{appointment.location.city}}, {{appointment.location.state}} {{appointment.location.zip}}
                        <br>
                        <abbr title="Phone">Phone:</abbr> {{appointment.location.phone}}
                    </address>

              </div>
              </div>
        </div>
        <hr>
        <div class="row">
         <div class="bx--col-lg-12">
             <div class="row">
                   <div class="bx--col-lg-12">
          <span class="text-h5 text-right">{{getDateHeader}}</span>
          </div></div>
         <cv-data-table
         style="max-width:100%;overflow:auto"
  :sortable="false"
  :columns="columns2"
  :data="tableData.table"   ref="table"></cv-data-table>
         </div>
         <div class="bx--col-lg-6">
             <div class="text-left">
                <span class="text-h6">Total Duration</span>
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               <span class="text-h6">{{formatMtoH(tableData.totals.grandDuration)}}</span>
               <br>
               </div>
               </div>
           <div class="bx--col-lg-6">
             <div class="text-right">
              <span class="text-h6">Gross Total</span>
                &nbsp;
               <span class="text-h6">{{formatMoney(tableData.totals.grandPrice)}}</span>
               <br>
               <span class="text-h6">Discounts</span>
                &nbsp;
               <span class="text-h6">{{formatMoney(tableData.totals.grandDiscount)}}</span>
               <br>
               <span class="text-h6">Sub Total</span>
                &nbsp;
               <span class="text-h6">{{formatMoney(tableData.totals.grandSubTotal)}}</span>
               <br>
               <span class="text-h6">Tax ({{appointment.location.tax}}%)</span
               >&nbsp;
               <span class="text-h6">{{formatMoney(tableData.totals.grandTax)}}</span>
               <hr>
               <span class="text-h6">Total</span
               >&nbsp;
               <span class="text-h6">{{formatMoney(tableData.totals.grandTotal)}}</span>
              </div>
            {{appointment.notes? 'Appointment Notes:': ''}} <br>
            {{appointment.notes? appointment.notes: ''}}
       <!--  <vue-typed-js :key="vueTyped" v-if="appointment.notes" :strings="[appointment.notes]">
          <h4 class="typing"></h4>
      </vue-typed-js> -->
          </div>

        </div>
       </div>
      </div>
     </div>
     <!-- END INVOICE -->
          </FUZDiv>
          <FUZDialog v-if="false" />
      </FUZPage>
  </template>
  <template slot="secondary-button">Cancel</template>
  <template slot="primary-button">Book Appointment</template>
</cv-modal>
 <cv-modal
    style="z-index:2;"
  :ref="'ormodal'"
  :close-aria-label="'Close'"
  :size="'small'"
  :primary-button-disabled="false"
  @modal-shown="()=>{}"
  @modal-hidden="()=>{}"
  @modal-hide-request="()=>{}"
  @primary-click="handleBook(true)"
  @secondary-click="$refs.ormodal.hide()"
  :auto-hide-off="true">
  <template slot="label">Override ?</template>
  <template  slot="title">{{saveWarnMessage}}&nbsp;<br>Do you want to book this appointment anyway ?
  </template>
  <template slot="content">
    </template>

  <template slot="secondary-button">Cancel</template>
  <template slot="primary-button">Save anyway</template>
</cv-modal>
</div>
</template>
<script>

import FUZDiv from '../../FUZ/FUZDiv'
import FUZPage from '../../FUZ/FUZPage'
import FUZListSearchMini from '../../components/FUZListSearchMini'
import FUZSelect from '../../components/FUZSelect'
import FUZDialog from '../../components/FUZDialog'
import FUZImg from '../../components/FUZImg'
import FUZLottie from '../../FUZ/FUZLottie'
import moment from 'moment'
import { debounce } from 'lodash'
import { Dialog } from 'quasar'

export default {
  name: 'NewApptModal',
  components: {
    FUZDiv,
    FUZListSearchMini,
    FUZPage,
    FUZImg,
    FUZSelect,
    FUZLottie,
    FUZDialog
  },
  data () {
    return {
      saveWarnMessage: '',
      override: false,
      location: '',
      serviceCount: 1,
      salonLogo: '',
      requested: false,
      appointmentTime: '',
      appointmentDay: '',
      vueTyped: '',
      client: '',
      services: [],
      appointment: {
        location: '',
        time: this.moment(this.event.start).format('hh:mmA'),
        date: this.moment(this.event.start).format('MM/DD/YYYY'),
        client: '',
        services: [
          {
            service: '',
            staff: {
              id: this.event.resource.id,
              name: this.event.resource.title,
              image: this.event.resource.extendedProps.image
            },
            option: { label: '', value: '', id: 0 },
            requested: false,
            duration: 0,
            processing: 0,
            discount: ''
          }
        ],
        notes: '',
        discount: {
          type: 'percent',
          value: 20,
          code: '1234'
        }
      },
      sortable: false,
      columns2: [
        {
          label: 'Stylist',
          headingStyle: {

          },
          sortable: true
        },
        {
          label: 'Service',
          headingStyle: {
            width: '200px',
            whiteSpace: 'nowrap'
          }
        },
        {
          label: 'Duration',
          headingStyle: {

          }
        },
        {
          label: 'Processing',
          headingStyle: {

          }
        },
        {
          label: 'Price',
          headingStyle: {
            textTransform: 'uppercase',
            textAlign: 'right',
            paddingRight: '2.5rem'
          },
          dataStyle: {
            textAlign: 'right',
            paddingRight: '2.5rem'
          }
        },
        {
          label: 'Discount',
          headingStyle: {
            textTransform: 'uppercase',
            textAlign: 'right',
            paddingRight: '2.5rem'
          },
          dataStyle: {
            textAlign: 'right',
            paddingRight: '2.5rem'
          }
        },
        {
          label: 'Tax',
          headingStyle: {
            textTransform: 'uppercase',
            textAlign: 'right',
            paddingRight: '2.5rem'
          },
          dataStyle: {
            textAlign: 'right',
            paddingRight: '2.5rem'
          }
        },
        {
          label: 'Total',
          headingStyle: {
            textTransform: 'uppercase',
            textAlign: 'right',
            paddingRight: '2.5rem'
          },
          dataStyle: {
            textAlign: 'right',
            paddingRight: '2.5rem'
          }
        }
      ]
    }
  },
  props: ['event'],
  async created () {
    const data = await this.$M('getSalonLogo^BOOKING')
    this.salonLogo = data.logo
  },
  computed: {
    appointmentClean () {
      const data = {
        location: { id: this.appointment.location.id },
        date: this.appointment.date,
        time: this.appointment.time,
        discount: this.appointment.discount,
        notes: this.appointment.notes,
        client: {
          id: this.appointment.client.id
        },
        services: this.appointment.services.map(service => {
          return {
            staff: { id: service.staff.id },
            service: { id: service.service.id },
            option: service.option,
            duration: service.duration,
            processing: service.processing,
            requested: service.requested,
            discount: service.discount
          }
        }
        )

      }
      return data
    },
    tableData () {
      const out = []
      let grandTotal = 0
      let grandTax = 0
      let grandDiscount = 0
      let grandPrice = 0
      let grandSubTotal = 0
      let grandDuration = 0
      this.appointment.services.map(service => {
        const tax = (this.appointment.location && this.appointment.location.tax) || 0
        const price = service.option.price || 0
        grandPrice = grandPrice + price
        const discount = (((price - service.option.discountedPrice) + this.getDiscount(price, service.discount) + this.getDiscount(price, this.appointment.discount))) || 0
        grandDiscount = grandDiscount + discount
        let taxedAmount = (((price - discount) * tax) / 100) || 0
        if (taxedAmount < 0) {
          taxedAmount = 0
        }
        grandTax = grandTax + taxedAmount
        let totalPrice = (price - discount + taxedAmount) || 0
        if (totalPrice < 0) {
          totalPrice = 0
        }
        grandTotal = grandTotal + totalPrice
        let subTotal = (price - discount) || 0
        if (subTotal < 0) {
          subTotal = 0
        }
        grandSubTotal = grandSubTotal + subTotal
        grandDuration = grandDuration + service.duration + service.processing
        out.push([
          (service.staff.name || '') + ((service.requested ? ' <3' : '') || ''),
          (service.service.name || '') + ' - ' + (service.option.label || ''),
          this.formatMtoH(service.duration),
          this.formatMtoH(service.processing),
          this.formatMoney(price),
          this.formatMoney(discount),
          this.formatMoney(taxedAmount),
          this.formatMoney(totalPrice)
        ])
      })
      return {
        table: out,
        totals: {
          grandPrice, // [Gross Total]
          grandDiscount, // [Discounts] Total Discounts
          grandSubTotal, // [Sub Total] price - discount ( no tax )
          grandTax, // [Tax] Total Tax
          grandTotal, // [Net Total] Final Total After Tax,
          grandDuration

        }
      }
    },
    getDateHeader () {
      return this.appointment.date ? (moment(this.appointment.date, 'MM/DD/YYYY').format('dddd') + ' ' + this.appointment.date + (this.appointment.time ? ' at ' + this.appointment.time : '')) : 'New Appointment'
    }
  },
  methods: {
    getDiscount (total, discount) {
      if (!discount || !discount.value || !discount.type) {
        return 0
      } else if (discount.type === 'percent') {
        return ((total * discount.value) / 100)
      } else if (discount.type === 'off') {
        return discount.value
      } else {
        return 0
      }
    },
    debounce (fn, dur) {
      return debounce(fn, dur)
    },
    handleVueTypedComplete () {
      this.vueTyped = 'vueTyped-' + this.appointment.notes.length
    },
    validateData () {
      function validServices (services) {
        let valid = true
        services.map(service => {
          if (!service.service.id) {
            valid = false
          }
          if (!service.staff.id) {
            valid = false
          }
          if (!service.option.id) {
            valid = false
          }
          if (service.duration <= 0) {
            valid = false
          }
        })
        return valid
      }
      if (!this.appointment.location) {
        return {
          status: false,
          error: 'Location is required!'
        }
      } else if (!this.appointment.date) {
        return {
          status: false,
          error: 'Date is required!'
        }
      } else if (!this.appointment.time) {
        return {
          status: false,
          error: 'Time is required!'
        }
      } else if (!this.appointment.client.id) {
        return {
          status: false,
          error: 'Client is required!'
        }
      } else if (!validServices(this.appointment.services)) {
        return {
          status: false,
          error: 'Valid service details are required!'
        }
      }
      return true
    },
    async handleBook (override) {
      this.saveWarnMessage = ''
      this.override = !!override || false
      const status = this.validateData()
      if (status.status === false) {
        this.error(status.error)
        return
      }
      const bookStatus = await this.$M('bookAppointment^BOOKING', {
        appointment: this.appointmentClean,
        table: this.tableData.totals,
        override: this.override,
        id: ''
      })
      if (bookStatus.status === 'warn') {
        this.saveWarnMessage = bookStatus.message
        this.$refs.ormodal.show()
      } else if (bookStatus.status === 'error') {
        this.error(bookStatus.message)
      } else if (bookStatus.status === 'booked') {
        this.$q.notify({
          message: 'Appointment Booked',
          color: 'positive'
        })
        this.$refs.ormodal.hide()
        this.$refs.modal.hide()
        this.$emit('apptBooked')
      } else {
        this.error(bookStatus.status)
      }
    },
    error (message) {
      Dialog.create({
        component: FUZDialog,
        ok: false,
        cancel: false,
        iconPath: 'Warning',
        iconWidth: 150,
        iconHeight: 150,
        message,
        buttons: {
          ok: true
        }
      }).onOk(() => {
      }).onCancel(() => {
      }).onDismiss(() => {
      })
    },
    moment (v) {
      return moment(v)
    },
    formatMtoH (v) {
      return Math.floor(v / 60) + ' hrs ' + v % 60 + ' mins'
    },
    formatMoney (v) {
      return new Intl.NumberFormat('en-US',
        { style: 'currency', currency: 'USD' }
      ).format(v)
    },
    handleAddService () {
      this.appointment.services.push({
        service: '',
        staff: {
          id: this.event.resource.id,
          name: this.event.resource.title,
          image: this.event.resource.extendedProps.image
        },
        option: { label: '', value: '', id: 0 },
        requested: false,
        duration: 0,
        processing: 0,
        discount: ''
      })
      this.$nextTick(() => {
        this.serviceCount = this.serviceCount + 1
      })
    },
    getOptions (v) {
      if (!v) {
        return []
      } else {
        const out = []
        for (let i = 1; i <= v.serviceOptions; i++) {
          const val = {
            label: v['serviceOption' + i + 'name'],
            value: v['serviceOption' + i + 'name'],
            duration: v['serviceOption' + i + 'Duration'],
            price: v['serviceOption' + i + 'Price'],
            discountedPrice: v['serviceOption' + i + 'DiscountedPrice'],
            processing: v['serviceOption' + i + 'Processing'],
            id: i
          }
          out.push(val)
        }
        return out
      }
    },
    show () {
      this.$refs.modal.show()
    },
    hide () {
      this.$refs.modal.hide()
    }

  }
}
/*
this.selectedStaff = e.resource.title
        this.bookingStaff = e.resource.title
        this.selectedDay = data.data.date
        this.selectedTimeStart = data.data.start
        this.selectedTimeEnd = data.data.end
*/
</script>
<style>
.cv-data-table-row-inner.cv-data-table-row{
  white-space:nowrap !important;
}
.bx--modal-content {
    padding:5px !important;
    margin:0px !important;
}

.invoice {
    padding: 30px;
    width:100% !important;
}

.invoice h2 {
  margin-top: 0px;
  line-height: 0.8em;
}

.invoice .small {
  font-weight: 300;
}

.invoice hr {
  margin-top: 10px;

}

.invoice .table tr.line {

}

.invoice .table td {
  border: none;
}

.invoice .identity {
  margin-top: 10px;
  font-size: 1.1em;
  font-weight: 300;
}

.invoice .identity strong {
  font-weight: 600;
}

.grid {
    position: relative;
  width: 100%;
  border-radius: 2px;
  margin-bottom: 25px;
  box-shadow: 0px 1px 4px rgba(0, 0, 0, 0.1);
}
</style>
