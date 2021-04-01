<template>
  <q-layout dark>
      <q-header elevated id="appHeader" dense
      revealX
      :class="'body print-hide'"
       :style="'background-color:var(--c-toolbar-bg);height:46px;font-color:var(--c-toolbar-color)'"
      >
       <q-toolbar v-if="$q.screen.lt.lg" :style="'background-color:var(--c-toolbar-bg);font-color:var(--c-toolbar-color)'">
         <q-btn flat @click="drawerRight = !drawerRight" round dense icon="menu" />
          <q-toolbar-title>efuhair</q-toolbar-title>
<q-space />
  <q-btn
          push
          flat
          round
          dense
          :icon="notifications && notifications.length > 0?'notifications_active':'notifications_paused'"
          @click="notificationDialog = true"
        >
          <q-badge
            color="red"
            align="bottom"
            v-if="notifications && notifications.length"
          >{{notifications.length}}</q-badge>
        </q-btn>
        <transition name="fade">
        <q-btn-group rounded flat>
    <q-btn-dropdown auto-close icon="person">
        <q-list padding style="width: 250px">
                    <q-item clickable  @click="toggleDark" >
            <q-item-section avatar>
             <q-avatar :icon="$q.dark.isActive ? 'nights_stay' : 'wb_sunny'" />
            </q-item-section>
            <q-item-section>
              <q-item-label>Toggle Night Mode</q-item-label>
            </q-item-section>
          </q-item>
          <q-item clickable  @click="gotoSite" v-if="['STYLIST','SALON','SALONSTYLIST'].includes($store.getters['app/accountType'])">
            <q-item-section avatar>
             <q-avatar icon="persons" />
            </q-item-section>
            <q-item-section>
              <q-item-label>View Profile</q-item-label>
            </q-item-section>
          </q-item>
          <q-item clickable  @click="$store.dispatch('app/changeRoute','/profile/edit')"  v-if="['STYLIST','SALON','SALONSTYLIST'].includes($store.getters['app/accountType'])">
            <q-item-section avatar>
              <q-avatar icon="edit" />
            </q-item-section>
            <q-item-section>
              <q-item-label>Edit Profile</q-item-label>
            </q-item-section>
          </q-item>
           <q-item clickable @click="$store.dispatch('app/logOut',true)">
            <q-item-section avatar>
              <q-avatar icon="cancel" />
            </q-item-section>
            <q-item-section>
              <q-item-label>Log Out</q-item-label>
              <q-item-label caption></q-item-label>
            </q-item-section>
            <q-item-section side>
              <q-icon name="info" color="warning" />
            </q-item-section>
          </q-item>
        </q-list>
      </q-btn-dropdown>
    </q-btn-group>
    </transition>
        </q-toolbar>
      <FUZHeader   v-if="$q.screen.gt.md" id="appToolbar" v-bind="$store.state.app.app && $store.state.app.app.header" :label="'efuhair'">
         <q-btn
          push
          flat
          round
          dense
          :icon="notifications && notifications.length > 0?'notifications_active':'notifications_paused'"
          @click="notificationDialog = true"
        >
          <q-badge
            color="red"
            align="bottom"
            v-if="notifications && notifications.length"
          >{{notifications.length}}</q-badge>
        </q-btn>
        <transition name="fade">
        <q-btn-group rounded flat>
    <q-btn-dropdown auto-close icon="person">
        <q-list padding style="width: 250px">
                    <q-item clickable  @click="toggleDark" >
            <q-item-section avatar>
             <q-avatar :icon="$q.dark.isActive ? 'nights_stay' : 'wb_sunny'" />
            </q-item-section>
            <q-item-section>
              <q-item-label>Toggle Night Mode</q-item-label>
            </q-item-section>
          </q-item>
          <q-item clickable  @click="gotoSite" v-if="['STYLIST','SALON','SALONSTYLIST'].includes($store.getters['app/accountType'])">
            <q-item-section avatar>
             <q-avatar icon="persons" />
            </q-item-section>
            <q-item-section>
              <q-item-label>View Profile</q-item-label>
            </q-item-section>
          </q-item>
          <q-item clickable  @click="$store.dispatch('app/changeRoute','/profile/edit')"  v-if="['STYLIST','SALON','SALONSTYLIST'].includes($store.getters['app/accountType'])">
            <q-item-section avatar>
              <q-avatar icon="edit" />
            </q-item-section>
            <q-item-section>
              <q-item-label>Edit Profile</q-item-label>
            </q-item-section>
          </q-item>
           <q-item clickable @click="$store.dispatch('app/logOut',true)">
            <q-item-section avatar>
              <q-avatar icon="cancel" />
            </q-item-section>
            <q-item-section>
              <q-item-label>Log Out</q-item-label>
              <q-item-label caption></q-item-label>
            </q-item-section>
            <q-item-section side>
              <q-icon name="info" color="warning" />
            </q-item-section>
          </q-item>
        </q-list>
      </q-btn-dropdown>
    </q-btn-group>
    </transition>
    </FUZHeader>
      </q-header>
