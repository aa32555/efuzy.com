<template>
<cv-multi-select
    ref="modelInput"
   :style="getStyle"
   :class="getClass"
   @change="$v.model.$touch();$emit('update',model)"
   @input="$v.model.$touch();$emit('update',model)"
  v-model="model"
  :title="label"
  :disabled="disabled"
  :placeholder="placeholder"
  :helper-text="helperText"
  :inline="false"
  :invalid-message="invalidMessage"
  :selection-feedback="'top-after-reopen'"
  :filterable="false"
  :filter="false"
  :auto-filter="false"
  :auto-highlight="true"
  :options="options"
  v-bind="$props"
  >
  <template v-if="helperText&&helperText.length" slot="helper-text">{{helperText}}</template>
  <template v-if="$v.model.$error" slot="invalid-message">{{invalidText?invalidText:validationMsg($v.model)}}</template>
</cv-multi-select>
</template>
<script>
import FUZInputMixin from '../FUZInputMixin'
import FUZMixin from '../FUZMixin'

export default {
  name: 'FUZMultiselectInput',
  props: ['options', 'value'],
  mixins: [FUZMixin, FUZInputMixin],
  data () {
    return {
      model: this.value
    }
  },
  mounted () {
  },
  methods: {
  }
}
</script>
