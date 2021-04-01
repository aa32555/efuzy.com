<template>
  <q-select
       :options="options"
       :label="label"
        :behavior="$q.screen.lt.md === true ? 'dialog' : 'menu'"
        rounded
        outlined
        :clearable="clearable"
        :value="value"
        @input="setSelectedValue"
        @change="setSelectedValue"
        />
</template>

<script>
export default {
  name: 'FUZSelect',
  props: ['value', 'options', 'label', 'clearable'],
  components: {
  },
  methods: {
    setSelectedValue (value) {
      this.$emit('input', value)
      this.$emit('change', value)
    }
  },
  created () {
  }
}
</script>
