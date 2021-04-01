<template>
  <q-card :class="'q-pa-md '" bordered :style="'width:80vw;min-width:380px;'">
    <div
      class="text-center"
      v-if="
        loaded &&
          (!model || !model.name) &&
          (!$route.query.acct ||
          !notFound)
      "
    >
      <FUZIcon path="AddToList" :width="300" :height="300" :loop="true" />
      <q-btn
        :size="'lg'"
        class="q-mt-md text-center"
        text-color="primary"
        rounded
        outline
        unelevated
        label="Please fill out your profile"
        no-caps
        @click="$store.dispatch('app/changeRoute', '/profile/edit')"
      />
    </div>

    <div class="text-center" v-if="notFound">
      <FUZIcon path="Alert" :width="300" :height="300" :loop="true" />
      <span class="text-h5">404 Profile Not Found!</span>
    </div>
    <div>
            <div class="row lt-md" v-if="!loaded && !notFound">
        <div class="col-12">
          <FUZSkeleton
            :definition="skeleton"
          />
        </div>
        </div>
      <div class="row gt-sm" v-if="!loaded && !notFound">
        <div class="col-5 gt-sm">
          <FUZSkeleton
            :definition="skeleton"
          />
        </div>
        <div class="col-7 gt-sm" style="margin-top:175px">
          <q-skeleton  height="50vh" square  />
        </div>
      </div>
      <q-list
        v-if="loaded && model && model.name && !notFound"
        :style="'width:77vw;min-width:350px'"
      >
        <q-item>
          <q-item-section avatar>
            <q-img :src="typeof model.image === 'object' && model.image.join('')"  style="width: 25vw" />
          </q-item-section>
          <q-item-section>
             <q-btn
                    outlined
                    round
                    flat
                    label="Art Work"
                  />
            </q-item-section>
                      <q-item-section>
             <q-btn
                    outlined
                    round
                    flat
                    label="Reviews"
                  />
            </q-item-section>
                                  <q-item-section>
             <q-btn
                    outlined
                    round
                    flat
                    label="Stylists"
                  />
            </q-item-section>
                                              <q-item-section>
             <q-btn
                    outlined
                    round
                    flat
                    label="Book Online"
                  />
            </q-item-section>
        </q-item>
      </q-list>
      <q-card
        flat
        bordered
        v-if="loaded && model && model.name"
      >
        <q-card-section horizontal >
          <q-card-section :class="'q-pt-xs col-4 gt-sm'" :style="!$q.platform.is.mobile?'min-height:600px;':''">
        <div v-if="model.aboutme">
              <span class="profile-text">
                {{ model.aboutme }}
              </span>
            </div>
          </q-card-section>
          <q-card-section
            class="col-8 flex row wrap gt-sm"
          >
            <q-carousel
              class="full-width"
              animated
              v-model="slide"
              infinite
              :autoplay="autoplay"
              transition-prev="slide-right"
              transition-next="slide-left"
              @mouseenter="autoplay = false"
              @mouseleave="autoplay = true"
              swipeable
              height="100%"
              :thumbnails="thumbnails"
              :fullscreen.sync="fullscreen"
            >
              <q-carousel-slide
                :name="1"
                :img-src="
                  typeof model.fimage1 === 'object' ? model.fimage1.join('') : ''
                "
                contain
              >
              </q-carousel-slide>
              <q-carousel-slide
                :name="2"
                :img-src="
                  typeof model.fimage2 === 'object' ? model.fimage2.join('') : ''
                "
                contain
              >
              </q-carousel-slide>
               <q-carousel-slide
                :name="3"
                :img-src="
                  typeof model.fimage3 === 'object' ? model.fimage3.join('') : ''
                "
                contain
              >
              </q-carousel-slide>
               <q-carousel-slide
                :name="4"
                :img-src="
                  typeof model.fimage4 === 'object' ? model.fimage4.join('') : ''
                "
                contain
              >
              </q-carousel-slide>
               <q-carousel-slide
                :name="5"
                :img-src="
                  typeof model.fimage5 === 'object' ? model.fimage5.join('') : ''
                "
                contain
              >
              </q-carousel-slide>
              <template v-slot:control>
                <q-carousel-control position="bottom-right" :offset="[18, 18]">
                  <q-btn
                    push
                    round
                    dense
                    color="white"
                    text-color="primary"
                    :icon="fullscreen ? 'fullscreen_exit' : 'fullscreen'"
                    @click="fullscreen = !fullscreen"
                  />
                </q-carousel-control>
                <q-carousel-control position="bottom-right" :offset="[18, 60]">
                  <q-btn
                    push
                    round
                    dense
                    color="white"
                    text-color="primary"
                    :icon="'book'"
                    @click="thumbnails = !thumbnails"
                  />
                </q-carousel-control>
              </template>
            </q-carousel>
          </q-card-section>
        </q-card-section>
      </q-card>
      <q-carousel
        v-if="loaded && model && model.name "
        class="full-width lt-md"
        animated
        v-model="slide"
        infinite
        :autoplay="autoplay"
        transition-prev="slide-right"
        transition-next="slide-left"
        @mouseenter="autoplay = false"
        @mouseleave="autoplay = true"
        swipeable
        height="90vh"
        :thumbnails="thumbnails"
        :fullscreen.sync="fullscreen"
      >
       <q-carousel-slide
                :name="1"
                :img-src="
                  typeof model.fimage1 === 'object' ? model.fimage1.join('') : ''
                "
                contain
              >
              </q-carousel-slide>
              <q-carousel-slide
                :name="2"
                :img-src="
                  typeof model.fimage2 === 'object' ? model.fimage2.join('') : ''
                "
                contain
              >
              </q-carousel-slide>
               <q-carousel-slide
                :name="3"
                :img-src="
                  typeof model.fimage3 === 'object' ? model.fimage3.join('') : ''
                "
                contain
              >
              </q-carousel-slide>
               <q-carousel-slide
                :name="4"
                :img-src="
                  typeof model.fimage4 === 'object' ? model.fimage4.join('') : ''
                "
                contain
              >
              </q-carousel-slide>
               <q-carousel-slide
                :name="5"
                :img-src="
                  typeof model.fimage5 === 'object' ? model.fimage5.join('') : ''
                "
                contain
              >
              </q-carousel-slide>
        <template v-slot:control>
          <q-carousel-control position="bottom-right" :offset="[18, 18]">
            <q-btn
              push
              round
              dense
              color="white"
              text-color="primary"
              :icon="fullscreen ? 'fullscreen_exit' : 'fullscreen'"
              @click="fullscreen = !fullscreen"
            />
          </q-carousel-control>
          <q-carousel-control position="bottom-right" :offset="[18, 60]">
            <q-btn
              push
              round
              dense
              color="white"
              text-color="primary"
              :icon="'book'"
              @click="thumbnails = !thumbnails"
            />
          </q-carousel-control>
        </template>
      </q-carousel>
    </div>
  </q-card>
