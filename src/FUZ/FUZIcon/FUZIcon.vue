<template>
     <q-btn :round="round" :push="push" :glossy="glossy" :size="size" :color="color" >
         <q-avatar v-if="avatar">
           <FUZLottie :props="$props" :style="getStyle()" :class="getClass()" />
         </q-avatar>
         <FUZLottie :props="$props"  v-else />
     </q-btn>
</template>
<script>
import FUZMixin from '../FUZMixin'
import FUZLottie from '../FUZLottie'

export default {
  name: 'FUZIcon',
  mixins: [FUZMixin],
  props: {
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
    },
    avatar: {
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
        size: '3rem',
        color: 'dark',
        key: '',
        round: true,
        push: false,
        glossy: true
      }
    }
  }
}
</script>
