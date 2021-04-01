<template>
<main id="main">
<q-layout dark>
  <q-page-container dark class="flex flex-center" :style="'height:100%;min-height:100vh;background-image:url(bg-'+($q.screen.gt.sm?'d':'m')+'.webp);background-size: cover;'">
  <FUZPage style="height:100%;width:100%" class="flex flex-center">
    <transition :name="'animated ' + transitionName" appear>
    <FUZDiv :colLG="5" style="background-color:inherit" v-if="$route.name === 'loginPublic'">
  <div class="q-pa-md" >
    <q-list dark padding>
      <q-item>
        <q-item-section class="q-ml-none" id="header">
         <img :src="'logo-'+('lg')+'.png'" alt="logo" :style="$q.screen.gt.xs?'width:100%;height:auto;margin:0 auto':'width:100vw;height:auto;padding:0;left:0;position:fixed;padding-bottom:75px;'">
            <!--
            <video autoplay muted style="height:auto;max-width:75vw">
                <source src="logo.mp4" type="video/mp4">
            </video>
            -->
        </q-item-section>
        <br><br>
      </q-item>
           <q-item clickable v-ripple :to="'/'+'login'+'/go'">
        <q-item-section v-if="isMounted" :class="'text-center text-h3 menu-font'">Login</q-item-section>
      </q-item>
                <q-item clickable v-ripple :to="'/'+'login'+'/signup'">
        <q-item-section v-if="isMounted"  :class="'text-center text-h3 menu-font'">Signup</q-item-section>
      </q-item>
    </q-list>
  </div>
    </FUZDiv>
     </transition>
    <FUZDiv :colLG="7" style="background-color:inherit;padding:0;margin:0">
      <router-view></router-view>
    </FUZDiv>
  </FUZPage>
</q-page-container>
</q-layout>
</main>
</template>
<script>
import FUZPage from '../../FUZ/FUZPage'
import FUZDiv from '../../FUZ/FUZDiv'
import axios from 'axios'
import { LocalStorage } from 'quasar'

export default {
  name: 'LoginPage',
  components: {
    FUZPage,
    FUZDiv
  },
  data () {
    return {
      url: '',
      status: '',
      isMounted: false,
      layoutComponent: 'div',
      pageComponent: 'div',
      transitionName: 'fadeInUpBig'
    }
  },
  watch: {
    '$route' (to, from) {
      const toDepth = to.path.split('/').length
      const fromDepth = from.path.split('/').length
      this.transitionName = toDepth < fromDepth ? 'fadeInUpBig' : 'fadeInOutBig'
    }
  },
  methods: {
  },
  computed: {
    logo: {
      set (v) {
        this.$store.dispatch('app/setLogo', v)
      },
      get () {
        return this.$store.getters['app/logo']
      }
    }
  },
  async mounted () {
    const jwt = LocalStorage.getItem('sessionDetails')
    const tree = LocalStorage.getItem('appDetails')
    if (jwt && tree && typeof jwt === 'object' && typeof tree === 'object') {
      this.checkingLogin = true
      this.$store.dispatch('app/setSessionDetails', jwt)
      this.$store.dispatch('app/setAppDetails', tree)
      const status = await this.$m('CheckAuth^SALON')
      if (status && status.status) {
        if (this.$route.query.redirect && this.$route.query.redirect !== '/login' && this.$route.query.redirect !== '/') {
          this.$store.dispatch('app/changeRoute', this.$route.query.redirect)
        } else {
          this.$store.dispatch('app/changeRoute', '/calendar')
        }
      } else {
        this.checkingLogin = false
      }
    } else {
      this.checkingLogin = false
    }
    this.$q.dark.set(true)
    this.$nextTick(() => {
      this.isMounted = true
      this.$nextTick(() => {
        this.layoutComponent = 'q-layout'
        this.pageComponent = 'q-page-container'
      })
    })
  },
  async created () {
    const res = await axios({
      url: 'http://127.0.0.1:7777/account-details',
      method: 'post',
      data: {
        site: this.$route.params.sitename
      }
    })
    const status = res && res.data && res.data.status
    const url = res && res.data && res.data.data && res.data.data.url
    const logo = res && res.data && res.data.data && res.data.data.logo
    this.status = status
    this.logo = logo
    this.url = url
  }
}
</script>
<style scoped>
.menu-font-md {
    font: 400 40px/1.3 'Arizonia', Helvetica, sans-serif;
    text-shadow: 4px 4px 0px rgba(0,0,0,0.77);
  }
.menu-font {
    font: 400 60px/1.3 'Arizonia', Helvetica, sans-serif;
    text-shadow: 4px 4px 0px rgba(0,0,0,0.77);
  }
</style>
