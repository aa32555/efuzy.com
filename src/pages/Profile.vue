<template>
<q-page class="">
    <div :class="'flex flex-center '" v-if="$route.params.tab === 'edit'">
      <div :class="'row flex flex-center'" >
        <FUZNew  type="STYLISTS" :id="$store.getters['app/account']" :style="'width:80vw;min-width:380px;'">
          <template v-slot:skeleton >
             <div class="flex flex-center q-pa-md row" style="margin-top:30px">
               <div class="col-6 offset-xs-9" style="width:35vw;max-width:800px;min-width:350px" >
          <q-skeleton :type="'circle'" class="col" size="100px" />
          </div>
          </div>
          <div class="row q-pa-md">
          <q-skeleton :type="'QInput'" class="col" style="width:35vw;max-width:800px;min-width:350px" />
          </div>
          <div class="row q-pa-md" v-for="i in 10" :key="'askeleton'+i">
          <q-skeleton :type="'QInput'" class="col" style="width:35vw;max-width:800px;min-width:350px" />
          </div>
          <div class="row q-pa-md" v-for="i in 10" :key="'bskeleton'+i">
          <q-skeleton :type="'QInput'" class="col" style="width:70vw;"/>
          </div>
          </template>
        </FUZNew>
        </div>
    </div>
       <div :class="' flex flex-center col'" v-if="$route.params.tab && $route.params.tab !== 'edit'">
        <MSProfile :id="$store.getters['app/account']" />
    </div>
</q-page>

</template>
<script>
import FUZNew from '../components/FUZNew'
import MSProfile from '../components/MSProfile'

export default {
  data () {
    return {
      selectedTab: 'profile'
    }
  },
  components: {
    FUZNew,
    MSProfile
  },
  async mounted () {
  }
}
</script>
