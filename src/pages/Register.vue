<template>
    <q-layout>
        <q-page-container>
      <q-page class="flex flex-center">
        <div id="particles-js" :class="$q.dark.isActive?'dark_gradient':'normal_gradient'"></div>
        <q-btn color="white" class="absolute-top-right" flat round @click="$q.dark.toggle();$q.localStorage.set('dark-mode',$q.dark.isActive)"
               :icon="$q.dark.isActive ? 'nights_stay' : 'wb_sunny'"/>
    <div
      class="input-page column items-center flex flex-center row"
    >
    <q-card>
      <div class="q-pa-md shadow-4 column items-center justify-center" :class="{'bg-black text-white':$q.localStorage.getItem('dark-mode'),'bg-white text-black':!$q.localStorage.getItem('dark-mode')}">
        <div>
          <div class="layout-view layout-padding">
            <center>
              <img :src="logo" :style="'width:40vw;min-width:175px;max-width:300px'">
               <!--  <span class="text-h4">MasterStylists.com</span><br>
                <img :src="logo" style="width:100px;height:100px">
                <FUZIcon path="WhiteScissors"  :loop="true" /> -->
          <q-carousel
          animated
          v-model="slide"
          infinite
          :autoplay="autoplay"
          transition-prev="slide-right"
          transition-next="slide-left"
          @mouseenter="autoplay = false"
          @mouseleave="autoplay = true"
          swipeable
        height="50px"
        :style="'width:80vw;min-width:300px;max-width:600px'"
         :class="{'bg-black text-white':$q.localStorage.getItem('dark-mode'),'bg-white text-black':!$q.localStorage.getItem('dark-mode')}"
      >
        <q-carousel-slide :name="1" class="column no-wrap flex-center">
         <span style="font-size:16px">...</span>
        </q-carousel-slide>
        <q-carousel-slide :name="2" class="column no-wrap flex-center">
         <span style="font-size:16px">... </span>
        </q-carousel-slide>
      </q-carousel>
      <br/>
            </center>
              <q-form>
             <div class="flex flex-center">

 <q-field  :dark="$q.localStorage.getItem('dark-mode')" borderless    error-label="A valid name is needed" stack-label>
                     <template v-slot:prepend>
          <q-icon name="person" />
        </template>
        <q-input rounded outlined style="width:300px;" @keyup.enter="submit"   ref="name"  v-model.trim="credentials.name" label="Profile Name (No Spaces. e.g. JohnDoe)" mask="aaaaaaaaaaaaaaaaaaa" @blur="$v.credentials.name.$touch" :error="$v.credentials.name.$error" />
      </q-field>
      </div>
      <div class="flex flex-center">
      <q-field    :dark="$q.localStorage.getItem('dark-mode')" borderless    error-label="A valid email address is needed" stack-label>
                     <template v-slot:prepend>
          <q-icon name="mail" />
        </template>
        <q-input @keyup.enter="submit"  rounded outlined style="width:300px;" v-model.trim="credentials.email" label="Email" @blur="$v.credentials.email.$touch" :error="$v.credentials.email.$error"  ref="email" />
      </q-field>
      </div>
            <div class="flex flex-center">
      <q-field    :dark="$q.localStorage.getItem('dark-mode')" borderless    error-label="Emails don't match" stack-label>
                     <template v-slot:prepend>
          <q-icon name="mail" />
        </template>
        <q-input @keyup.enter="submit"  rounded outlined style="width:300px;" v-model.trim="credentials.email2" label="Confirm Email" @blur="$v.credentials.email2.$touch" :error="$v.credentials.email2.$error"  ref="email2" />
      </q-field>
      </div>
      <div class="flex flex-center">
      <q-field    :dark="$q.localStorage.getItem('dark-mode')" borderless    stack-label error-label="A password is required">
                  <template v-slot:prepend>
          <q-icon name="vpn_key" />
        </template>
        <q-input  @keyup.enter="submit"  rounded outlined style="width:300px;" v-model.trim="credentials.password" type="Password " label="Password (Min length 8 characters)" @blur="$v.credentials.password.$touch" :error="$v.credentials.password.$error"  />
      </q-field>
      </div>
           <div class="flex flex-center">
                  <q-field   :dark="$q.localStorage.getItem('dark-mode')" borderless    stack-label error-label="Account is required">
         <q-icon name="person" :size="'30px'" :class="{'bg-black text-white ':$q.localStorage.getItem('dark-mode'),'bg-white text-black ':!$q.localStorage.getItem('dark-mode')}"/>
      <q-radio  :class="{'bg-black text-white':$q.localStorage.getItem('dark-mode'),'bg-white text-black ':!$q.localStorage.getItem('dark-mode')}" v-model="credentials.type" val="stylist" label="I'm registering as a stylist" />
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       <q-icon name="account_balance" :size="'30px'" :class="{'bg-black text-white  ':$q.localStorage.getItem('dark-mode'),'bg-white text-black  ':!$q.localStorage.getItem('dark-mode')}"/>
      <q-radio  :class="{'bg-black text-white ':$q.localStorage.getItem('dark-mode'),'bg-white text-black ':!$q.localStorage.getItem('dark-mode')}" v-model="credentials.type" val="salon" label="I'm registering as a salon" />
      </q-field>

      </div>
        </q-form>
       <div class="flex flex-center">
      <div class="submit row reverse">
        <q-btn style="width:300px;" class="bg-primary text-white" rounded @click="submit">Create Account</q-btn>
        </div>
      </div>
          </div>
        </div>
      </div>
    </q-card>
    </div>
      </q-page>
        </q-page-container>
        </q-layout>
