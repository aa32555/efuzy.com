<template>
<cv-date-picker
  :kind="type"
  :cal-options="calOptions"
  @change="updateModel"
  v-model="model"
     v-bind="props.props"
   v-mask="mask"
   :style="getStyle"
    @blur="$v.model.$touch"
    @click="$v.model.$touch"
    :value="value"
    :invalid-message="$v.model.$error?validationMsg($v.model):undefined"
      :placeholder="placeholder"
  :helper-text="helperText"
  :disabled="disabled">
  <template v-if="helperText&&helperText.length" slot="helper-text">{{helperText}}</template>
  <template v-if="$v.model.$error" slot="invalid-message">{{invalidText?invalidText:validationMsg($v.model)}}</template>
  </cv-date-picker>
</template>
<script>
import FUZInputMixin from '../FUZInputMixin'

export default {
  name: 'FUZDatePicker',
  props: ['props', 'value'],
  mixins: [FUZInputMixin],
  mounted () {
  },
  data () {
    return {
      type: this.props.type || 'single',
      calOptions: {
        dateFormat: 'm/d/Y'
      }
    }
  },
  methods: {
    updateModel (v) {
      this.model = v
      this.$emit('change', v)
      this.$emit('input', v)
      this.$nextTick(() => {
        this.$v.model.$touch()
      })
    }
  },
  computed: {
  }
}
</script>
