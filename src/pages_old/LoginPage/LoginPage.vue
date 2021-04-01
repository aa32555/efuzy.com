<template>
  <div style="width:100vw;height:100vh;background-image:linear-gradient(#48c6ef,#6f86d6);">
    <div v-if="checkingLogin" :style="'width:50vw;height:50vh;margin: 0 auto'">
      <FUZLottie :path="'animations/loading1.json'" class="flex flex-center" :loop="true" />
    </div>
    <div class="bx--grid bx--grid--full-width landing-page imgfill" v-if="!checkingLogin">
      <div class="bx--row landing-page__r2">
        <div class="bx--col bx--no-gutter ">
          <q-no-ssr>
          <cv-modal id="modal" style="background-image:linear-gradient(#48c6ef,#6f86d6);" class="imgfill" :size="'small'" :close-aria-label="'login'" :visible="true" :auto-hide-off="true" ref="modal">
            <template slot="content" class="bx--grid bx--grid--no-gutter bx--grid--full-width">
                  <div v-if="!checkingLogin" :style="`width:${bodyWidth}px;min-height:200px;z-index:999999`" id="modalBody">
                    <div
                      class="bx--row flex flex-center child imgfill"
                      :style="
                        'background-image:linear-gradient(#48c6ef,6f86d6);'
                      "
                    >

                    <div class="bx--col-lg-6 bx--col-md-6 bx--col-sm-12 bx--col-xs-12" >
                          <transition
                            appear
                            enter-active-class="animated fadeInUpBig"
                            leave-active-class="animated fadeOutUpBig"
                          >
                            <FUZLottie
                            :animationData="animationData"
                            :loop="true"
                            :key="loaderKey"
                            class="login"
                            style="width:95%;height:95%;"
                          />
                          </transition>
                      </div>
                      <div class="bx--col-lg-6 bx--col-md-6 bx--col-sm-12 bx--col-xs-12">
                        <transition-group
                        appear
                        enter-active-class="animated fadeInUpBig"
                        leave-active-class="animated fadeOutUpBig"
                      >
                        <cv-form
                          :key="'signup_form'"
                          @submit.prevent="submit"
                          v-show="!signupScreen"
                          style="overflow:hidden;"
                          autocomplete='off'
                        >
                          <FUZTextInput
                          v-show="!signupScreen"
                            ref="email"
                            v-model="credentials.email"
                            v-bind="{
                              label: 'Email',
                              placeholder: 'info@efuzy.com',
                              invalidText: 'Invalid Email',
                              minCharacters: 2,
                              maxCharacters: 500,
                              required: true
                            }"
                            style="width:100%;"
                          />
                          <div style="margin-bottom:0.5rem" />
                          <FUZPasswordInput
                          v-show="!signupScreen"
                            ref="password"
                            autocomplete='current-password'
                            v-model="credentials.password"
                            v-bind="{
                              label: 'Password',
                              invalidText: 'Invalid Pssword',
                              required: true,
                              touch: false,
                            }"
                            style="width:100%;"
                          />
                          <a href="javascript:void(0)">Forgot password?</a>
                        </cv-form>
                        <cv-form
                        :key="'login_form'"
                          @submit.prevent="actionSubmit"
                          style="overflow:hidden;"
                          v-show="signupScreen"
                        >
                          <FUZTextInput
                          v-show="signupScreen"
                            v-bind="{
                              label: 'Email',
                              placeholder: 'info@efuzy.com',
                              invalidText: 'Invalid Email',
                              minCharacters: 2,
                              maxCharacters: 500,
                              required: true
                            }"
                            style="width:100%;"
                          />
                          <div style="margin-bottom:0.5rem" />
                          <FUZTextAreaInput
                          v-show="signupScreen"
                            v-bind="{
                              label: 'Password',
                              invalidText: 'Please tell us about yourself',
                              required: true,
                              row:5
                            }"
                            style="width:100%;"
                          />
                        </cv-form>
                                </transition-group>
                      </div>

                    </div>
                  </div>
</template>
<template slot="label">
   Welcome
</template>
<template slot="title">
   efuzy.com
</template>
<template slot="primary-button">
  <button v-if="!signupScreen" role="button" class="cv-button bx--btn bx--btn--primary" :style="'margin-top:16px;padding:0px;height:90%'" @click="submit">
                    <div
                      :style="`width:${buttonWidth}px;font-size:1rem`"
                      class=" text-center"
                    >
                      Login
                    </div>
                  </button>
  <button v-if="signupScreen" role="button" class="cv-button bx--btn bx--btn--primary" :style="'margin-top:16px;padding:0px;height:90%'">
                    <div
                      :style="`width:${buttonWidth}px;font-size:1rem`"
                      class="text-center"
                    >
                      Submit
                    </div>
                  </button>