</template>

<script>
import { required, minLength, email, alpha } from 'vuelidate/lib/validators'
import imgBlack from '../layouts/logo-b.png'
import imgWhite from '../layouts/logo-w.png'
import axios from 'axios'

export default {
  data () {
    return {
      credentials: {
        email: '',
        email2: '',
        password: '',
        type: 'stylist',
        account: '',
        name: ''
      },
      slide: 1,
      autoplay: true
    }
  },
  components: {
  },
  computed: {
    logo () {
      return this.$q.dark.isActive ? imgWhite : imgBlack
    }
  },
  async mounted () {
    require('particles.js')
    /* eslint-disable */
    particlesJS('particles-js', {
      particles: {
        number: {
          value: 80,
          density: {
            enable: true,
            value_area: 800
          }
        },
        color: {
          value: '#ffffff'
        },
        shape: {
          type: 'circle',
          stroke: {
            width: 0,
            color: '#000000'
          },
          polygon: {
            nb_sides: 5
          },
          image: {
            width: 100,
            height: 100
          }
        },
        opacity: {
          value: 0.5,
          random: false,
          anim: {
            enable: false,
            speed: 1,
            opacity_min: 0.1,
            sync: false
          }
        },
        size: {
          value: 3,
          random: true,
          anim: {
            enable: false,
            speed: 40,
            size_min: 0.1,
            sync: false
          }
        },
        line_linked: {
          enable: true,
          distance: 150,
          color: '#ffffff',
          opacity: 0.4,
          width: 1
        },
        move: {
          enable: true,
          speed: 6,
          direction: 'none',
          random: false,
          straight: false,
          out_mode: 'out',
          bounce: false,
          attract: {
            enable: false,
            rotateX: 600,
            rotateY: 1200
          }
        }
      },
      interactivity: {
        detect_on: 'canvas',
        events: {
          onhover: {
            enable: true,
            mode: 'grab'
          },
          onclick: {
            enable: true,
            mode: 'push'
          },
          resize: true
        },
        modes: {
          grab: {
            distance: 140,
            line_linked: {
              opacity: 1
            }
          },
          bubble: {
            distance: 400,
            size: 40,
            duration: 2,
            opacity: 8,
            speed: 3
          },
          repulse: {
            distance: 200,
            duration: 0.4
          },
          push: {
            particles_nb: 4
          },
          remove: {
            particles_nb: 2
          }
        }
      },
      retina_detect: true
    })
    this.$q.dark.set(!!this.$q.localStorage.getItem('dark-mode'))
    // await this.checkAuth()
    // on next Vue tick, to ensure
    // our Vue reference exists
    this.$nextTick(() => {
      // calling "next()" method:
      this.$refs.name.focus()
    })
  },

  validations: {
    credentials: {
      name: { required, minLength: minLength(3), alpha },
      email: { required, email },
      email2:{ required, confirmEmail: function(value) { return value && value.length && value === this.credentials.email}},
      password: { required, minLength: minLength(8) },
      account: { },
      type: { required }
    }
  },
  methods: {
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
    },
    error (message) {
      return this.$q.notify({
        message: message,
        color: 'negative',
        multiLine: true,
        avatar: this.logo
      })
    }
  }
}
</script>
<style lang="stylus" scoped>
.input-card {
  border-radius: 5px;
  margin-top: -10px;
  margin: 10vh;

  .layout-padding {
    margin: 0 32px;
  }
}

.submit {
  >.q-btn {
    margin: 5px;
  }
}
 #particles-js {
    position: absolute;
    width: 100%;
    height: 100%;
    background-repeat: no-repeat;
    background-size: cover;
    background-position: 50% 50%;
  }
  .normal_gradient{
    background: linear-gradient(145deg, rgb(74, 94, 137) 15%, #b61924 70%);
  }
  .dark_gradient{
    background: linear-gradient(145deg, rgb(11, 26, 61) 15%, #4c1014 70%);
  }
  .login-form {
    position: absolute;
  }
</style>
