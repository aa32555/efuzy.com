<template>
     <FUZPage v-bind="{baseStyle:'padding-left:60px;padding-right:0px;margin:0px;'}">
       <FUZHeader v-bind="headerData" />
   <q-splitter
      v-model="splitterModel"
      style="height: 100vh;width:calc(100vw - 60px);background-color:var(--c-ui-background);"
    >
      <template v-slot:before>
       <FUZDiv v-bind="{
      baseStyle:'margin:0px;padding:0px;height:100%;padding-top:52px;width:100%;'
      }" ref="codeEditor">
      <FUZCodeEditorInput v-model="dynamicProps" @input="handlecodeInput"  />
    </FUZDiv>
      </template>
      <template v-slot:after>
      <FUZDiv v-bind="{
       baseStyle:'margin:0px;padding:0px;height:100%;padding-top:52px;width:100%;'
    }" ref="component_container" >
      <component :is="currentComponent" v-bind="props" :ref="currentComponent" :key="key"/>
    </FUZDiv>
      </template>
    </q-splitter>
  </FUZPage>
</template>
<script>
import FUZHeader from '../../FUZ/FUZHeader/'
import FUZPage from '../../FUZ/FUZPage'
import FUZTextAreaInput from '../../FUZ/FUZTextAreaInput'
import FUZTextInput from '../../FUZ/FUZTextInput'
import FUZPasswordInput from '../../FUZ/FUZPasswordInput'
import FUZDiv from '../../FUZ/FUZDiv'
import FUZMixin from '../../FUZ/FUZMixin'
import FUZIcon from '../../FUZ/FUZIcon'
import FUZPageSticky from '../../FUZ/FUZPageSticky'
import FUZCodeEditorInput from '../../FUZ/FUZCodeEditorInput'
import {
  FlashingScreen
} from '../../FUZ/FUZAnimations'

export default {
  // our hook here
  preFetch ({ store, currentRoute, previousRoute, redirect, ssrContext, urlPath, publicPath }) {
    if (ssrContext) {
      return store.dispatch('app/setSSR', true)
    }
    return store.dispatch('app/setSSR', false)
  },

  name: 'ComponentsPage',
  mixins: [FUZMixin],
  components: {
    FUZHeader,
    FUZPage,
    FUZTextAreaInput,
    FUZDiv,
    FUZIcon,
    FUZCodeEditorInput,
    FUZMixin,
    FUZPageSticky,
    FUZTextInput,
    FUZPasswordInput
  },
  data () {
    return {
      dynamicProps: '',
      currentComponent: 'FUZDiv',
      key: this.newUID(),
      FlashingScreen,
      showAnimation: true,
      splitterModel: 50,
      props: {},
      headerData: {
        baseStyle: 'margin-left:60px;',
        leftSideNavStyle: 'width:60px;background-color:var(--c-ui-background);',
        href: '',
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
        ],
        sideNav: [{
          label: 'Components',
          href: '/components', // either this or children
          icon: '',
          children: [{
            label: 'FUZHeader',
            href: '/components/FUZHeader',
            icon: '',
            raiseEvent: '/components/FUZHeader3'
          }]
        }],
        actionNav: [{
          label: 'Signout',
          raiseEvent: 'userSignout',
          icon: 'notification'
        }]
      }
    }
  },
  created () {
    if (this.$store.getters['app/isSSR']) {
      this.showAnimation = false
    }
  },
  mounted () {
    this.$q.dark.set(true)
    /*
    this.mounted = true
    this.$nextTick(() => {
      this.setComponent({
        component: 'FUZDiv'
      })
    })
    */
  },
  methods: {
    events () {
      return [{
        event: 'USER_SELECTED_DEMO_COMPONENT',
        handler: this.setComponent
      },
      {
        event: 'USER_SELECTED_DEMO_COMPONENT',
        handler: this.logEvent('USER_SELECTED_DEMO_COMPONENT')
      },
      {
        event: 'USER_CLICKED_APP_LOGOUT',
        handler: this.logEvent('USER_CLICKED_APP_LOGOUT')
      }
      ]
    },
    setComponent (component) {
      this.currentComponent = component.component
      this.$nextTick(() => {
        const data = this.$refs[this.currentComponent].defaultProps() || {}
        const props = this._merge(data, this.$refs[this.currentComponent].$props)
        this.dynamicProps = JSON.stringify(props, null, 4)
        this.$nextTick(() => {
          this.$set(this.$data, 'props', props)
          this.key = this.newUID()
        })
      })
    },
    handlecodeInput (val) {
      try {
        const sVal = Object.freeze(JSON.parse(val))
        this.$set(this.$data, 'props', sVal)
        this.$nextTick(() => {
          this.key = this.newUID()
        })
      } catch (e) {}
    }
  }
}
</script>
