<template>
  <div class="q-gutter-md" style="padding:10px">
    <div class="flex">
      <span class="text-h5">{{ labelDate }}</span>
      <q-space />
      <div class="row">
        <FUZDateWeekly v-model="date" />
      </div>
    </div>
    <q-markup-table :separator="'cell'" flat bordered>
      <thead>
        <tr>
          <th class="text-center" style="width:150px;">Staff</th>
          <th
            class="text-center"
            style="width:100px;"
            v-for="(day, dindex) in weekDays"
            :key="dindex"
          >
            {{ day }}
          </th>
        </tr>
      </thead>
      <tbody>
        <!-- <draggable v-model="staffOrder" @end="dragStaffEnd"> -->
        <tr v-for="(staff, index) in list" :key="index">
          <td
            :class="' ' + 'text-center'"
            style="width:100px;"
          >
            <span class="text-body">
                <!--
              <q-avatar size="lg" :color="staff.color" >
                <img
                  :src="
                    typeof staff.image === 'object'
                      ? staff.image.join('')
                      : staff.image
                  "
                />
              </q-avatar>
              -->

              <div
                :class="'bg-' + staff.color + ' ' + ' text-black'"
                :style="'font-size:14px;border-radius: 25px;'"
              >
                {{ staff.name }}</div
              >
            </span>
          </td>

          <td
            v-for="n in 7"
            :key="'day' + n"
            style="width:150px"
            @click="handleStaffShiftDialog(staff, n - 1)"
            :class="
              'text-center ' +
                ($q.dark.isActive
                  ? 'bg-black staffTimeTable-dark'
                  : 'bg-white staffTimeTable-light')
            "
            :staff="
              staff['d' + (n - 1)] &&
              staff['d' + (n - 1)][0] &&
              staff['d' + (n - 1)][0].startReadable
                ? 'Edit ' + staff.name + '\'s Shift'
                : '+ ' + staff.name
            "
          >
            <div v-if="staff['d' + (n - 1)]">
              <div
                v-for="(shift, sindex) in staff['d' + (n - 1)]"
                :key="'day' + n + sindex"
              >
                <div
                :class="'text-center'"
                  :style="'border-radius: 225px;'+($q.dark.isActive?'background-color:white;color:black':'background-color:black;color:white')"
                >
                  {{ shift.startReadable + " - " + shift.endReadable }}
                </div>
              </div>
            </div>
            <div v-else class="text-grey">{{ staff.name }}</div>
          </td>
        </tr>
        <!-- </draggable> -->
      </tbody>
    </q-markup-table>
    <q-dialog v-model="addShiftDialog">
      <q-card
        :style="
          $q.platform.is.mobile
            ? 'width:400px;height:300px;'
            : 'width:600px;height:300px;'
        "
      >
        <q-bar>
          <center>
            <span class="text-body1">{{ currentShift }}</span>
          </center>
          <q-space />
          <q-btn dense flat icon="close" v-close-popup>
            <q-tooltip content-class="bg-white text-primary">Close</q-tooltip>
          </q-btn>
        </q-bar>
        <div class="q-gutter-sm" style="padding:10px"></div>

        <div class="q-pa-md">
          <div class="q-gutter-sm row flex-center">
            <q-btn
              icon="access_time"
              :label="'Start: ' + shiftStart"
              rounded
              outlined11
            >
              <q-popup-proxy transition-show="scale" transition-hide="scale">
                <q-time v-model="shiftStart" mask="hh:mmA">
                  <div class="row items-center justify-end q-gutter-sm">
                    <q-btn label="OK" flat rounded outlined v-close-popup />
                  </div>
                </q-time>
              </q-popup-proxy> </q-btn
            >&nbsp;&nbsp;&nbsp;
            <q-btn
              icon="access_time"
              :label="'End:    ' + shiftEnd"
              rounded
              outlined
            >
              <q-popup-proxy transition-show="scale" transition-hide="scale">
                <q-time v-model="shiftEnd" mask="hh:mmA">
                  <div class="row items-center justify-end q-gutter-sm">
                    <q-btn label="OK" flat rounded outlined v-close-popup />
                  </div>
                </q-time>
              </q-popup-proxy>
            </q-btn>
          </div>
          <br v-if="addSecondShift" />
          <div class="q-gutter-sm row flex-center" v-if="addSecondShift">
            <q-btn
              icon="access_time"
              :label="'Start: ' + shift2Start"
              rounded
              outlined
            >
              <q-popup-proxy transition-show="scale" transition-hide="scale">
                <q-time v-model="shift2Start" mask="hh:mmA">
                  <div class="row items-center justify-end q-gutter-sm">
                    <q-btn label="OK" flat v-close-popup rounded outlined />
                  </div>
                </q-time>
              </q-popup-proxy> </q-btn
            >&nbsp;&nbsp;&nbsp;
            <q-btn
              icon="access_time"
              :label="'End:    ' + shift2End"
              rounded
              outlined
            >
              <q-popup-proxy transition-show="scale" transition-hide="scale">
                <q-time v-model="shift2End" mask="hh:mmA">
                  <div class="row items-center justify-end q-gutter-sm">
                    <q-btn label="OK" flat rounded outlined v-close-popup />
                  </div>
                </q-time>
              </q-popup-proxy>
            </q-btn>
          </div>

          <br v-if="!addSecondShift" />

          <div class="q-gutter-sm row flex-center">
            <div class="q-gutter-sm">
              <q-radio v-model="repeats" :val="true" label="Repeats Weekly" />
              <q-radio v-model="repeats" :val="false" label="Does Not Repeat" />
            </div>
          </div>
          <br />
          <div class="q-gutter-sm row flex-center">
            <q-btn
              v-show="false"
              icon="add"
              :label="'Add 2nd Shift'"
              @click="addSecondShift = true"
              rounded
              outlined
            />
            <q-btn rounded outlined @click="saveStaffShift">Save</q-btn><br />
            <q-btn rounded outlined @click="saveStaffShift(true)"
              >Remove Shift</q-btn
            >
          </div>
        </div>
      </q-card>
    </q-dialog>
  </div>
