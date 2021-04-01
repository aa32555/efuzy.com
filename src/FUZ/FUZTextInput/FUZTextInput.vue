<template>
   <cv-text-input
   ref="modelInput"
   v-mask="mask"
   :style="getStyle"
   :class="getClass"
   @input="emitInput"
   @change="emitChange"
   @blur="$v.model.$touch"
   :type="inputType"
   v-model="model"
  :label="label"
  :value="value"
  :disabled="disabled"
  :placeholder="placeholder"
  :helper-text="helperText"
  :invalid-message="$v.model.$error?validationMsg($v.model):undefined"
  >
  <template v-if="helperText&&helperText.length" slot="helper-text">{{helperText}}</template>
  <template v-if="$v.model.$error" slot="invalid-message">{{invalidText?invalidText:validationMsg($v.model)}}</template>
</cv-text-input>
</template>
<script>
import FUZInputMixin from '../FUZInputMixin/'
import FUZMixin from '../FUZMixin'

export default {
  name: 'FUZTextInput',
  props: {
    value: {
      default: '',
      type: String
    },
    inputType: {
      default: 'text',
      type: String
    }
  },
  mixins: [FUZMixin, FUZInputMixin],
  mounted () {
  },
  data () {
    return {
      model: ''
    }
  },
  methods: {
    defaultProps () {
      return {
        label: 'label',
        disabled: false,
        placeholder: 'Placeholder',
        helperText: 'helperText',
        invalidText: '',
        required: true,
        min: 0,
        max: 0,
        styleXS: '',
        styleMD: '',
        styleLG: '',
        styleXL: '',
        baseStyle: '',
        mask: '####-###',
        props: {}
      }
    }
  },
  computed: {
  }
}
</script>
