<template>
<cv-time-picker
  ref="modelInput"
  :time="time"
  :ampm="ampm"
 v-bind="props.props"
   v-mask="'##:##'"
   :style="getStyle"
   @update:time="updateTimeModel"
   @update:ampm="updateAmModel"
   @blur="$v.model.$touch"
   :type="inputType"
  :label="label"
  :value="value"
  :disabled="disabled"
  :pattern="'(1[012]|[1-9]):[0-5][0-9](\s)?(?i)'"
  :placeholder="'hh:mm'"
  :ampm-select-label="'AM/PM'"
  :form-item="true">
  <template v-if="$v.model.$error" slot="invalid-message">{{invalidText?invalidText:validationMsg($v.model)}}</template>
  </cv-time-picker>
</template>
<script>
import FUZInputMixin from '../FUZInputMixin'

export default {
  name: 'FUZTimeInput',
  props: ['props', 'value'],
  mixins: [FUZInputMixin],
  mounted () {
  },
  data () {
    return {
      time: this.value.indexOf(' ') > -1 ? this.value.split(' ')[0] : '',
      ampm: this.value.indexOf(' ') > -1 ? this.value.split(' ')[1] : ''
    }
  },
  computed: {
    dateTime () {
      return this.time + ' ' + this.ampm
    }
  },
  methods: {
    updateTimeModel (val) {
      this.time = val
    },
    updateAmModel (val) {
      this.ampm = val
    }
  },
  watch: {
    dateTime (v) {
      if (v.trim() === '') {
        this.model = ''
      } else {
        this.model = v
      }
      this.$nextTick(() => {
        this.$v.model.$touch()
        this.$emit('input', v)
        this.$emit('change', v)
      })
    }
  }
}
</script>
