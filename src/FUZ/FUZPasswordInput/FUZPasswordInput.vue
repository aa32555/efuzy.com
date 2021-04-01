<template>
   <cv-text-input
   ref="modelInput"
   v-mask="mask"
   :style="getStyle"
   :class="getClass"
   @input="emitInput"
   @change="emitChange"
   @blur="$v.model.$touch"
   :type="'password'"
   v-model="model"
  :label="label"
  :value="value"
  :disabled="disabled"
  :placeholder="placeholder"
  :helper-text="helperText"
  :invalid-message="$v.model.$error?validationMsg($v.model):undefined"
  :password-visible="false"
  :password-hide-label="'Hide Password'"
  :password-show-label="'Show Password'"
  >
  <template v-if="helperText&&helperText.length" slot="helper-text">{{helperText}}</template>
  <template v-if="$v.model.$error" slot="invalid-message">{{invalidText?invalidText:validationMsg($v.model)}}</template>
</cv-text-input>
</template>
<script>
import FUZInputMixin from '../FUZInputMixin/'
import FUZMixin from '../FUZMixin'

export default {
  name: 'FUZPasswordInput',
  props: {
    value: {
      default: '',
      type: String
    }
  },
  data () {
    return {
      model: ''
    }
  },
  mixins: [FUZMixin, FUZInputMixin],
  mounted () {
  },
  methods: {
    defalutProps () {
      return {
        label: 'Password',
        invalidText: 'Invalid Pssword',
        baseStyle: '',
        required: true,
        styleXS: '',
        styleMD: '',
        styleLG: '',
        styleXL: ''
      }
    }
  }
}
</script>
