<template>
<cv-number-input
  ref="modelInput"
 v-bind="props.props"
   v-mask="mask"
   :style="getStyle"
   @input="updateModel('input')"
   @change="updateModel('change')"
  v-model="model"
  :label="label"
  :value="value"
  :disabled="disabled"
  :placeholder="placeholder"
  :helper-text="helperText"
  :invalid-message="$v.model.$error?validationMsg($v.model):undefined"
  :min="minCharacters"
  :max="maxCharacters"
  :step="numberStep"
  :required="required"
  :mobile="mobileView">
 <template v-if="helperText&&helperText.length" slot="helper-text">{{helperText}}</template>
  <template v-if="$v.model.$error" slot="invalid-message">{{invalidText?invalidText:validationMsg($v.model)}}</template>

</cv-number-input>

</template>
<script>
import FUZInputMixin from '../FUZInputMixin'
import FUZMixin from '../FUZMixin'

export default {
  name: 'FUZNumberInput',
  props: ['props', 'value'],
  mixins: [FUZMixin, FUZInputMixin],
  mounted () {
  },
  data () {
    return {
      mobileView: this.props.mobileView,
      numberStep: this.props.numberStep
    }
  },
  methods: {
    updateModel (val) {
      const model = ((isNaN(this.model) || !this.model) ? '' : this.model)
      this.model = model
      this.$emit(val, model)
      this.$nextTick(() => {
        this.$v.model.$touch()
      })
    }
  },
  computed: {
  }
}
</script>