<q-drawer
        v-if="$q.screen.lt.lg"
        v-model="drawerRight"
        :width="200"
        :breakpoint="700"
        behavior="mobile"
      >
      <div v-for="(header,index) in $store.state.app.app && $store.state.app.app.header && $store.state.app.app.header.mainNav" :key="index+'-header'">
       <q-item clickable v-ripple v-if="!header.children" :to="header.to" style="border:0px;">
        <q-item-section>
          <q-item-label>{{header.label}}</q-item-label>
        </q-item-section>
      </q-item>
  <q-expansion-item v-else
  style="border:0px;"
        expand-separator
        :label="header.label"
      >
        <q-card>
          <q-card-section>
             <q-list>
      <q-item clickable v-ripple v-for="(subheader,subindex) in header.children" :key="index+'-header-subheader-'+subindex" :to="subheader.to">
        <q-item-section>{{subheader.label}}</q-item-section>
      </q-item>
    </q-list>
          </q-card-section>
        </q-card>
      </q-expansion-item>
    </div>
      </q-drawer>
    <q-page-container :style="'height:100vh;padding-top:46px;background-image:linear-gradient(#48c6ef,#6f86d6);background-image:url(bg-'+($q.screen.gt.sm?'d':'m')+'.webp);background-size: cover;'">
            <router-view :key="$store.state.app.routerKey"></router-view>
          <!--
          <keep-alive>
            <router-view></router-view>
          </keep-alive>
          -->
    </q-page-container>
    <q-dialog
      v-model="notificationDialog"
      :position="'top'"
      class="full-width"
      v-if="notifications.length > 0"
    >
      <q-card>
        <q-card-section class="row items-center no-wrap">
          <q-list bordered>
            <q-item
              v-for="(notification,nindex) in notifications"
              :key="'nindex'+nindex"
              class="q-my-sm"
              v-ripple
              clickable
              :to="notification.data.data.split('#')[1]"
            >
              <q-item-section avatar>
                <q-avatar
                  color="primary"
                  text-color="white"
                >{{ notification.data.title[0] }}</q-avatar>
              </q-item-section>
              <q-item-section>
                <q-item-label lines="1">{{ notification.data.title }}</q-item-label>
                <q-item-label
                  caption
                  lines="3"
                >{{ notification.data.body }}</q-item-label>
              </q-item-section>
            </q-item>
          </q-list>
        </q-card-section>
        <q-card-section>
          <div class="text-center">
            <q-btn
              v-if="notifications.length > 0"
              label="Clear Notifications"
              color="primary"
              flat
              @click="notifications = [];notificationDialog=false"
              class="q-ml-sm"
            />
          </div>
        </q-card-section>
      </q-card>
    </q-dialog>
  </q-layout>
</template>
<script>

