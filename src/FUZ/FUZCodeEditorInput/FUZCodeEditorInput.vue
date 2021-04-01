<template>
    <div :style="'height:100%:width:100%;'+getStyle" :class="getClass">
      <div style="padding:10px;">{{label?label:''}}</div>
    <codemirror ref="modelInput"
    v-bind="$props"
    @input="emitInput"
    :dbField="dbField"
    :value="value"
    @blur="$v.model.$touch"
    :disabled="disabled"
    :options="{
      tabSize,
      mode,
      theme,
      line,
      lineNumbers
    }"
    @ready="onReady?emitEvent(onReady):undefined"
    @focus="onFocus?emitEvent(onFocus):undefined"
    />
    </div>
</template>
<script>
import FUZInputMixin from '../FUZInputMixin'
import {
  codemirror
} from 'vue-codemirror'
import 'codemirror/mode/javascript/javascript.js'
import 'codemirror/mode/vue/vue.js'
export default {
  name: 'FUZCodeEditorInput',
  mixins: [FUZInputMixin],
  props: {
    onReady: {
      default: '',
      type: String
    },
    onFocus: {
      default: '',
      type: String
    },
    value: {
      default: '',
      type: String
    },
    tabSize: {
      default: 4,
      type: Number
    },
    mode: {
      default: 'application/ld+json', // 'text/x-vue' || application/ld+json || ...
      type: String
    },
    theme: {
      default: 'base16-dark',
      type: String
    },
    line: {
      default: true,
      type: Boolean

    },
    lineNumbers: {
      default: true,
      type: Boolean
    },
    label: {
      type: String
    }
  },
  components: {
    codemirror
  },
  methods: {
    defaultProps () {
      return {
        onReady: 'COMPONENTS_EDITOR_READY',
        onFocus: 'COMPONETNS_EDITOR_FOCUS',
        tabSize: 4,
        mode: 'application/ld+json',
        theme: 'base16-dark',
        line: true,
        lineNumber: true
      }
    },
    editorInstance () {
      return this.$refs.modelInput.codemirror
    }
  }
}
</script>
<style>
    @import '~codemirror/lib/codemirror.css';
    @import '~codemirror/theme/base16-dark.css';
     .CodeMirror {

  height:100% !important;
  font-size: 14px;
}

</style>
