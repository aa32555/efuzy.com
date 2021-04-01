<template>
         <q-page-sticky  :position="position" :offset="offset" :style="getStyle()" :class="getClass()">
                 <q-btn  :round="round" :push="push" :glossy="glossy" :size="size" >
                     <q-avatar :size="size"  :color="color">
                         <FUZLottie :v-bind="$props" />
                     </q-avatar>
                 </q-btn>
          </q-page-sticky>
</template>
<script>
import FUZMixin from '../FUZMixin'
import FUZLottie from '../FUZLottie'

export default {
  name: 'FUZPageSticky',
  mixins: [FUZMixin],
  props: {
    animationData: {
      type: Object
    },
    loop: {
      type: Boolean,
      default: true
    },
    animationSpeed: {
      type: Number,
      default: 0.5
    },
    offset: Array,
    position: String,
    size: {
      type: String,
      default: ''
    },
    color: {
      type: String,
      default: ''
    },
    round: {
      type: Boolean,
      default: false
    },
    push: {
      type: Boolean,
      default: false
    },
    glossy: {
      type: Boolean,
      default: false
    }
  },
  components: {
    FUZLottie
  },
  methods: {
    defaultProps () {
      return {
        size: '2rem',
        color: 'dark',
        position: 'top-right',
        offset: [5, 50],
        animationData: {}
      }
    }
  }
}
</script>
