<template>
<q-dialog :value="true" persistent :maximized="true" transition-show="slide-up" transition-hide="slide-down" dark>
    <FUZPage style="height:100%;width:100%;padding:0;margin:0;" class="flex flex-center">
        <q-page-sticky position="top-left" :offset="[5, 5]">
            <img :src="'logo-lg.png'" alt="logo" :style="'height:95px;width:auto;margin:0 auto;cursor:pointer;'" @click="$router.push('/login')">
        </q-page-sticky>
        <FUZDiv :colLG="12" style="width:100%;padding:0;margin:0;background-color:inherit;" class="flex flex-center">
            <q-banner dense class="full-width" style="background-color:inherit;color:var(--q-color-main);padding-top:100px;">
              <span class="text-h2">Login</span>
            </q-banner>
            <q-stepper dark style="padding:0;margin:0;overflow:auto;width:100%;background-color:inherit;" v-model="step" active-color="gold" animated contracted flat>
                <q-step :name="1" :done="step > 1" title="">
                    <FUZDiv :colLG="6" style="height:100%;width:100%;padding:0;margin:0;background-color:background-color:inherit;">
                        <q-form @submit="submit" class="q-gutter-md">
                            <q-field borderless error-label="A valid email address is needed" stack-label>
                                <template v-slot:prepend>
                                    <q-icon name="mail" />
                                </template>
                                <q-input style="width:100%" :dark="true" @keyup.enter="submit" v-model.trim="credentials.email" placeholder="Your email address" @blur="$v.credentials.email.$touch" :error="$v.credentials.email.$error" ref="email" rounded outlined label="Email" autocomplete="on" />
                            </q-field>
                            <q-field borderless stack-label error-label="A password is required">
                                <template v-slot:prepend>
                                    <q-icon name="vpn_key" />
                                </template>
                                <q-input autocomplete="on" @keyup.enter="submit" :dark="true" rounded outlined style="width:100%;" v-model="credentials.password" type="password" placeholder="Your password" @blur="$v.credentials.password.$touch" :error="$v.credentials.password.$error" label="Password" />
                            </q-field>
                                <q-field :dark="true" borderless stack-label error-label="Account type is required">
                                    <q-icon name="person" :size="'30px'" color="white" />
                                    <q-radio v-model="credentials.type " class="text-white" val="stylist" label="Stylist" />
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <q-icon name="account_balance" :size="'30px'" color="white"/>
                                    <q-radio class="text-white" v-model="credentials.type" val="salon" label="Salon" />
                                </q-field>
                                <q-btn size="sm" color="primary" rounded outline @click="resetPassword">Forgot password?</q-btn>
                        </q-form>
                        <q-stepper-navigation>
                            <q-btn @click="submit" class="float-right" style="color:var(--q-color-main);" size="xl" label="Submit" rounded outline />
                        </q-stepper-navigation>
                    </FUZDiv>
                    <FUZDiv :colLG="6" style="height:100%;width:100%;padding:0;margin:0;">
                    </FUZDiv>
                </q-step>

                <q-step :name="2" title="Create an ad group" caption="Optional" icon="create_new_folder" :done="step > 2">
                    An ad group contains one or more ads which target a shared set of keywords.

                    <q-stepper-navigation>
                        <q-btn @click="step = 4" color="primary" label="Continue" />
                        <q-btn flat @click="step = 1" color="primary" label="Back" class="q-ml-sm" />
                    </q-stepper-navigation>
                </q-step>

                <q-step :name="3" title="Ad template" icon="assignment" disable>
                    This step won't show up because it is disabled.
                </q-step>

                <q-step :name="4" title="Create an ad" icon="add_comment">
                    Try out different ad text to see what brings in the most customers, and learn how to
                    enhance your ads using features like ad extensions. If you run into any problems with
                    your ads, find out how to tell if they're running and how to resolve approval issues.

                    <q-stepper-navigation>
                        <q-btn color="primary" label="Finish" />
                        <q-btn flat @click="step = 2" color="primary" label="Back" class="q-ml-sm" />
                    </q-stepper-navigation>
                </q-step>
            </q-stepper>
        </FUZDiv>
    </FUZPage>
</q-dialog>
</template>

<script>
import {
  required,
  email
} from 'vuelidate/lib/validators'
import FUZPage from '../../FUZ/FUZPage'
import FUZDiv from '../../FUZ/FUZDiv'
import axios from 'axios'
import {
  LocalStorage
} from 'quasar'

export default {
  name: 'OnlineBookingPage',
  components: {
    FUZPage,
    FUZDiv
  },
  data () {
    return {
      checkingLogin: false,
      step: 1,
      credentials: {
        email: '',
        password: '',
        type: 'salon'
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
  async mounted () {
    const jwt = LocalStorage.getItem('sessionDetails')
    const tree = LocalStorage.getItem('appDetails')
    if (jwt && tree && typeof jwt === 'object' && typeof tree === 'object') {
      this.checkingLogin = true
      this.$store.dispatch('app/setSessionDetails', jwt)
      this.$store.dispatch('app/setAppDetails', tree)
      const status = await this.$m('CheckAuth^SALON')
      if (status.status) {
        this.$store.dispatch('app/changeRoute', '/profile/view')
        // this.checkingLogin = false
      } else {
        // this.initParticles()
      }
    } else {
      // this.initParticles()
    }
  },
  methods: {
    resetPassword () {
      if (this.$v.credentials.email.$error) {
        this.error('Not a valid email.')
      }
    },
    error (message) {
      return this.$q.notify({
        message: message,
        color: 'negative',
        multiLine: true,
        avatar: this.logo
      })
    },
    async submit () {
      this.$v.credentials.$touch()
      if (this.$v.credentials.email.$error) {
        this.error('Not a valid email.')
        return
      }

      if (this.$v.credentials.password.$error) {
        this.error('Invalid Password Min 8 Characters')
        return
      }
      if (this.$v.credentials.type.$error) {
        this.error('Account type is required!')
        return
      }
      try {
        const res = await axios({
          url: 'http://127.0.0.1:7777/login',
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
        } else {
          LocalStorage.set('sessionDetails', jwt)
          LocalStorage.set('appDetails', tree)
          this.$store.dispatch('app/setSessionDetails', jwt)
          this.$store.dispatch('app/setAppDetails', tree)
          this.$store.dispatch('app/changeRoute', 'profile/view')
          this.$store.dispatch('app/updateRouterKey')
          window.location.reload()
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
    }
  }
}
</script>

<style>
.q-stepper__header,
.q-stepper__tab {
    display: none !important;
}

.q-dialog__backdrop {
    z-index: -1;
    pointer-events: all;
    background: rgb(0 0 0 / 77%);
}
</style>
