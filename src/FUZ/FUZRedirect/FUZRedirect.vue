<template>
  <FUZPage>
      {{JSON.stringify($route)}}
  </FUZPage>
</template>
<script>
import FUZPage from '../FUZPage'

export default {
  name: 'ComponentsPage',
  components: {
    FUZPage
  },
  data () {
    return {
    }
  },
  created () {
  },
  mounted () {
  },
  methods: {
  }
}
</script>
