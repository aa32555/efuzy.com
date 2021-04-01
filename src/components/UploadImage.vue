<template>
  <div class="vue-base64-file-upload">
    <div class="vue-base64-file-upload-wrapper" :style="wrapperStyles">
      <input
        :dense="dense"
        type="file"
        :style="fileInputStyles"
        v-show="false"
      />
      <q-file
        ref="uploadButton"
        v-show="false"
        @change.native="onChange"
        :accept="accept"
        rounded
        outlined
        :label="placeholder"
        :class="inputClass"
        :style="textInputStyles"
        :placeholder="placeholder"
      />
    </div>
  </div>
</template>
<script>
import { QFile } from 'quasar'
export default {
  name: 'vue-base64-file-upload',
  mounted () {},
  props: {
    imageClass: {
      type: String,
      default: ''
    },
    inputClass: {
      type: String,
      default: ''
    },
    accept: {
      type: String,
      default: 'image/png,image/jpeg'
    },
    maxSize: {
      type: Number,
      default: 5 // megabytes
    },
    disablePreview: {
      type: Boolean,
      default: false
    },
    dense: {
      type: Boolean,
      default: false
    },
    fileName: {
      type: String,
      default: ''
    },
    placeholder: {
      type: String,
      default: 'Click here to upload image'
    },
    defaultPreview: {
      type: String,
      default: ''
    }
  },
  components: {
    QFile
  },
  data: function data () {
    return {
      file: null,
      preview: null,
      visiblePreview: false
    }
  },

  computed: {
    wrapperStyles: function wrapperStyles () {
      return {
        position: 'relative',
        width: '100%'
      }
    },
    fileInputStyles: function fileInputStyles () {
      return {
        width: '100%',
        position: 'absolute',
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
        opacity: 0,
        overflow: 'hidden',
        outline: 'none',
        cursor: 'pointer'
      }
    },
    textInputStyles: function textInputStyles () {
      return {
        width: '100%',
        cursor: 'pointer'
      }
    },
    previewImage: function previewImage () {
      return this.preview || this.defaultPreview
    }
  },

  methods: {
    pickFiles () {
      this.$refs.uploadButton.pickFiles()
    },
    onChange: async function onChange (e) {
      var _this = this

      var files = e.target.files || e.dataTransfer.files

      if (!files.length) {
        return
      }

      var file = files[0]
      var size = file.size && file.size / Math.pow(1000, 2)
      if (size > this.maxSize) {
        this.$emit('size-exceeded', size)
        return
      }
      const config = {
        file: files[0],
        maxSize: 800
      }
      const resizedImage = await _this.resizeImage(config)
      if (resizedImage) {
        _this.$emit('load', resizedImage)
        _this.preview = resizedImage
      }

      // check file max size

      // update file
      this.file = file
      this.$emit('file', file)

      var reader = new FileReader()

      reader.onload = function (e) {
        // var dataURI = e.target.result
        /*
        if (dataURI) {
          _this.$emit('load', dataURI)

          _this.preview = dataURI
        }
        */
      }

      // read blob url from file data
      reader.readAsDataURL(file)
    },
    resizeImage (settings) {
      var file = settings.file
      var maxSize = settings.maxSize
      var reader = new FileReader()
      var image = new Image()
      var canvas = document.createElement('canvas')
      var resize = function () {
        var width = image.width
        var height = image.height
        if (width > height) {
          if (width > maxSize) {
            height *= maxSize / width
            width = maxSize
          }
        } else {
          if (height > maxSize) {
            width *= maxSize / height
            height = maxSize
          }
        }
        canvas.width = width
        canvas.height = height
        canvas.getContext('2d').drawImage(image, 0, 0, width, height)
        var dataUrl = canvas.toDataURL('image/jpeg')
        return dataUrl // dataURItoBlob(dataUrl)
      }
      return new Promise(function (resolve, reject) {
        if (!file.type.match(/image.*/)) {
          reject(new Error('Not an image'))
          return
        }
        reader.onload = function (readerEvent) {
          image.onload = function () {
            return resolve(resize())
          }
          image.src = readerEvent.target.result
        }
        reader.readAsDataURL(file)
      })
    }
  }
}
</script>
