<template>
                <div :style="getStyle" :class="'bx--grid bx--grid--full-width bx--row '+ getClass" >
                    <slot></slot>
            </div>
</template>
<script>
import FUZMixin from '../FUZMixin'
export default {
  name: 'FUZPage',
  mixins: [FUZMixin],
  methods: {
    defaultProps () {
      return {
      }
    }
  }
}

</script>
