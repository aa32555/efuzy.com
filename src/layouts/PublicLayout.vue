<template>
<component :is="layoutComponent" dark>
  <q-page-container class="flex flex-center" style="height:100%;min-height:100vh;background-image:url(imgs/bg1.jpg);background-size: cover;">
  <FUZPage style="height:100%;width:100%" class="flex flex-center">
    <FUZDiv :colLG="4" style="background-color:inherit" v-if="$q.screen.gt.md">
  <div class="q-pa-md" >
    <q-list dark padding>
      <q-item>
        <q-item-section class="q-ml-none" >
            <q-skeleton :type="'QToolbar'" style="width:100%;height:150px;margin:0 auto" v-if="!mounted"/>
          <img :src="logo.join('')" style="width:100%;height:auto;margin:0 auto" v-if="mounted">
        </q-item-section>
      </q-item>
           <q-item clickable v-ripple :to="'/onlinebooking/'+$route.params.sitename">
        <q-item-section v-if="mounted" class="text-center text-h3 menu-font">Book Online</q-item-section>
        <q-skeleton :type="'QToolbar'" style="width:50%;margin:0 auto" v-if="!mounted"/>
      </q-item>
                <q-item clickable v-ripple>
        <q-item-section v-if="mounted" class="text-center text-h5 menu-font">Stylists</q-item-section>
        <q-skeleton :type="'QToolbar'" style="width:50%;margin:0 auto" v-if="!mounted"/>
      </q-item>
       <q-item clickable v-ripple>
        <q-item-section v-if="mounted" class="text-center text-h5 menu-font">Reviews</q-item-section>
        <q-skeleton :type="'QToolbar'" style="width:50%;margin:0 auto" v-if="!mounted"/>
      </q-item>
      <q-item clickable v-ripple>
        <q-item-section v-if="mounted" class="text-center text-h5 menu-font">Art Work</q-item-section>
        <q-skeleton :type="'QToolbar'" style="width:50%;margin:0 auto" v-if="!mounted"/>
      </q-item>
               <q-item clickable v-ripple>
        <q-item-section v-if="mounted" class="text-center text-h5 menu-font">Careers</q-item-section>
        <q-skeleton :type="'QToolbar'" style="width:50%;;margin:0 auto" v-if="!mounted"/>
      </q-item>
                     <q-item clickable v-ripple>
        <q-item-section v-if="mounted" class="text-center text-h5 menu-font">Contact Us</q-item-section>
        <q-skeleton :type="'QToolbar'" style="width:50%;margin:0 auto" v-if="!mounted"/>
      </q-item>
    </q-list>
  </div>
    </FUZDiv>
    <FUZDiv :colLG="$q.screen.gt.md?8:12" style="background-color:inherit;padding:0;margin:0">
      <router-view keep-alive></router-view>
    </FUZDiv>
  </FUZPage>
</q-page-container>
</component>
</template>
<script>

import FUZPage from '../FUZ/FUZPage'
import FUZDiv from '../FUZ/FUZDiv'
import axios from 'axios'

export default {
  name: 'PublicLayout',
  components: {
    FUZPage,
    FUZDiv
  },
  data () {
    return {
      url: '',
      logo: [],
      status: '',
      mounted: false,
      layoutComponent: 'div'
    }
  },
  async mounted () {
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
    this.$nextTick(() => {
      this.mounted = true
    })
   this.$q.dark.set(true)
      this.$nextTick(() => {
        this.layoutComponent = 'q-layout'
      })
  }
}
</script>
<style scoped>
@font-face {
  font-family: "Arizonia";
  src: url("../css/Arizonia-Regular.ttf")
}

.menu-font{
  font: 400 50px/1.3 'Arizonia', Helvetica, sans-serif;
  text-shadow: 4px 4px 0px rgba(0,0,0,0.1);
}
</style>
