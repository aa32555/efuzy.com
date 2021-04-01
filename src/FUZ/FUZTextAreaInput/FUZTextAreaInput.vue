<template>
   <cv-text-area
   ref="modelInput"
   v-bind="$props"
   :style="getStyle"
   :class="getClass"
   @input="emitInput"
   @blur="$v.model.$touch"
   :type="'textarea'"
  :dbField="dbField"
  v-model="model"
  :label="label"
  :value="value"
  :disabled="disabled"
  :placeholder="placeholder"
  :helper-text="helperText"
  :rows="rows"
  :invalid-message="$v.model.$error?validationMsg($v.model):undefined">
  <template v-if="helperText&&helperText.length" slot="helper-text">{{helperText}}</template>
  <template v-if="$v.model.$error" slot="invalid-message">{{invalidText?invalidText:validationMsg($v.model)}}</template>
</cv-text-area>
</template>
<script>
import FUZInputMixin from '../FUZInputMixin/'

export default {
  name: 'FUZTextAreaInput',
  mixins: [FUZInputMixin],
  props: {
    value: {
      default: '',
      type: String
    },
    minCharacters: {
      default: 0,
      type: Number
    },
    maxCharacters: {
      default: 9999999,
      type: Number
    },
    rows: {
      default: 15,
      type: Number
    }
  },
  data () {
    return {
      model: ''
    }
  },
  methods: {
    defaultProps () {
      return {
        minCharacters: 0,
        maxCharacters: 999999,
        rows: 15
      }
    }
  }
}
</script>