</template>
<template slot="secondary-button">
  <button @click="showSignup();" v-show="!signupScreen" role="button" class="cv-button bx--btn bx--btn--secondary" :style="'margin-top:16px;padding:0px;height:90%'">
                    <div
                      :style="`width:${buttonWidth}px;font-size:1rem`"
                      class="text-center"
                    >
                      Signup
                    </div>
                  </button>
  <button v-if="signupScreen" role="button" class="cv-button bx--btn bx--btn--secondary" :style="'margin-top:16px;padding:0px;height:90%'" @click.prevent="showLogin()">
                    <div
                      :style="`width:${buttonWidth}px;font-size:1rem`"
                      class="text-center"
                    >
                      Go back
                    </div>
                  </button>
</template>

          </cv-modal>
          </q-no-ssr>
        </div>
      </div>
    </div>

  </div>
</template>
<script>
import {
  required,
  email
} from 'vuelidate/lib/validators'
import axios from 'axios'
import {
  LocalStorage,
  uid
} from 'quasar'
import FUZLottie from '../../FUZ/FUZLottie'
import FUZTextInput from '../../FUZ/FUZTextInput/FUZTextInput'
import FUZPasswordInput from '../../FUZ/FUZPasswordInput/FUZPasswordInput'
import FUZTextAreaInput from '../../FUZ/FUZTextAreaInput'
import { Login } from '../../FUZ/FUZAnimations'
import $ from 'jquery'
export default {
  data () {
    return {
      signupScreen: false,
      checkingLogin: false,
      credentials: {
        email: '',
        password: '',
        type: 'salon'
      },
      slide: 1,
      autoplay: true,
      animationData: Login,
      showLoader: true,
      loaderKey: uid(),
      buttonWidth: 0,
      bodyWidth: 0,
      resized: false,
      animations: {
        Login
      }
    }
  },
  components: {
    FUZLottie,
    FUZTextInput,
    FUZPasswordInput,
    FUZTextAreaInput
  },
  computed: {},
  async created () {
    this.$q.dark.set(true)
  },
  async mounted () {
    const jwt = LocalStorage.getItem('sessionDetails')
    const tree = LocalStorage.getItem('appDetails')
    if (jwt && tree && typeof jwt === 'object' && typeof tree === 'object') {
      this.checkingLogin = true
      this.$store.dispatch('app/setSessionDetails', jwt)
      this.$store.dispatch('app/setAppDetails', tree)
      const status = await this.$m('CheckAuth^SALON')
      if (status.status) {
        this.$store.dispatch('app/changeRoute', '/calendar')
        // this.checkingLogin = false
      } else {
        this.checkingLogin = false
        this.$nextTick(() => {
          this.$refs.email.$refs.modelInput.focus()
        })
        this.$nextTick(() => {
          this.onResize()
        })
      }
    } else {
      this.checkingLogin = false
      this.$nextTick(() => {
        this.$refs.email.$refs.modelInput.focus()
      })
      this.$nextTick(() => {
        this.onResize()
      })
      window.onresize = (event) => {
        this.onResize()
      }
    }
  },
  validations: {
    credentials: {
      email: {
        required,
        email
      },
      password: {
        required
      },
      type: {
        required
      }
    }
  },
  beforeDestroy () {
    window.removeEventListener('resize', (event) => {
      this.onResize()
    })
  },
  methods: {
    onResize () {
      setTimeout(() => {
        const modalBody = $(this.$refs.modal.$el)
          .children()
          .last()
          .children()[3]
        this.bodyWidth = $(modalBody).width() * 0.95
        this.buttonWidth = (this.bodyWidth / 2) * 0.90
      }, 100)
    },
    async showLogin () {
      this.changeLoader('animations/login.json', true)
      this.signupScreen = false
      /*
        this.$nextTick(() => {
          this.$jq('.sign_up').animate({
            opacity: 0,
            height: '0px'
          }, 0, () => {
            this.changeLoader('animations/login.json', true)
            this.$jq('.login').animate({
              opacity: 1,
              height: '100%'
            }, 0, () => { })
          })
        })
        */
    },
    async showSignup () {
      this.signupScreen = true
      this.changeLoader('animations/signup.json', true)
      /* this.$nextTick(() => {
          this.$jq('.login').animate({
            opacity: 0,
            height: '0px'
          }, 0, () => {
            this.changeLoader('animations/signup.json', true)
            this.$jq('.sign_up').animate({
              opacity: 1,
              height: '100%'
            }, 0, () => {
            })
          })
        })
        */
    },
    resetPassword () {
      if (this.$v.credentials.email.$error) {
        this.error('Invalid login!')
      }
    },
    sleep (ms) {
      return new Promise(resolve => setTimeout(resolve, ms))
    },
    changeLoader (v, dontGoBackToLogin) {
      this.showLoader = false
      this.loaderPath = v
      this.loaderKey = uid()
      this.showLoader = true
      /*
        this.$jq('.login').animate({
          opacity: 0,
          height: '0px'
        }, 1500, () => {
          this.showLoader = false
          this.loaderPath = v
          this.loaderKey = uid()
          this.$nextTick(() => {
            this.$jq('.login').animate({
              opacity: 1,
              height: '100%'
            }, 1500, () => {
              this.showLoader = false
              this.loaderPath = 'animations/login.json'
              this.loaderKey = uid()
              this.$nextTick(() => {
                this.$jq('.login').animate({
                  opacity: 0,
                  height: '0px'
                }, 1500, () => {
                  this.$jq('.login').animate({
                    opacity: 1,
                    height: '100%'
                  }, 1500)
                })
              })
            })
          })
        })
        */
    },
    async submit () {
      this.changeLoader('animations/siri-loading.json')
      this.$refs.email.$v.model.$touch()
      this.$refs.password.$v.model.$touch()
      if (
        this.$refs.email.$v.model.$error ||
          this.$refs.password.$v.model.$error
      ) {
        this.error('Invalid login!')
        this.changeLoader('animations/error1.json')
        return
      }
      this.$v.credentials.$touch()
      if (this.$v.credentials.email.$error) {
        this.error('Invalid login!')
        this.changeLoader('animations/error1.json')
        return
      }
      if (this.$v.credentials.password.$error) {
        this.error('Invalid login!')
        this.changeLoader('animations/error1.json')
        return
      }
      if (this.$v.credentials.type.$error) {
        this.error('Invalid login!')
        this.changeLoader('animations/error1.json')
        return
      }
      setTimeout(async () => {
        try {
          // this.changeLoader('animations/loading1.json')
          // await this.sleep(1000)
          const res = await axios({
            url: 'https://www.efuzy.com/salon/login',
            method: 'post',
            data: {
              email: this.credentials.email,
              password: this.credentials.password,
              type: this.credentials.type
            }
          })
          const status = res && res.data && res.data.status
          const jwt = res && res.data && res.data.jwt
          const tree = res && res.data && res.data.tree
          if (status !== 'OK') {
            this.error(status)
            this.changeLoader('animations/error1.json')
          } else {
            this.animatedLogin(async () => {
              LocalStorage.set('sessionDetails', jwt)
              LocalStorage.set('appDetails', tree)
              this.$store.dispatch('app/setSessionDetails', jwt)
              this.$store.dispatch('app/setAppDetails', tree)
              // this.$store.dispatch("app/changeRoute", "/calendar");
              // this.$store.dispatch("app/updateRouterKey");
              this.$nextTick(() => {
                setTimeout(() => {
                  window.location.reload()
                }, 0)
              })
            })
            /**
                                                                    if ( this.$store.getters['app/accountType'] === 'STYLIST') {
                                                                      //this.$store.dispatch('app/changeRoute', '/profile/view')
                                                                       window.location.hash = '/profile/view'
                                                                       window.location.reload()
                                                                    } else if ( this.$store.getters['app/accountType'] === 'SALON') {
                                                                      //this.$store.dispatch('app/changeRoute', '/profile/view')
                                                                       window.location.hash = '/profile/view'
                                                                       window.location.reload()
                                                                    }else if ( this.$store.getters['app/accountType'] === 'SALONSTYLIST') {
                                                                      //this.$store.dispatch('app/changeRoute', '/profile/view')
                                                                       window.location.hash = '/profile/view'
                                                                       window.location.reload()
                                                                    }
               **/
          }
        } catch (e) {
          this.error(e)
        }
      }, 2000)
    },
    animatedLogin (func) {
      this.$jq('.login').slideUp('slow', func)
    },
    error (message) {
      return this.$q.notify({
        message: message,
        color: 'negative',
        multiLine: true
      })
    }
  }
}
</script>
<style>
  #modal div {
    overflow: hidden !important;
  }

  #modal .bx--modal-content {
      margin-bottom:0px;
      padding-bottom:0px;
  }
  .containerx {
    position: relative;
    display: flex;
    justify-content: center;
    align-items: center;
  }
  .childx {
    margin: 5 auto;
    /* apply negative top and left margins to truly center the element */
  }
  .bx--modal-close {
    display: none !important;
  }
  .imgfill {
    background-repeat: no-repeat;
    background-size: cover;
  }