</template>
<script>
import FUZSkeleton from './FUZSkeleton'
import imgBlack from '../layouts/logo-black.png'
import imgWhite from '../layouts/logo-white.png'
import FUZIcon from './FUZIcon'
import axios from 'axios'
import { date, openURL } from 'quasar'

export default {
  components: {
    FUZSkeleton,
    FUZIcon
  },
  data () {
    return {
      skeleton: [
        [
          {
            type: 'circle',
            size: '100px',
            class: 'col-auto'
          },
          {
            type: 'rect',
            class: 'col-4',
            style: 'height:30px;margin-top:15px'
          }
        ],
        [
          {
            type: 'rect',
            class: 'col-5'
          }
        ],
        [
          {
            type: 'rect',
            class: 'col-10'
          }
        ],
        [
          {
            type: 'rect',
            class: 'col-5'
          }
        ],
        [
          {
            type: 'rect',
            class: 'col-10'
          }
        ],
        [
          {
            type: 'rect',
            class: 'col-5'
          }
        ],
        [
          {
            type: 'rect',
            class: 'col-10'
          }
        ],
        [
          {
            type: 'rect',
            class: 'col-12'
          }
        ],
        [
          {
            type: 'rect',
            class: 'col-12'
          }
        ],
        [
          {
            type: 'rect',
            class: 'col-12'
          }
        ]
      ],
      loaded: false,
      model: {},
      slide: 1,
      autoplay: true,
      fullscreen: false,
      notFound: false,
      thumbnails: false
    }
  },
  props: ['id'],
  async mounted () {
    this.loaded = false
    if (this.id) {
      const data = await this.$m('getSimpleModelData^FUZNEW', {
        type: 'SALONPROFILE',
        id: this.id
      })
      this.$set(this.$data, 'model', data.model)
      this.loaded = true
    } else if (this.$route.query.acct) {
      const acct = this.$route.query.acct
      const res = await axios({
        url: 'https://www.efuzy.com/salon/publicprofile',
        method: 'post',
        data: {
          acct
        }
      })
      const model = res && res.data && res.data.data && res.data.data.model
      if (model) {
        this.$set(this.$data, 'model', model)
        this.loaded = true
      } else {
        this.notFound = true
      }
    } else {
      this.notFound = true
    }
  },
  methods: {
    getDiff (bday) {
      return date.getDateDiff(new Date(), new Date(bday), 'years')
    },
    openURL (url) {
      return openURL(url)
    }
  },
  computed: {
    logo () {
      return this.$q.dark.isActive ? imgWhite : imgBlack
    }
  }
}
</script>
<style>
img.v1-image {
  max-width: 100% !important;
  height: auto !important;
}
.profile-text {
white-space: pre-wrap;
word-wrap: break-word;
word-break: break-word;
text-overflow: ellipsis;
overflow: hidden;
width: 300px;
padding:0px
}
</style>
