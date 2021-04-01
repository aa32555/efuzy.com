<template>
 <q-card bordered style="overflow-y:auto">
   <q-card-section class="q-pt-none">
     <FUZIcon path="NoData" :width="300" :height="300" v-if="invalidID" :loop="true"/>
  <div v-if="!rendered" v-show="!loading">
    <div class="flex flex-center">
            <slot name="skeleton">
            </slot>
            <!-- <FUZIcon path="LoadingScissors" :width="300" :height="300" :loop="true" v-if="!$slots['form-skeleton']"/> -->
          <div class="row q-pa-md" v-for="i in 10" :key="'askeleton'+i">
          <q-skeleton :type="'QInput'" class="col" style="width:30vw;max-width:800px;min-width:350px" />
          </div>
    </div>
  </div>
   <q-spinner-hourglass  v-show="loading" class="flex flex-center fixed-center" color="accent" size="10.5em" />
  <div v-if="rendered && !invalidID">
    <q-card-section class="q-pt-none">
          <div class="text-h6 " v-if="!noHeader">&nbsp;{{form.title}}</div>
    </q-card-section>
      <q-card-section class="q-pt-none flex flex-center" >
    <q-form
      @submit="onSubmit"
      ref="FUZNewForm"
      class=" flex flex-center row justify-evenly"
      :style="'width:800px'">
      <div v-for="(m,i) in model" :key="'model'+i" class="">
      <component
        :disable="view || m.props.disable"
        @input="m.onInput?cycleModel(m.onInput):undefined"
        @change="m.onChange?cycleModel(m.onChange):undefined"
        @click.stop.prevent="m.onClick?cycleModel(m.onClick):undefined"
        v-if="m.type !=='vue-avatar' && m.type !=='radio'"
        :is="m.is"
        v-model="model[i]['data'][m.model]"
        v-bind="m.props"
        :rules="[
        m.rules && m.rules.required?(val => !!val || 'Required'):undefined,...(m.rules && m.rules.list),
        m.rules && m.rules.date?(val => validateDate(val)):undefined,
        m.rules && m.rules.phone?(val => validatePhone(val)):undefined,
        m.rules && m.rules.email?(val => validateEmail(val)):undefined
        ]"
        :options="m.props.options"
        >
        <template v-slot:append v-if="m.type==='date'">
        <q-icon name="event" class="cursor-pointer">
          <q-popup-proxy :ref="'ref'+i" transition-show="scale" transition-hide="scale">
            <q-date v-model="model[i]['data'][m.model]" @input="hideDate(i)" mask="MM/DD/YYYY" :disable="view || m.props.disable"/>
          </q-popup-proxy>
        </q-icon>
      </template>
      </component>
      <div class="q-pa-md" v-if="m.type==='radio'" v-bind="m.props" >
        <q-radio :disable="view || m.props.disable" @input="m.onInput?cycleModel(m.onInput):undefined" v-for="(option,optionI) in m.options" :key="'radio-'+i+'option'+optionI" v-model="model[i]['data'][m.model]" :val="option.val" :label="option.label" />
      </div>
      </div>
      <div class="q-pa-md q-gutter-md " v-if="!view">
      <q-list bordered padding class="rounded-borders bg-positive" style="width:350px;" >
      <q-item
        clickable
        v-ripple
        @click="onSubmit"
        class="flex flex-center text-center"
      >
        <q-item-section avatar >
          <q-icon name="save_alt" color="white" size="xl" />
        </q-item-section>
        <q-item-section class="text-white text-h6">Save</q-item-section>
      </q-item>
      </q-list>
      </div>
    </q-form>
    </q-card-section>
    </div>
   </q-card-section>
</q-card>
</template>
<script>
import m from '../utils/M'
import { date, QInput, QSelect, QToggle, QRadio, QSeparator } from 'quasar'
import FUZImg from './FUZImg'
import FUZIcon from './FUZIcon'
import FUZListSearch from './FUZListSearch'
import FUZListSearchMini from './FUZListSearchMini'
import FUZHeader from './FUZHeader'
import FUZColorPicker from './FUZColorPicker'
import FUZSelect from './FUZSelect'
import FUZCodeEditorInput from '../FUZ/FUZCodeEditorInput'
import Avataaars from 'vuejs-avataaars'

export default {
  name: 'FUZNew',
  components: {
    QInput,
    QSelect,
    QToggle,
    QRadio,
    FUZImg,
    FUZIcon,
    FUZListSearch,
    QSeparator,
    FUZHeader,
    FUZColorPicker,
    FUZSelect,
    FUZListSearchMini,
    FUZCodeEditorInput,
    Avataaars
  },
  data () {
    return {
      model: [],
      form: {},
      rendered: false,
      loading: false,
      ID: this.id || this.$route.params.id,
      invalidID: false
    }
  },
  props: ['type', 'id', 'view', 'noRerouteAfterSave', 'noHeader'],
  async created () {
    const response = await m('getModelData^FUZNEW', { type: this.type, id: this.ID })
    if (response && response.model) {
      if (response.model.invalidID === true) {
        this.invalidID = true
      }
      this.model = response.model && response.model.M
      if (response.model && response.model.F) {
        this.$set(this.$data, 'form', response.model.F)
      }
      this.$nextTick(() => {
        this.rendered = true
      })
    } else {

    }
  },
  methods: {
    validatePhone (val) {
      return ((val ? (val && val.length === 14) : true) || 'Invalid Phone')
    },
    validateDate (val) {
      return (val ? date.isValid(val) : true) || 'Invalid Date'
    },
    hideDate (i) {
      this.$refs['ref' + i][0].hide()
    },
    async cycleModel (routine) {
      this.loading = true
      const response = await m('cycleModel^FUZNEW', { routine: routine, type: this.type, model: this.model, form: this.form })
      this.loading = false
      if (response && response.status === 'OK') {
        if (response.model && response.form) {
          this.$set(this.$data, 'form', response.form)
          this.$set(this.$data, 'model', response.model)
        }
      } else if (response && response.status === 'DISMISS') {
        this.loading = false
        this.$emit('dismiss', true)
      }
    },
    async onSubmit () {
      // this.$q.loading.show()
      this.$refs.FUZNewForm.validate().then(async success => {
        if (success) {
          this.loading = true
          const response = await m('saveModelData^FUZNEW', { type: this.type, model: this.model, form: this.form, noRerouteAfterSave: !!this.noRerouteAfterSave })
          this.loading = false
          if (response && response.status === 'OK') {
            //  this.$q.loading.hide()
            this.$emit('updateSingle', response.id)
            this.$nextTick(() => {
              this.$emit('dismiss', true)
            })
          }
        } else {
          this.loading = false
          this.$q.notify({
            message: 'Some fields are required!',
            color: 'negative'
          })
        }
      })
    },
    required (val) {
      return val => (val && val.length > 0) || 'Please type something'
    },
    chunkString (str, length) {
      return str.match(new RegExp('.{1,' + length + '}', 'g'))
    },
    validateEmail (email) {
      const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
      return re.test(String(email).toLowerCase())
    }
  }
}
</script>
<style>
 img.v1-image{
     max-width:100% !important;
    height:auto !important;
}
</style>
