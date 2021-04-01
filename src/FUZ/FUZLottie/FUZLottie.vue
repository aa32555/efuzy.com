<template>
    <lottie :options="$props" v-on:animCreated="handleAnimation" v-bind="$props" :style="getStyle" :class="getClass"/>
</template>

<script>
import Lottie from './lottie'

/*
const Alert = require('./assets/alert.json')
const Warning = require('./assets/warning.json')
const CheckMark = require('./assets/checkmark-ok.json')
const AddToList = require('./assets/add-to-collection.json')
const WhiteScissors = require('./assets/scissors-w.json')
const RunningAnt = require('./assets/running-ant.json')
const Syncing = require('./assets/syncing.json')
const NoData = require('./assets/no-data.json')
const LoadingScissors = require('./assets/loading-scissors.json')
const List = require('./assets/list.json')
const SiriLoading = require('./assets/siri-loading.json')
const icons = {
  Alert,
  Warning,
  CheckMark,
  AddToList,
  WhiteScissors,
  RunningAnt,
  Syncing,
  NoData,
  LoadingScissors,
  List,
  SiriLoading
}
*/
import FUZMixin from '../FUZMixin'
export default {
  name: 'FUZLottie',
  mixins: [FUZMixin],
  props: {
    animationData: {
      required: true
    },
    loop: {
      type: Boolean,
      default: true
    },
    animationSpeed: {
      type: Number,
      default: 0.5
    },
    height: Number,
    width: Number
  },
  components: {
    lottie: Lottie
  },
  methods: {
    defaultProps () {
      return {
        animationData: {},
        loop: true,
        animationSpeed: 0.5
      }
    },
    handleAnimation: function (anim) {
      this.anim = anim
    },

    stop: function () {
      this.anim.stop()
    },

    play: function () {
      this.anim.play()
    },

    pause: function () {
      this.anim.pause()
    },

    onSpeedChange: function () {
      this.anim.setSpeed(this.animationSpeed)
    }
  }
}
</script>
