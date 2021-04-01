<template>
  <div v-bind="props">{{props.label}}</div>
</template>

<script>
export default {
  name: 'FUZHeader',
  data () {
    return {
    }
  },
  props: ['props'],
  components: {
  }
}
</script>