</template>

<script>
import FUZDateWeekly from '../components/FUZDateWeekly'
import { date } from 'quasar'
export default {
  name: 'StaffHours',
  data () {
    return {
      list: [],
      searchText: '',
      debouncedMounted: '',
      date: '',
      addShiftDialog: false,
      currentShift: '',
      shiftEnd: '',
      shiftStart: '',
      shift2Start: '',
      shift2End: '',
      repeats: false,
      addSecondShift: false,
      staffToadd: '',
      daysFromStart: '',
      staffOrder: [],
      currentStaff: {},
      staffDetailsDialog: false,
      currentStaffColor: '',
      staffCommission: 0
    }
  },
  components: {
    FUZDateWeekly
  },
  async mounted () {
    await this.handleMounted()
  },
  watch: {
    async date () {
      await this.handleMounted()
    }
  },
  computed: {
    labelDate () {
      const startingDate = new Date(this.date)
      const endingDate = date.addToDate(new Date(this.date), { days: 6 })
      return (
        date.formatDate(startingDate, 'MMM DD') +
        ' - ' +
        date.formatDate(endingDate, 'MMM DD')
      )
    },
    colorOptions () {
      return [
        { color: 'FUZ-light-pink', label: 'Light Pink' },
        { color: 'FUZ-light-purple', label: 'Light Purple' },
        { color: 'FUZ-light-violet', label: 'Light Violet' },
        { color: 'FUZ-light-blue', label: 'Light Blue' },
        { color: 'FUZ-green-blue', label: 'Light Green Blue' },
        { color: 'FUZ-green', label: 'Green' },
        { color: 'FUZ-light-green', label: 'Light Green' },
        { color: 'FUZ-light-yellow', label: 'Light Yellow' },
        { color: 'FUZ-yellow', label: 'Yellow' },
        { color: 'FUZ-orange', label: 'Orange' },
        { color: 'red-4', label: 'Red' },
        { color: 'pink-4', label: 'Pink' },
        { color: 'purple-4', label: 'Purple' },
        { color: 'deep-purple-4', label: 'Deep Purple' },
        { color: 'indigo-4', label: 'Indigo' },
        { color: 'blue-4', label: 'Blue' },
        { color: 'light-blue-4', label: 'Light-Blue' },
        { color: 'cyan-4', label: 'Cyan' },
        { color: 'teal-4', label: 'Teal' },
        { color: 'green-4', label: 'Green' },
        { color: 'light-green-4', label: 'Light Green' },
        { color: 'lime-4', label: 'Lime' },
        { color: 'yellow-4', label: 'Yellow' },
        { color: 'amber-4', label: 'Amber' },
        { color: 'orange-4', label: 'Orange' },
        { color: 'deep-orange-4', label: 'Deep Orange' },
        { color: 'brown-4', label: 'Brown' }
      ]
    },
    weekDays () {
      const startingDate = new Date(this.date)
      let i
      const days = []
      for (i = 0; i < 7; i++) {
        days.push(
          date.formatDate(
            date.addToDate(startingDate, { days: i }),
            'dddd MMMM DD'
          )
        )
      }
      return days
    },
    dateUtil () {
      return date
    }
  },
  methods: {
    async handleStaffDetails (staff) {
      this.$set(this.$data, 'currentStaff', staff)
      const cColor = this.colorOptions.filter(color => {
        return color.color === staff.color
      })
      this.staffCommission = this.list.filter(
        lstaff => lstaff.id === staff.id
      )[0].comm
      this.$set(this.$data, 'currentStaffColor', {
        color: staff.color,
        label: cColor[0] && cColor[0].label
      })
      this.staffDetailsDialog = true
    },
    async saveStaffShift (REMOVE) {
      if (this.shiftStart === '' || this.shiftEnd === '') {
        this.$q.dialog({
          title: 'Error',
          message: 'Please Set Shift Starttime and Endtime'
        })
        return
      }
      const data = await this.$M('setShiftDetails^STAFF', {
        shiftStart: this.shiftStart,
        shiftEnd: this.shiftEnd,
        shift2Start: this.shift2Start,
        shift2End: this.shift2End,
        staff: this.staffToadd,
        repeats: this.repeats,
        day: this.daysFromStart,
        date: this.date,
        remove: REMOVE
      })
      if (data && data.data && data.data.failStatus) {
        this.$q.dialog({
          title: 'Error',
          message: data.data.failStatus
        })
        return
      }
      await this.handleMounted()
      this.addShiftDialog = false
    },
    async handleMounted () {
      const data = await this.$M('getStaff^STAFF', {
        startingDate: this.date
      })
      if (data && data.data && data.data.list) {
        this.list = data.data.list
        this.staffOrder = data.data.list.map(staff => staff.id)
      }
    },
    async handleStaffShiftDialog (staff, days) {
      this.staffToadd = staff.id
      this.daysFromStart = days
      this.addSecondShift = false
      this.repeats = false
      this.currentShift =
        staff.name +
        '-' +
        date.formatDate(date.addToDate(this.date, { days }), 'dddd MMM DD')
      this.shiftStart = ''
      this.shiftEnd = ''
      this.shift2Start = ''
      this.shift2End = ''
      if (
        staff['d' + days] &&
        staff['d' + days][0] &&
        staff['d' + days][0].startReadable
      ) {
        this.shiftStart = staff['d' + days][0].startReadable
      }
      if (
        staff['d' + days] &&
        staff['d' + days][0] &&
        staff['d' + days][0].endReadable
      ) {
        this.shiftEnd = staff['d' + days][0].endReadable
      }
      if (
        staff['d' + days] &&
        staff['d' + days][1] &&
        staff['d' + days][1].startReadable
      ) {
        this.shift2Start = staff['d' + days][1].startReadable
        this.addSecondShift = true
      }
      if (
        staff['d' + days] &&
        staff['d' + days][1] &&
        staff['d' + days][1].endReadable
      ) {
        this.shift2End = staff['d' + days][1].endReadable
      }
      this.addShiftDialog = true
    }
  }
}
</script>
<style scoped>
td.staffTimeTable-dark:hover:after,
td.staffTimeTable-dark:active {
  content: attr(staff) !important;
  cursor: pointer;
  padding: 4px 8px;
  color: #000000;
  white-space: nowrap;
  z-index: 20px;
  -moz-border-radius: 5px;
  -webkit-border-radius: 5px;
  border-radius: 5px;
  -moz-box-shadow: 0px 0px 4px #ffffff;
  -webkit-box-shadow: 0px 0px 4px #ffffff;
  overflow: hidden;
  box-shadow: 0px 0px 4px #ffffff;
  background-color: #ffffff;
border-radius: 25px;
  overflow: hidden;
  text-align: center;
  transition: height 0.4s ease-in-out;
  -webkit-transition: height 0.4s ease-in-out;
  -moz-transition: height 0.4s ease-in-out;
}

td.staffTimeTable-light:hover:after,
td.staffTimeTable-light:active {
  content: attr(staff) !important;
  cursor: pointer;
  padding: 4px 8px;
  color: #ffffff;
  white-space: nowrap;
  z-index: 20px;
  -moz-border-radius: 5px;
  -webkit-border-radius: 5px;
  border-radius: 5px;
  -moz-box-shadow: 0px 0px 4px #000000;
  -webkit-box-shadow: 0px 0px 4px #000000;
  overflow: hidden;
  box-shadow: 0px 0px 4px #000000;
  background-color: #000000;
  border-radius: 25px;

  overflow: hidden;
  text-align: center;
  transition: height 0.4s ease-in-out;
  -webkit-transition: height 0.4s ease-in-out;
  -moz-transition: height 0.4s ease-in-out;
}
</style>
