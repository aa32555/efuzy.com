<template>
  <q-layout>
    <q-page-container>
      <q-page class="flex flex-center">
        <div
          id="particles-js"
          :class="$q.dark.isActive ? 'dark_gradient' : 'normal_gradient'"
        ></div>
        <q-btn
          color="white"
          class="absolute-top-right"
          flat
          round
          @click="
            $q.dark.toggle();
            $q.localStorage.set('dark-mode', $q.dark.isActive);
          "
          :icon="$q.dark.isActive ? 'nights_stay' : 'wb_sunny'"
        />
        <div class="absolute-center" v-if="checkingLogin">
          <FUZIcon
            path="LoadingScissors"
            :width="300"
            :height="300"
            :loop="true"
          />
        </div>
        <div
          class="input-page column items-center flex flex-center row"
          v-if="!checkingLogin"
        >
          <q-card>
            <div
              class="q-pa-md shadow-4 column items-center justify-center"
              :class="{
                'bg-black text-white': $q.localStorage.getItem('dark-mode'),
                'bg-white text-black': !$q.localStorage.getItem('dark-mode')
              }"
            >
              <div>
                <div class="layout-view layout-padding">
                  <center>
                    <img
                      :src="logo"
                      :style="'width:40vw;min-width:175px;max-width:300px'"
                    />
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
                      height="100px"
                      :style="'width:80vw;min-width:300px;max-width:600px'"
                      :class="{
                        'bg-black text-white': $q.localStorage.getItem(
                          'dark-mode'
                        ),
                        'bg-white text-black': !$q.localStorage.getItem(
                          'dark-mode'
                        )
                      }"
                    >
                      <q-carousel-slide
                        :name="1"
                        class="column no-wrap flex-center"
                      >
                        <span style="font-size:16px">
                         ...</span
                        >
                      </q-carousel-slide>
                      <q-carousel-slide
                        :name="2"
                        class="column no-wrap flex-center"
                      >
                        <span style="font-size:16px"
                          >...
                        </span>
                      </q-carousel-slide>
                      <q-carousel-slide
                        :name="3"
                        class="column no-wrap flex-center"
                      >
                        <span style="font-size:16px">
                          ...
                        </span>
                      </q-carousel-slide>
                      <q-carousel-slide
                        :name="4"
                        class="column no-wrap flex-center"
                      >
                        <span style="font-size:16px">
                          ...</span
                        >
                      </q-carousel-slide>
                    </q-carousel>
                  </center>
                  <q-form>
                    <div class="flex flex-center">
                      <q-field
                        borderless
                        error-label="A valid email address is needed"
                        stack-label
                      >
                        <template v-slot:prepend>
                          <q-icon name="mail" />
                        </template>
                        <q-input
                          :dark="$q.localStorage.getItem('dark-mode')"
                          @keyup.enter="submit"
                          v-model.trim="credentials.email"
                          placeholder="Your email address"
                          @blur="$v.credentials.email.$touch"
                          :error="$v.credentials.email.$error"
                          style="width:300px;"
                          ref="email"
                          rounded
                          outlined
                          label="Email"
                          autocomplete="on"
                        />
                      </q-field>
                    </div>
                    <div class="flex flex-center">
                      <q-field
                        borderless
                        stack-label
                        error-label="A password is required"
                      >
                        <template v-slot:prepend>
                          <q-icon name="vpn_key" />
                        </template>
                        <q-input
                          autocomplete="on"
                          @keyup.enter="submit"
                          :dark="$q.localStorage.getItem('dark-mode')"
                          rounded
                          outlined
                          style="width:300px;"
                          v-model="credentials.password"
                          type="password"
                          placeholder="Your password"
                          @blur="$v.credentials.password.$touch"
                          :error="$v.credentials.password.$error"
                          label="Password"
                        />
                      </q-field>
                    </div>
                    <div class="flex flex-center">
                      <q-field
                        :dark="$q.localStorage.getItem('dark-mode')"
                        borderless
                        stack-label
                        error-label="Account is required"
                      >
                        <q-icon
                          name="person"
                          :size="'30px'"
                          :class="{
                            'bg-black text-white ': $q.localStorage.getItem(
                              'dark-mode'
                            ),
                            'bg-white text-black ': !$q.localStorage.getItem(
                              'dark-mode'
                            )
                          }"
                        />
                        <q-radio
                          :class="{
                            'bg-black text-white': $q.localStorage.getItem(
                              'dark-mode'
                            ),
                            'bg-white text-black ': !$q.localStorage.getItem(
                              'dark-mode'
                            )
                          }"
                          v-model="credentials.type"
                          val="stylist"
                          label="Login as a Stylist"
                        />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <q-icon
                          name="account_balance"
                          :size="'30px'"
                          :class="{
                            'bg-black text-white  ': $q.localStorage.getItem(
                              'dark-mode'
                            ),
                            'bg-white text-black  ': !$q.localStorage.getItem(
                              'dark-mode'
                            )
                          }"
                        />
                        <q-radio
                          :class="{
                            'bg-black text-white ': $q.localStorage.getItem(
                              'dark-mode'
                            ),
                            'bg-white text-black ': !$q.localStorage.getItem(
                              'dark-mode'
                            )
                          }"
                          v-model="credentials.type"
                          val="salon"
                          label="Login as a Salon"
                        />
                      </q-field>
                    </div>
                  </q-form>
                  <div class="flex flex-center">
                    <div class="submit row reverse">
                      <q-btn
                        @click="submit"
                        class="bg-green text-white full-width"
                        rounded
                        >Sign in</q-btn
                      >
                      <q-btn
                        rounded
                        @click="$router.replace({ path: '/register' })"
                        style="width:100px;"
                        >Sign up</q-btn
                      >
                      <q-btn rounded @click="resetPassword" style="width:200px;"
                        >Forgot Password?</q-btn
                      >
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
import { required, email } from 'vuelidate/lib/validators'
import axios from 'axios'
import { LocalStorage } from 'quasar'
import imgBlack from '../layouts/logo-b.png'
import imgWhite from '../layouts/logo-w.png'
import FUZIcon from '../components/FUZIcon'

