<template>
  <div>
    <transition name="fade">
      <q-card
        :class="'my-card '+'bg-'+color"
        v-if="showCard"
      >
        <q-card-section>
<!--
          <img
            v-if="false"
            src="statics/new.png"
            alt="new"
            width="15"
            height="15"
            align="right"
            title="New Client"
            style="padding:1px;"
          >

          <img
            v-if="color=='ns'"
            src="statics/ns.png"
            alt="new"
            width="30"
            height="30"
            align="right"
            title="New Client"
            style="padding:1px;"
          >
          <img
            v-if="requestedIcon"
            src="statics/rh.png"
            ar="requested"
            width="30"
            height="30"
            align="right"
            style="padding:1px;"
          >
          <img
            v-if="notesIcon"
            src="statics/notes.png"
            alt="notes"
            width="30"
            height="30"
            align="right"
            style="padding:1px;"
          >
          <img
            v-if="onlineBookingIcon"
            src="statics/online.png"
            alt="online-booking"
            width="30"
            height="30"
            align="right"
            style="padding:1px;"
          >
          -->
          <div class="text-h6">
            <q-avatar
              color="primary"
              text-color="white"
            >{{name[0]}}</q-avatar>&nbsp;<b>{{name}}</b>
          </div>
          <div class="text-subtitle2">
            <q-chip>
              {{staff}}
            </q-chip>&nbsp;{{day}} {{date}} {{time}}
          </div>
          <div class="text-wight-bolder">{{service}}</div>
          <div class="text-subtitle2 bg-warning text-black" style="border-radius:25%">{{notes}}</div>

        </q-card-section>
        <q-card-section v-if="propPersist">
          <q-card-actions class="justify-around q-px-md">
            <q-btn
              flat
              round
              label="NoShow"
              @click="markNoshow"
            />
            <q-btn
              flat
              round
              label="Park"
              @click="$emit('park',apptID)"
            />
            <q-btn
              flat
              round
              icon="delete_forever"
              @click="handleDelete"
            />
            <q-btn
              flat
              round
              icon="edit"
              @click="$emit('edit',apptID)"
            />
            <q-btn
              flat
              round
              icon="cancel"
              @click="$emit('dismiss',true)"
            />
          </q-card-actions>
        </q-card-section>
      </q-card>
    </transition>
  </div>
</template>
<script>

export default {
  name: 'appointment-card',
  props: ['apptID', 'persist', 'currentEvent'],
  data () {
    return {
      showCard: false,
      name: '',
      booked: '',
      service: '',
      time: '',
      date: '',
      color: '',
      staff: '',
      day: '',
      propPersist: false,
      onlineBookingIcon: false,
      requestedIcon: false,
      notesIcon: false,
      notes: ''
    }
  },
  watch: {
    persist (v) {
      this.propPersist = v
    }
  },
  methods: {
    async markNoshow () {
      this.$q.dialog({
        title: 'Confirm',
        message: 'Are you sure you want to mark this appointment as a No Show ?',
        ok: {
          push: true
        },
        cancel: {
          push: true,
          color: 'negative'
        },
        persistent: true
      }).onOk(async () => {
        const data = await this.$M('markNoShowAppt^SALON', { apptID: this.apptID })
        const { status } = data.data
        if (status === 'Marked!') {
          this.$q.notify({
            message: status,
            color: 'green'
          })
          this.$emit('dismiss', true)
          this.$emit('refetchEvents', true)
        } else {
          this.$q.notify({
            message: status,
            color: 'negative'
          })
        }
      })
    },
    async handleDelete () {
      this.$q.dialog({
        title: 'Confirm',
        message: 'Are you sure you want to delete this appointment ?',
        ok: {
          push: true
        },
        cancel: {
          push: true,
          color: 'negative'
        },
        persistent: true
      }).onOk(async () => {
        const data2 = await this.$M('deleteAppt^SALON', { apptID: this.apptID, single: false })
        const { status } = data2.data
        if (status === 'Deleted!') {
          this.$q.notify({
            message: status,
            color: 'green'
          })
          this.$emit('dismiss', true)
          this.$emit('refetchEvents', true)
        } else {
          this.$q.notify({
            message: status,
            color: 'red'
          })
        }
      })
    }
  },
  async mounted () {
    this.propPersist = this.persist
    // let data = await this.$M('getAppt^AR', { apptID: this.apptID })
    //  let { name, booked, service, time, date, color, staff, day, status, onlineBookingIcon, requestedIcon, notesIcon, notes } = data.data
    if (status === false) {
      this.$emit('dismiss')
    }
    this.name = this.currentEvent.extendedProps.name
    this.booked = this.currentEvent.extendedProps.booked
    this.service = this.currentEvent.extendedProps.service
    this.time = this.currentEvent.extendedProps.time
    this.date = this.currentEvent.extendedProps.date
    this.color = this.currentEvent.extendedProps.color
    this.staff = this.currentEvent.extendedProps.staff
    this.day = this.currentEvent.extendedProps.day
    this.onlineBookingIcon = this.currentEvent.extendedProps.onlineBookingIcon
    this.requestedIcon = this.currentEvent.extendedProps.requestedIcon
    this.notesIcon = this.currentEvent.extendedProps.notesIcon
    this.notes = this.currentEvent.extendedProps.notes
    this.showCard = true
  }
}
</script>
<style lang='scss'>
.my-card {
  width: 100%;
  max-width: 600px;
}
.bg-FUZ-light-grey {
  background-color: #bebebe !important;
  border-color: #bebebe !important;
}
.bg-FUZ-light-pink {
  background-color: #ff9cbb !important;
  border-color: #ff9cbb !important;
}
.bg-FUZ-light-purple {
  background-color: #e2a6e6 !important;
  border-color: #e2a6e6 !important;
}
.bg-FUZ-light-violet {
  background-color: #bbc1e8 !important;
  border-color: #bbc1e8 !important;
}
.bg-FUZ-light-blue {
  background-color: #a5dff8 !important;
  border-color: #a5dff8 !important;
}
.bg-FUZ-green-blue {
  background-color: #91e3ee !important;
  border-color: #91e3ee !important;
}
.bg-FUZ-green {
  background-color: #6cd5cb !important;
  border-color: #6cd5cb !important;
}
.bg-FUZ-light-green {
  background-color: #a6e5bd !important;
  border-color: #a6e5bd !important;
}
.bg-FUZ-light-yellow {
  background-color: #e7f286 !important;
  border-color: #e7f286 !important;
}
.bg-FUZ-yellow {
  background-color: #ffec78 !important;
  border-color: #ffec78 !important;
}
.bg-FUZ-orange {
  background-color: #ffbf69 !important;
  border-color: #ffbf69 !important;
}
.fc-today {
  background: #ffffff !important;
}
.bg-ns {
  background-color: #0011ff !important;
  border-color: #0011ff !important;
}
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.5s;
}
.fade-enter, .fade-leave-to /* .fade-leave-active below version 2.1.8 */ {
  opacity: 0;
}
</style>
