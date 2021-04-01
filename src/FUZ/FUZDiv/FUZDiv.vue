<template>
    <div :style="'background-color:var(--c-ui-01);'+getStyle" :class="getClass">
        <slot></slot>
    </div>
</template>
<script>
import FUZMixin from '../FUZMixin'
export default {
  mixins: [FUZMixin],
  name: 'FUZDiv',
  methods: {
    defaultProps () {
      return {
        baseStyle: '',
        baseClass: ''
      }
    }
  }

}
</script>