export default {
  data () {
    return {
      checkingLogin: false,
      credentials: {
        email: '',
        password: '',
        type: 'stylist'
      },
      slide: 1,
      autoplay: true
    }
  },
  components: {
    FUZIcon
  },
  computed: {
    logo () {
      return this.$q.dark.isActive ? imgWhite : imgBlack
    }
  },
  async created () {},
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
        this.initParticles()
      }
    } else {
      this.initParticles()
    }
  },

  validations: {
    credentials: {
      email: { required, email },
      password: { required },
      type: { required }
    }
  },

  methods: {
    initParticles () {
      this.$nextTick(() => {
        this.checkingLogin = false
        this.$nextTick(() => {
          require('particles.js')
          /* eslint-disable */
          particlesJS("particles-js", {
            particles: {
              number: {
                value: 80,
                density: {
                  enable: true,
                  value_area: 800
                }
              },
              color: {
                value: "#ffffff"
              },
              shape: {
                type: "circle",
                stroke: {
                  width: 0,
                  color: "#000000"
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
                color: "#ffffff",
                opacity: 0.4,
                width: 1
              },
              move: {
                enable: true,
                speed: 6,
                direction: "none",
                random: false,
                straight: false,
                out_mode: "out",
                bounce: false,
                attract: {
                  enable: false,
                  rotateX: 600,
                  rotateY: 1200
                }
              }
            },
            interactivity: {
              detect_on: "canvas",
              events: {
                onhover: {
                  enable: true,
                  mode: "grab"
                },
                onclick: {
                  enable: true,
                  mode: "push"
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
          });
          this.$q.dark.set(!!this.$q.localStorage.getItem("dark-mode"));
          // await this.checkAuth()
          // on next Vue tick, to ensure
          // our Vue reference exists
          this.$nextTick(() => {
            // calling "next()" method:
            if (this.checkingLogin === false) this.$refs.email.focus();
          });
        });
      });
    },
    resetPassword() {
      if (this.$v.credentials.email.$error) {
        this.error("Not a valid email.");
      }
    },
    async submit() {
      this.$v.credentials.$touch();
      if (this.$v.credentials.email.$error) {
        this.error("Not a valid email.");
        return;
      }

      if (this.$v.credentials.password.$error) {
        this.error("Invalid Password Min 8 Characters");
        return;
      }
      if (this.$v.credentials.type.$error) {
        this.error("Account type is required!");
        return;
      }
      try {
        const res = await axios({
          url: "http://127.0.0.1:7777/login",
          method: "post",
          data: {
            email: this.credentials.email,
            password: this.credentials.password,
            type: this.credentials.type
          }
        });
        const status = res && res.data && res.data.status;
        const jwt = res && res.data && res.data.jwt;
        const tree = res && res.data && res.data.tree;
        if (status !== "OK") {
          this.error(status);
        } else {
          LocalStorage.set("sessionDetails", jwt);
          LocalStorage.set("appDetails", tree);
          this.$store.dispatch("app/setSessionDetails", jwt);
          this.$store.dispatch("app/setAppDetails", tree);
         // this.$store.dispatch("app/changeRoute", "/calendar");
         // this.$store.dispatch("app/updateRouterKey");
          this.$nextTick(()=>{
            window.location.reload();
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
        this.error(e);
      }
    },
    error(message) {
      return this.$q.notify({
        message: message,
        color: "negative",
        multiLine: true,
        avatar: this.logo
      });
    }
  }
};
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
