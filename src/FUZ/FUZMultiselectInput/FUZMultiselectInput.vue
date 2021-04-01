<template>
<FUZMultiselectInputWrapper v-bind="$props" @update="handleUpdate"/>
</template>
<script>

import FUZMultiselectInputWrapper from './FUZMultiselectInputWrapper'

export default {
  name: 'FUZMultiselectInput',
  props: ['options', 'value'],
  components: {
    FUZMultiselectInputWrapper
  },
  mounted () {
  },
  data () {
    return {
    }
  },
  methods: {
    handleUpdate (val) {
      this.$emit('change', val)
      this.$emit('input', val)
    }
  },
  computed: {
  }
}
</script>
