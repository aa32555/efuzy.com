<template>
  <div>Renderless component</div>
</template>
<script>
import { uid } from 'quasar'
import FUZEventBus from '../FUZEventBus'

export default {
  props: ['props'],
  name: 'FUZMixin',
  data () {
    const tag = this.$options._componentTag
    if (tag && tag !== 'FUZMixin' && this.$options.docs && typeof this.$options.docs === 'object') {
      const docs = this.$options.docs
      if (docs && docs[tag]) {
        return this._merge(docs[tag].propsData, this.props)
      } else {
        return {}
      }
    } else {
      return {}
    }
  },
  computed: {
    uid: {
      get () {
        return uid()
      },
      set (v) {
        return v
      }
    }
  },
  methods: {
    emit (event, data) {
      FUZEventBus.$emit(event, data)
    },
    logEvent (eventName) {
      return (data) => {
        console.log('event  => ', eventName, '\n', 'data =>', data, '\n\n')
      }
    },
    newUID: uid,
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
      const classCordova = (this.classCordova && this.$q.Platform.is.cordova ? (this.classCordova + ' ') : '') || ''
      const classCapacitor = (this.classCapacitor && this.$q.Platform.is.capacitor ? (this.classCapacitor + ' ') : '') || ''
      const classElectron = (this.classElectron && this.$q.Platform.is.electron ? (this.classElectron + ' ') : '') || ''
      const classDesktop = (this.classDesktop && this.$q.Platform.is.desktop ? (this.classDesktop + ' ') : '') || ''
      const classBex = (this.classBex && this.$q.Platform.is.bex ? (this.classBex + ' ') : '') || ''
      const classAndroid = (this.classAndroid && this.$q.Platform.is.android ? (this.classAndroid + ' ') : '') || ''
      const classBlackberry = (this.classBlackberry && this.$q.Platform.is.blackberry ? (this.classBlackberry + ' ') : '') || ''
      const classCros = (this.classCros && this.$q.Platform.is.cros ? (this.classCros + ' ') : '') || ''
      const classIos = (this.classIos && this.$q.Platform.is.ios ? (this.classIos + ' ') : '') || ''
      const classIpad = (this.classIpad && this.$q.Platform.is.ipad ? (this.classIpad + ' ') : '') || ''
      const classIphone = (this.classIphone && this.$q.Platform.is.iphone ? (this.classIphone + ' ') : '') || ''
      const classIpod = (this.classIpod && this.$q.Platform.is.ipod ? (this.classIpod + ' ') : '') || ''
      const classKindle = (this.classKindle && this.$q.Platform.is.kindle ? (this.classKindle + ' ') : '') || ''
      const classLinux = (this.classLinux && this.$q.Platform.is.linux ? (this.classLinux + ' ') : '') || ''
      const classMac = (this.classMac && this.$q.Platform.is.mac ? (this.classMac + ' ') : '') || ''
      const classWin = (this.classWin && this.$q.Platform.is.win ? (this.classWin + ' ') : '') || ''
      const classWinphone = (this.classWinphone && this.$q.Platform.is.winphone ? (this.classWinphone + ' ') : '') || ''
      const classPlaybook = (this.classPlaybook && this.$q.Platform.is.playbook ? (this.classPlaybook + ' ') : '') || ''
      const classSilk = (this.classSilk && this.$q.Platform.is.silk ? (this.classSilk + ' ') : '') || ''
      const classChrome = (this.classChrome && this.$q.Platform.is.chrome ? (this.classChrome + ' ') : '') || ''
      const classOpera = (this.classOpera && this.$q.Platform.is.opera ? (this.classOpera + ' ') : '') || ''
      const classSafari = (this.classSafari && this.$q.Platform.is.safari ? (this.classSafari + ' ') : '') || ''
      const classEdge = (this.classEdge && this.$q.Platform.is.edge ? (this.classEdge + ' ') : '') || ''
      const classIe = (this.classCordova && this.$q.Platform.is.ie ? (this.classIe + ' ') : '') || ''
      const classTouch = (this.classTouch && this.$q.Platform.has.touch ? (this.classTouch + ' ') : '') || ''
      const classIframe = (this.classIframe && this.$q.Platform.within.iframe ? (this.classIframe + ' ') : '') || ''
      const colXS = (this.colXS ? ('bx--col-xs-' + this.colXS + ' ') : '') || ''
      const colSM = (this.colSM ? ('bx--col-sm-' + this.colSM + ' ') : '') || ''
      const colMD = (this.colMD ? ('bx--col-md-' + this.colMD + ' ') : '') || ''
      const colLG = (this.colLG ? ('bx--col-lg-' + this.colLG + ' ') : '') || ''
      const classOutput = baseClass + classMobile + classXL + classLG + classMD + classSM + classXS + classGTXS +
      classGTSM + classGTMD + classGTLG + classLTSM + classLTMD + classLTLG + classLTXL + classCordova + classCapacitor +
      classElectron + classDesktop + classBex + classAndroid + classBlackberry + classCros + classIos + classIpad +
      classIphone + classIpod + classCordova + classKindle + classLinux + classMac + classWin + classWinphone +
      classPlaybook + classSilk + classChrome + classSafari + classOpera + classEdge + classIe + classTouch + classIframe +
      colXS + colSM + colMD + colLG
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
      const styleCordova = (this.styleCordova && this.$q.Platform.is.cordova ? (this.styleCordova + ';') : '') || ''
      const styleCapacitor = (this.styleCapacitor && this.$q.Platform.is.capacitor ? (this.styleCapacitor + ';') : '') || ''
      const styleElectron = (this.styleElectron && this.$q.Platform.is.electron ? (this.styleElectron + ';') : '') || ''
      const styleDesktop = (this.styleDesktop && this.$q.Platform.is.desktop ? (this.styleDesktop + ';') : '') || ''
      const styleBex = (this.styleBex && this.$q.Platform.is.bex ? (this.styleBex + ';') : '') || ''
      const styleAndroid = (this.styleAndroid && this.$q.Platform.is.android ? (this.styleAndroid + ';') : '') || ''
      const styleBlackberry = (this.styleBlackberry && this.$q.Platform.is.blackberry ? (this.styleBlackberry + ';') : '') || ''
      const styleCros = (this.styleCros && this.$q.Platform.is.cros ? (this.styleCros + ';') : '') || ''
      const styleIos = (this.styleIos && this.$q.Platform.is.ios ? (this.styleIos + ';') : '') || ''
      const styleIpad = (this.styleIpad && this.$q.Platform.is.ipad ? (this.styleIpad + ';') : '') || ''
      const styleIphone = (this.styleIphone && this.$q.Platform.is.iphone ? (this.styleIphone + ';') : '') || ''
      const styleIpod = (this.styleIpod && this.$q.Platform.is.ipod ? (this.styleIpod + ';') : '') || ''
      const styleKindle = (this.styleKindle && this.$q.Platform.is.kindle ? (this.styleKindle + ';') : '') || ''
      const styleLinux = (this.styleLinux && this.$q.Platform.is.linux ? (this.styleLinux + ';') : '') || ''
      const styleMac = (this.styleMac && this.$q.Platform.is.mac ? (this.styleMac + ';') : '') || ''
      const styleWin = (this.styleWin && this.$q.Platform.is.win ? (this.styleWin + ';') : '') || ''
      const styleWinphone = (this.styleWinphone && this.$q.Platform.is.winphone ? (this.styleWinphone + ';') : '') || ''
      const stylePlaybook = (this.stylePlaybook && this.$q.Platform.is.playbook ? (this.stylePlaybook + ';') : '') || ''
      const styleSilk = (this.styleSilk && this.$q.Platform.is.silk ? (this.styleSilk + ';') : '') || ''
      const styleChrome = (this.styleChrome && this.$q.Platform.is.chrome ? (this.styleChrome + ';') : '') || ''
      const styleOpera = (this.styleOpera && this.$q.Platform.is.opera ? (this.styleOpera + ';') : '') || ''
      const styleSafari = (this.styleSafari && this.$q.Platform.is.safari ? (this.styleSafari + ';') : '') || ''
      const styleEdge = (this.styleEdge && this.$q.Platform.is.edge ? (this.styleEdge + ';') : '') || ''
      const styleIe = (this.styleCordova && this.$q.Platform.is.ie ? (this.styleIe + ';') : '') || ''
      const styleTouch = (this.styleTouch && this.$q.Platform.has.touch ? (this.styleTouch + ';') : '') || ''
      const styleIframe = (this.styleIframe && this.$q.Platform.within.iframe ? (this.styleIframe + ';') : '') || ''
      const style = baseStyle + styleMobile + styleXL + styleLG + styleMD + styleSM + styleXS + styleGTXS +
      styleGTSM + styleGTMD + styleGTLG + styleLTSM + styleLTMD + styleLTLG + styleLTXL + styleCordova + styleCapacitor +
      styleElectron + styleDesktop + styleBex + styleAndroid + styleBlackberry + styleCros + styleIos + styleIpad +
      styleIphone + styleIpod + styleCordova + styleKindle + styleLinux + styleMac + styleWin + styleWinphone +
      stylePlaybook + styleSilk + styleChrome + styleSafari + styleOpera + styleEdge + styleIe + styleTouch + styleIframe
      return style
    }
  },
  mounted () {
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
  },
  docs: {
    propsData: {
      classNAME: 'Conditionally apply class',
      styleNAME: 'Same as className',
      classNAMES: [
        { name: 'colXS', description: 'Only in xs screens' },
        { name: 'colSM', description: 'Only in sm screens' },
        { name: 'colMD', description: 'Only in md screens' },
        { name: 'colLG', description: 'Only in lg screens' },
        { name: 'classXS', description: 'Only in xs screens' },
        { name: 'classSM', description: 'Only in sm screens' },
        { name: 'classMD', description: 'Only in md screens' },
        { name: 'classLG', description: 'Only in lg screens' },
        { name: 'classXL', description: 'Only in xl screens' },
        { name: 'classLTXL', description: 'Only in less than xl screens' },
        { name: 'classLTLG', description: 'Only in less than lg screens' },
        { name: 'classLTMD', description: 'Only in less than md screens' },
        { name: 'classLTSM', description: 'Only in less than sm screens' },
        { name: 'classGTXS', description: 'Only in greater than xs screens' },
        { name: 'classGTSM', description: 'Only in greater than sm screens' },
        { name: 'classGTMD', description: 'Only in greater than md screens' },
        { name: 'classGTLG', description: 'Only in greater than lg screens' },
        { name: 'classGTXL', description: 'Only in greater than xl screens' },
        { name: 'classMobile', description: 'Is the code running on a mobile device?' },
        { name: 'classCordova', description: 'BIs the code running within Cordova?' },
        { name: 'classCapacitor', description: 'Is the code running with Capacitor? (requires @quasar/app v1.2+)' },
        { name: 'classElectron', description: 'Is the code running within Electron?' },
        { name: 'classDesktop ', description: 'Is the code running on a desktop browser?' },
        { name: 'classBex', description: 'Is the code running in a browser extension? (requires @quasar/app v1.2+)' },
        { name: 'classAndroid', description: 'Is the app running on an Android device?' },
        { name: 'classBlackberry', description: 'Is the app running on a Blackberry device?' },
        { name: 'classCros', description: 'Is the app running on device with the Chrome OS operating system?' },
        { name: 'classIos', description: 'Is the app running on an iOS device?' },
        { name: 'classIpad', description: 'Is the app running on an iPad?' },
        { name: 'classIphone', description: 'Is the app running on an iPhone?' },
        { name: 'classIpod', description: 'Is the app running on an iPod?' },
        { name: 'classKindle', description: 'Is the app running on a Kindle device?' },
        { name: 'classLinux', description: 'Is the code running on a device with the Linux operating system?' },
        { name: 'classMac', description: 'Is the code running on a device with the MacOS operating system?' },
        { name: 'classWin', description: 'Is the code running on a device with the Windows operating system?' },
        { name: 'classWinphone', description: 'Is the code running on a Windows Phone device?' },
        { name: 'classPlaybook', description: 'Is the code running on a Blackberry Playbook device?' },
        { name: 'classSilk ', description: 'Is the code running the Kindle Silk browser?' },
        { name: 'classChrome', description: 'Is the code running inside the Google Chrome browser?' },
        { name: 'classOpera', description: 'Is the code running inside the opera browser?' },
        { name: 'classSafari', description: 'Is the code running inside the Apple Safari browser?' },
        { name: 'classEdge', description: 'Is the code running inside the Microsoft Edge browser?' },
        { name: 'classIe', description: 'Is the code running inside the Microsoft Internet Explorer browser?' },
        { name: 'classTouch', description: 'Is the code running on a touch capable screen?' },
        { name: 'classIframe', description: 'Is the app running within an IFRAME' }
      ],
      methods: {
        events: [{ event: 'USER_SELECTED_DEMO_COMPONENT', handler: 'function' }],
        raiseEvent: '(eventName,eventData)=>{}',
        logEvent: '(eventName)=>console.log(eventName, eventData)',
        uid: 'function that generates a unique id',
        getStyle: 'function',
        getClass: 'function'
      }
    }
  }
}
</script>
