<template>
  <div>
    <q-btn
      outline
      style="width:70px;font-size:13px;height:40px;"
      @click="goToday"
      :label="'Today'"
    />
    <q-btn
      outline
      style="width:40px;font-size:13px;height:40px;"

      icon="calendar_today"
      @click="prompt=true"
    />
    <q-btn
      outline
      style="width:40px;font-size:13px;height:40px;"

      icon="skip_previous"
      @click="goBackOne"
    />
    <q-btn
      outline
      style="width:40px;font-size:13px;height:40px;"

      icon="skip_next"
      @click="goForwardOne"
    />
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

            v-model="date"
            autofocus
            :mask="'MM/DD/YYYY'"
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

          />
          <q-btn
            flat
            label="Submit"
            v-close-popup
            @click="getMondayOf"

          />
        </q-card-actions>
      </q-card>
    </q-dialog>
  </div>
</template>
<script>
import { date } from 'quasar'

export default {
  name: 'FUZDate',
  data () {
    return {
      prompt: false,
      date: this.getToday()
    }
  },
  watch: {
    date (v) {
      v = date.formatDate(this.getMondayOfCurrentWeek(new Date(v)), 'MM/DD/YYYY')
      this.date = v
      this.$emit('input', v)
    }
  },
  mounted () {
    this.$emit('input', this.date)
  },
  props: ['value'],
  computed: {
    labelDate () {
      const startingDate = new Date(this.date)
      const endingDate = date.addToDate(new Date(this.date), { days: 6 })
      return date.formatDate(startingDate, 'MMM DD') + ' - ' + date.formatDate(endingDate, 'MMM DD')
    }
  },
  methods: {
    getToday () {
      var today = new Date()
      var dd = String(today.getDate()).padStart(2, '0')
      var mm = String(today.getMonth() + 1).padStart(2, '0') // January is 0!
      var yyyy = today.getFullYear()
      today = mm + '/' + dd + '/' + yyyy
      return date.formatDate(this.getMondayOfCurrentWeek(new Date(today)), 'MM/DD/YYYY')
    },
    goBackOne () {
      this.date = date.formatDate(date.subtractFromDate(this.date, { days: 7 }), 'MM/DD/YYYY')
    },
    goForwardOne () {
      this.date = date.formatDate(date.addToDate(this.date, { days: 7 }), 'MM/DD/YYYY')
    },
    goToday () {
      this.date = this.getToday()
    },
    getMondayOfCurrentWeek (d) {
      var day = d.getDay()
      return new Date(d.getFullYear(), d.getMonth(), d.getDate() + (day === 0 ? -6 : 1) - day)
    },
    getMondayOf () {
      this.date = date.formatDate(this.getMondayOfCurrentWeek(new Date(this.date)), 'MM/DD/YYYY')
    }
  }
}
</script>
