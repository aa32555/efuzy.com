<template>
<q-dialog :value="true" persistent :maximized="true" transition-show="slide-up" transition-hide="slide-down" dark>
    <FUZPage style="height:100%;width:100%;padding:0;margin:0;" class="flex flex-center">
        <q-page-sticky position="top-left" :offset="[5, 5]">
            <img :src="'logo-lg.png'" alt="logo" :style="'height:95px;width:auto;margin:0 auto;cursor:pointer;'" @click="$router.push('/login')">
        </q-page-sticky>
        <FUZDiv :colLG="12" style="width:100%;padding:0;margin:0;background-color:inherit;" class="flex flex-center">
            <q-banner dense class="full-width" style="background-color:inherit;color:var(--q-color-main);">
                <span class="text-h2">Sign up</span>
            </q-banner>
            <q-stepper dark style="padding:0;margin:0;overflow:auto;width:100%;background-color:inherit;" v-model="step" active-color="gold" animated contracted flat>
                <q-step :name="1" :done="step > 1" title="">
                    <FUZDiv :colLG="6" style="height:100%;width:100%;padding:0;margin:0;background-color:background-color:inherit;">
                        <q-form>
                                <q-field :dark="true" borderless error-label="A valid name is needed" stack-label>
                                    <template v-slot:prepend>
                                        <q-icon name="person" />
                                    </template>
                                    <q-input rounded outlined style="width:100%;" @keyup.enter="submit" ref="name" v-model.trim="credentials.name" label="Profile Name (No Spaces. e.g. JohnDoe)" mask="aaaaaaaaaaaaaaaaaaa" @blur="$v.credentials.name.$touch" :error="$v.credentials.name.$error" />
                                </q-field>
                                <q-field :dark="true" borderless error-label="A valid email address is needed" stack-label>
                                    <template v-slot:prepend>
                                        <q-icon name="mail" />
                                    </template>
                                    <q-input @keyup.enter="submit" rounded outlined style="width:100%;" v-model.trim="credentials.email" label="Email" @blur="$v.credentials.email.$touch" :error="$v.credentials.email.$error" ref="email" />
                                </q-field>
                                <q-field :dark="true" borderless error-label="Emails don't match" stack-label>
                                    <template v-slot:prepend>
                                        <q-icon name="mail" />
                                    </template>
                                    <q-input @keyup.enter="submit" rounded outlined style="width:100%;" v-model.trim="credentials.email2" label="Confirm Email" @blur="$v.credentials.email2.$touch" :error="$v.credentials.email2.$error" ref="email2" />
                                </q-field>
                                <q-field :dark="true" borderless stack-label error-label="A password is required">
                                    <template v-slot:prepend>
                                        <q-icon name="vpn_key" />
                                    </template>
                                    <q-input @keyup.enter="submit" rounded outlined style="width:100%;" v-model.trim="credentials.password" type="Password" label="Password (Min length 8 characters)" @blur="$v.credentials.password.$touch" :error="$v.credentials.password.$error" />
                                </q-field>
                                <q-field :dark="true" borderless stack-label error-label="Account is required">
                                    <q-icon name="person" :size="'30px'" color="white" />
                                    <q-radio v-model="credentials.type " class="text-white" val="stylist" label="I'm signing up as a stylist" />
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <q-icon name="account_balance" :size="'30px'" color="white"/>
                                    <q-radio class="text-white" v-model="credentials.type" val="salon" label="I'm signing up as a salon" />
                                </q-field>
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
import { required, minLength, email, alpha } from 'vuelidate/lib/validators'
import FUZPage from '../../FUZ/FUZPage'
import FUZDiv from '../../FUZ/FUZDiv'
import axios from 'axios'

export default {
  name: 'LoginPageRegister',
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
        email2: '',
        password: '',
        type: 'stylist',
        account: '',
        name: ''
      }
    }
  },
  validations: {
    credentials: {
      name: { required, minLength: minLength(3), alpha },
      email: { required, email },
      email2: { required, confirmEmail: function (value) { return value && value.length && value === this.credentials.email } },
      password: { required, minLength: minLength(8) },
      account: { },
      type: { required }
    }
  },
  async mounted () {
  },
  methods: {
    error (message) {
      return this.$q.notify({
        message: message,
        color: 'negative',
        multiLine: true
      })
    },
    async submit () {
      this.$v.credentials.$touch()
      if (this.$v.credentials.email.$error) {
        this.error('Invalid Email!')
        return
      }
      if (this.$v.credentials.email2.$error) {
        this.error('Your emails don\'t match!')
        return
      }
      if (this.$v.credentials.password.$error) {
        this.error('Invalid Password! Minimum 8 characters')
        return
      }

      if (this.$v.credentials.account.$error) {
        this.error('Invalid Account!')
        return
      }

      if (this.$v.credentials.name.$error) {
        this.error('Name has to be alpha characters only with no spaces')
      }
      const res = await axios({
        url: 'http://127.0.0.1:7777/register',
        method: 'post',
        data: {
          email: this.credentials.email,
          password: this.credentials.password,
          name: this.credentials.name,
          account: this.credentials.account,
          type: this.credentials.type
        }
      })
      const status = res.data.status
      if (status !== 'OK') {
        this.error(status.join(', '))
      } else {
        this.$router.replace({ path: '/login' })
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
