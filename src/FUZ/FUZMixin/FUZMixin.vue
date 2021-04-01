<template>
  <div>Renderless component</div>
</template>
<script>
import { uid } from 'quasar'
import FUZEventBus from '../FUZEventBus'

export default {
  name: 'FUZMixin',
  props: ['baseStyle', 'styleMobile', 'styleXL', 'styleLG', 'styleMD', 'styleSM', 'styleXS', 'styleGTXS',
    'styleGTSM', 'styleGTMD', 'styleGTLG', 'styleLTSM', 'styleLTMD', 'styleLTLG', 'styleLTXL',
    'baseClass', 'classMobile', 'classXL', 'classLG', 'classMD', 'classSM', 'classXS', 'classGTXS',
    'classGTSM', 'classGTMD', 'classGTLG', 'classLTSM', 'classLTMD', 'classLTLG', 'classLTXL', 'colXS', 'colSM', 'colMD', 'colLG'

  ],
  methods: {
    emitEvent (event) {
      this.emit(event, this)
    },
    emit (event, data) {
      FUZEventBus.$emit(event, data)
    },
    logEvent (eventName) {
      return (data) => {
        console.log('event  => ', eventName, '\n', 'data =>', data, '\n\n')
      }
    },
    newUID: uid
  },
  computed: {
    getClass () {
      const classXS = (this.classXS && this.$q.screen.name === 'xs' ? (this.classXS + ' ') : '') || ''
      const classSM = (this.classSM && this.$q.screen.name === 'sm' ? (this.classSM + ' ') : '') || ''
      const classMD = (this.classMD && this.$q.screen.name === 'md' ? (this.classMD + ' ') : '') || ''
      const classLG = (this.classLG && this.$q.screen.name === 'lg' ? (this.classLG + ' ') : '') || ''
      const classXL = (this.classXL && this.$q.screen.name === 'xl' ? (this.classXL + ' ') : '') || ''
      const classGTXS = (this.classGTXS && this.$q.screen.gt.xs ? (this.classGTXS + ' ') : '') || ''
      const classGTSM = (this.classGTSM && this.$q.screen.gt.sm ? (this.classGTSM + ' ') : '') || ''
      const classGTMD = (this.sclassGTMD && this.$q.screen.gt.md ? (this.classGTMD + ' ') : '') || ''
      const classGTLG = (this.classGTLG && this.$q.screen.gt.lg ? (this.classGTLG + ' ') : '') || ''
      const classLTSM = (this.classLTSM && this.$q.screen.lt.sm ? (this.classLTSM + ' ') : '') || ''
      const classLTMD = (this.classLTMD && this.$q.screen.lt.md ? (this.classLTMD + ' ') : '') || ''
      const classLTLG = (this.classLTLG && this.$q.screen.lt.lg ? (this.classLTLG + ' ') : '') || ''
      const classLTXL = (this.classLTXL && this.$q.screen.lt.xl ? (this.classLTXL + ' ') : '') || ''
      const baseClass = (this.baseClass ? (this.baseClass + ' ') : '') || ''
      const classMobile = (this.classMobile && this.$q.Platform.is.mobile ? (this.classMobile + ' ') : '') || ''
      const colXS = (this.colXS ? ('bx--col-xs-' + this.colXS + ' ') : '') || ''
      const colSM = (this.colSM ? ('bx--col-sm-' + this.colSM + ' ') : '') || ''
      const colMD = (this.colMD ? ('bx--col-md-' + this.colMD + ' ') : '') || ''
      const colLG = (this.colLG ? ('bx--col-lg-' + this.colLG + ' ') : '') || ''
      const classOutput = baseClass + classMobile + classXL + classLG + classMD + classSM + classXS + classGTXS +
      classGTSM + classGTMD + classGTLG + classLTSM + classLTMD + classLTLG + classLTXL + colXS + colSM + colMD + colLG
      return classOutput
    },
    getStyle () {
      const styleXS = (this.styleXS && this.$q.screen.name === 'xs' ? (this.styleXS + ';') : '') || ''
      const styleSM = (this.styleSM && this.$q.screen.name === 'sm' ? (this.styleSM + ';') : '') || ''
      const styleMD = (this.styleMD && this.$q.screen.name === 'md' ? (this.styleMD + ';') : '') || ''
      const styleLG = (this.styleLG && this.$q.screen.name === 'lg' ? (this.styleLG + ';') : '') || ''
      const styleXL = (this.styleXL && this.$q.screen.name === 'xl' ? (this.styleXL + ';') : '') || ''
      const styleGTXS = (this.styleGTXS && this.$q.screen.gt.xs ? (this.styleGTXS + ';') : '') || ''
      const styleGTSM = (this.styleGTSM && this.$q.screen.gt.sm ? (this.styleGTSM + ';') : '') || ''
      const styleGTMD = (this.sstyleGTMD && this.$q.screen.gt.md ? (this.styleGTMD + ';') : '') || ''
      const styleGTLG = (this.styleGTLG && this.$q.screen.gt.lg ? (this.styleGTLG + ';') : '') || ''
      const styleLTSM = (this.styleLTSM && this.$q.screen.lt.sm ? (this.styleLTSM + ';') : '') || ''
      const styleLTMD = (this.styleLTMD && this.$q.screen.lt.md ? (this.styleLTMD + ';') : '') || ''
      const styleLTLG = (this.styleLTLG && this.$q.screen.lt.lg ? (this.styleLTLG + ';') : '') || ''
      const styleLTXL = (this.styleLTXL && this.$q.screen.lt.xl ? (this.styleLTXL + ';') : '') || ''
      const baseStyle = (this.baseStyle) || ''
      const styleMobile = (this.styleMobile && this.$q.Platform.is.mobile ? (this.styleMobile + ';') : '') || ''
      const style = baseStyle + styleMobile + styleXL + styleLG + styleMD + styleSM + styleXS + styleGTXS +
      styleGTSM + styleGTMD + styleGTLG + styleLTSM + styleLTMD + styleLTLG + styleLTXL
      return style
    }
  },
  created () {
    const events = typeof this.events === 'function' ? this.events() : undefined
    if (events) {
      events.map((event) => {
        FUZEventBus.$on(event.event, event.handler)
      })
    }
  },
  beforeDestroy () {
    const events = typeof this.events === 'function' ? this.events() : undefined
    if (events) {
      events.map((event) => {
        FUZEventBus.$off(event.event, event.handler)
      })
    }
  }
}
</script>