import { Dark } from 'quasar'
import imgBlack from './logo-black.png'
import imgWhite from './logo-white.png'
import FUZHeader from '../FUZ/FUZHeader'
export default {
  name: 'MainLayout',

  components: {
    FUZHeader
  },
  computed: {
    FUZDialog () {
      return this.$store.state.app.FUZDialog
    },
    logo () {
      return this.$q.dark.isActive ? imgWhite : imgBlack
    },
    ajaxLoading () {
      return this.$store.state.app.ajaxLoading
    },
    dark () {
      return this.$q.dark.isActive
    }
  },
  async created () {
    Dark.set(true)
    this.$q.dark.set(true)
    /*
    const OneSignal = window.OneSignal || []
    OneSignal.push(['init', {
      appId: 'b9f9bf97-5895-45a7-8145-d5de17c8e964',
      safari_web_id: 'web.onesignal.auto.5bb9a1c9-03c0-4629-b099-1bc8c9',
      notificationClickHandlerAction: 'focus',
      notificationClickHandlerMatch: 'exact',
      autoResubscribe: true,
      webhooks: {
        cors: false, // Defaults to false if omitted
        'notification.displayed': this.$store.state.app.session.url + '/notificationClicked?action=displayed', // e.g. https://site.com/hook
        'notification.clicked': this.$store.state.app.session.url + '/notificationClicked?action=clicked',
        'notification.dismissed': this.$store.state.app.session.url + '/notificationClicked?action=dismissed'
      },
      promptOptions: {
        actionMessage: 'Allow notifications?'
      }
    }])
    OneSignal.push(async () => {
      OneSignal.on('subscriptionChange', async (isSubscribed) => {
        OneSignal.setEmail(this.$store.getters['app/email'])
        OneSignal.getUserId(async (userId) => {
          await this.$M('saveUserNotificationID^FCM', {
            email: this.$store.getters['app/email'],
            id: userId
          })
        })
      })
    })
    OneSignal.push(() => {
      OneSignal.on('notificationDisplay', (event) => {
        console.warn('OneSignal notification displayed:', event)
        this.notifications.push({
          data: {
            title: event.heading,
            body: event.content,
            data: ('#' + event.url)
          }
        })
      })
    })
    OneSignal.push(function () {
      OneSignal.showSlidedownPrompt()
    })
    // OneSignal.push(['addListenerForNotificationOpened', async (data) => {
    //   await this.$M('userClickedNotificationID^FCM', { data })
    // }])
    */
  },
  data () {
    return {
      layoutComponent: 'div',
      notificationDialog: false,
      notifications: [],
      drawerRight: false,
      leftDrawerOpen: false,
      FUZDialogValue: false,
      ajaxLoadingState: false,
      ajaxLoadingToolbarState: true,
      headerData: {
        baseStyle: '',
        leftSideNavStyle: '',
        to: '',
        label: 'efuzy',
        raiseEvent: 'USER_CLICKED_APP_LOGOUT',
        eventData: {
          user: 'aa@efuzy.com'
        },
        // href: '/',
        mainNav: [{
          label: 'Form Components',
          children: [{
            label: 'FUZTextAreaInput',
            raiseEvent: 'USER_SELECTED_DEMO_COMPONENT',
            eventData: {
              component: 'FUZTextAreaInput'
            }
          },
          {
            label: 'FUZTextInput',
            raiseEvent: 'USER_SELECTED_DEMO_COMPONENT',
            eventData: {
              component: 'FUZTextInput'
            }
          },
          {
            label: 'FUZPasswordInput',
            raiseEvent: 'USER_SELECTED_DEMO_COMPONENT',
            eventData: {
              component: 'FUZPasswordInput'
            }
          }]
        },
        {
          label: 'Layout Components',
          children: [{
            label: 'FUZHeader',
            raiseEvent: 'USER_SELECTED_DEMO_COMPONENT',
            eventData: {
              component: 'FUZHeader'
            }
          },
          {
            label: 'FUZDiv',
            raiseEvent: 'USER_SELECTED_DEMO_COMPONENT',
            eventData: {
              component: 'FUZDiv'
            }
          },
          {
            label: 'FUZPageSticky',
            raiseEvent: 'USER_SELECTED_DEMO_COMPONENT',
            eventData: {
              component: 'FUZPageSticky'
            }
          }
          ]
        },
        {
          label: 'Mixins',
          children: [{
            label: 'FUZMixin',
            raiseEvent: 'USER_SELECTED_DEMO_COMPONENT',
            eventData: {
              component: 'FUZMixin'
            }
          }]
        }
        ]
      }
    }
  },
  beforeDestroy () {

  },
  methods: {
    gotoSite () {
      window.location = 'https://127.0.0.1:7001/site/' + this.$store.state.app.session.account
    },
    notify (title, body) {
      this.$q.notify({
        message: `<strong>${title}</strong><br/><em>${body}</em>`,
        html: true
      })
    },
    async waitFor (ms) {
      return !!await this.sleep(ms)
    },
    sleep (ms) {
      return new Promise(resolve => setTimeout(resolve, ms))
    },
    toggleDark () {
      Dark.toggle()
      this.$q.localStorage.set('dark-mode', Dark.isActive)
    },
    changeThemeColor (v) {
      // const metaThemeColor = document.querySelector('meta[name=theme-color]')
      // metaThemeColor.setAttribute('content', v)
    }
  },

  mounted () {
    Dark.set(true)
    this.changeThemeColor('#121212')
  },
  watch: {
    dark (v) {
      if (v) {
        this.changeThemeColor('#121212')
      } else {
        this.changeThemeColor('#eceff1')
      }
    },
    $route (to, from) {
      this.$store.dispatch('app/updateRouterKey')
    },
    async ajaxLoading (v) {
      if (v) {
        this.$nextTick(() => {
          this.ajaxLoadingState = v
        })
      } else {
        await this.sleep(1000)
        this.$nextTick(() => {
          this.ajaxLoadingState = v
        })
      }
    }
  }
}
</script>
<style lang="sass">
.ms-logo
  img
    transform: rotate(0deg)
    transition: transform .8s ease-in-out
  &:hover img
    transform: rotate(-360deg)

</style>
