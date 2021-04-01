<template>
     <div class="flex flex-center">
    <div :class="'row flex flex-center'" :stylex="'margin-top:25px;'">
      <!--
   <q-bar dense :class="!$q.dark.isActive?'bg-white text-black col ':'bg-black text-white col'"
  :style="$q.dark.isActive?'background: #121212;width:100vw;;height:40px':'width:100vw;;height:40px'"
    >-->

           <q-btn
           v-for="(btn,index) in breadcrumps"
           :key="'barIcon-'+index"
          :size="$q.screen.gt.xs?'18px':'14px'"
           @click="clickButton(btn)"
           :class="$store.getters['app/salonBreadCrumps']===btn.name?'text-primary':''"
           flat
           :dense="$q.screen.name === 'xs'"
           rounded
           :icon="btn.icon"
           :labelx="$q.platform.is.mobile?btn.label:btn.label"
           />

     <!-- </q-bar>
    <div :class="'row flex flex-center'" :stylex="'margin-top:25px;'">
     <q-bar dense :class="!$q.dark.isActive?'bg-white text-black col ':'bg-black text-white col'" v-if="$store.getters['app/salonBreadCrumpsChildren'] && $store.getters['app/salonBreadCrumpsChildren'].length"
  :style="$q.dark.isActive?'background: #121212;width:100vw;height:40px':'width:100vw;height:40px'"
    >
      <div class="col text-center text-weight-bold" v-show="true || !$store.state.app.ajaxLoading">
           <q-btn
           v-for="(btn,index) in $store.getters['app/salonBreadCrumpsChildren']"
           :key="'barChildIcon-'+index"
           size="14px"
           @click="clickChildButton(btn)"
           :class="$store.getters['app/salonChildBreadCrumps']===btn.name?'':''"
           :outline="$store.getters['app/salonChildBreadCrumps']===btn.name"
           :flat="$store.getters['app/salonChildBreadCrumps']!==btn.name"
           rounded
           :icon="btn.icon"
           :label="$q.platform.is.mobile?btn.label:btn.label"
           />
      </div>
 </q-bar>
    </div> -->
    </div>
    </div>
</template>
<script>
export default {
  props: ['breadcrumps'],
  data () {
    return {
      bar: [

      ],
      childBar: [

      ]
    }
  },
  methods: {
    clickButton (btn) {
      this.$store.dispatch('app/setSalonBreadCrumps', btn.name)
      this.$store.dispatch('app/setSalonBreadCrumpsChildren', btn.children)
      // console.log(this.$route.path, btn.path)
      if (this.$route.path !== btn.path) {
        this.$store.dispatch('app/changeRoute', btn.path)
      } else {
        this.$store.dispatch('app/updateRouterKey')
      }
    }

  },
  mounted () {
  //  this.bar = this.breadcrumps
  /*
      [
        {
          icon: 'person',
          name: 'profile',
          label: 'Profile',
          path: '/profile/view'
        },
        {
          icon: 'calendar_today',
          name: 'calendar',
          label: 'Calendar',
          path: '/calendar'
        },
        {
          icon: 'dashboard',
          name: 'dashboard',
          label: 'Dashboard',
          path: '/dashboard'
        },
        {
          icon: 'sync',
          name: 'sync',
          label: 'Sync',
          path: '/sync'
        },
        {
          icon: 'person',
          name: 'clients',
          label: 'Clients',
          path: '/clients/list'
        },
        {
          icon: 'textsms',
          name: 'feedback',
          label: 'Feedback',
          path: '/feedback'
        },
        {
          icon: 'book',
          name: 'activity',
          label: 'Activity',
          path: '/activity'
        },
        {
          icon: 'outlined_flag',
          name: 'retention',
          label: 'Retention',
          path: '/retention'
        },
        {
          icon: 'list',
          name: 'reports',
          label: 'Reports',
          path: '/reports'
        },
        {
          icon: 'build',
          name: 'settings',
          label: 'Settings',
          path: '/settings'
        }
      ]
      */
  }
}
</script>