</style>
<style lang="scss">
  @import "../../styles/carbon-utils";
  @import "./carbon-overrides";
  @import "./mixins";
  .text-color-white {
    color: var(--c-text-01) !important;
  }
  .landing-page__illo {
    max-width: 100%;
  }
  .landing-page__banner {
    padding-top: $spacing-05;
    padding-bottom: $spacing-07 * 4;
    @include landing-page-background;
  }
  .landing-page__heading {
    @include carbon--type-style("productive-heading-05");
  }
  .landing-page__r2 {
    margin-top: rem(-40px);
  }
  .landing-page__tab-content {
    padding-top: $layout-05;
    padding-bottom: $layout-05;
  }
  .landing-page__subheading {
    @include carbon--type-style("productive-heading-03");
    @include carbon--font-weight("semibold");
  }
  .landing-page__p {
    @include carbon--type-style("productive-heading-03");
    margin-top: $spacing-06;
    margin-bottom: $spacing-08;
    @include carbon--breakpoint-between((320px + 1), md) {
      max-width: 75%;
    }
  }
  .landing-page__r3 {
    padding-top: $spacing-09;
    padding-bottom: $spacing-09;
    @include landing-page-background;
  }
  .landing-page__label {
    @include carbon--type-style("heading-01");
  }
</style>
