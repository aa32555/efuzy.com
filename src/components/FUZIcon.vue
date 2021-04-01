<template>
    <lottie :options="defaultOptions" :height="this.height" :width="this.width" v-on:animCreated="handleAnimation"/>
</template>

<script>
import Lottie from './lottie'

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

export default {
  name: 'app',
  props: ['height', 'width', 'path', 'loop'],
  components: {
    lottie: Lottie
  },
  mounted () {

  },
  data () {
    return {
      defaultOptions: { animationData: icons[this.path], loop: !!this.loop },
      animationSpeed: 0.5
    }
  },
  methods: {
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
