<template>
    <div :style="imgProps.parentStyle" :class="imgProps.parentClass">
      <div>
    <img :src="typeof value === 'object'? value.join(''):image(value)" v-bind="imgProps"
    v-if="!imgProps.avatar" @click="debounceClick" :style="'cursor:pointer'"
    @contextmenu="showImage" v-touch-hold.mouse="showImage"/>
    <q-avatar v-bind="imgProps" v-touch-hold.mouse="showImage"
    @contextmenu="showImage" v-if="imgProps.avatar" @click="debounceClick"  :style="'cursor:pointer'">
      <img :src="typeof value === 'object'? value.join(''):value" v-bind="imgProps" v-if="imgProps.avatar" style="display: block;width: auto;height: 100%;">
    </q-avatar>
    <VueBase64FileUpload :ref="'imgRef'" v-bind="imgProps" v-if="!disable"
        accept="image/png,image/jpeg"
        :max-size="10"
        @size-exceeded="()=>{}"
        @load="imageLoaded"
       >
  </VueBase64FileUpload>
  <q-dialog v-model="imageDialog">
      <q-card class="my-card" style="width:100%;">
        <q-img :src="typeof value === 'object'? value.join(''):value" />
      </q-card>
  </q-dialog>
    </div>
    <p v-if="imgProps.label" :style="imgProps.labelStyle" :class="imgProps.labelClass">&nbsp;{{imgProps.label}}</p>
    </div>
</template>
<script>
import VueBase64FileUpload from './UploadImage'
export default {
  data () {
    return {
      imageDialog: false
    }
  },
  components: {
    VueBase64FileUpload
  },
  props: ['value', 'imgProps', 'disable'],
  computed: {

  },
  methods: {
    image (id) {
      return '/' + id
    },
    debounceClick (e) {
      if (!this.disable && !this.imgProps.viewOnly) { this.$refs.imgRef.pickFiles() } else {
        this.showImage(e)
      }
    },
    imageLoaded (dataUri) {
      this.$emit('input', Object.freeze(this.chunkString(dataUri, 15000)))
    },
    chunkString (str, length) {
      return str.match(new RegExp('.{1,' + length + '}', 'g'))
    },
    showImage (e) {
      e.preventDefault()
      this.imageDialog = true
    }
  }
}
</script>
