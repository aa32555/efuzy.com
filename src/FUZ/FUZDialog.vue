<template>
  <q-dialog ref="dialog" @hide="onDialogHide" persistent>
        <q-card class="q-dialog-plugin" flat bordered :style="!$q.platform.is.mobile?'width: 500px; max-width: 80vw;':'width: 400px; max-width: 90vw;'">
      <q-card-section horizontal>
        <q-card-section>
           <FUZIcon :path="iconPath" :width="iconWidth" :height="iconHeight" />
        </q-card-section>

        <q-separator vertical />

        <q-card-section class="flex flex-center">
         <span class="text-outline" style="word-break:break-word;font-size:16px">{{message}}</span>
        </q-card-section>
      </q-card-section>
              <q-card-actions class="justify-around q-px-md">
         <q-btn
         v-if="buttons && buttons.ok"
        :size="'md'"
        class="q-mt-md text-center"
        rounded
        outline
        unelevated
        label="OK"
        no-caps
        @click="hide()"
      />
      <q-btn
        v-if="buttons && buttons.cancel"
        :size="'md'"
        class="q-mt-md text-center"
        rounded
        outline
        unelevated
        label="Cancel"
        no-caps
        @click="hide()"
      />
           <q-btn
        v-if="buttons && buttons.run"
        :size="'md'"
        class="q-mt-md text-center"
        rounded
        outline
        unelevated
        :label="buttons.run.label"
        no-caps
        @click="runCallback(buttons.run.action,buttons.run.data)"
      />
        </q-card-actions>
    </q-card>
  </q-dialog>
</template>

<script>
import FUZIcon from './FUZIcon'
import m from '../utils/M'
export default {
  props: ['value', 'header', 'iconPath', 'iconWidth', 'iconHeight', 'message', 'buttons'],
  components: {
    FUZIcon
  },
  methods: {
    async runCallback (r, d) {
      this.hide()
      await m(r, d)
      this.$emit('doneCallBack')
    },
    // following method is REQUIRED
    // (don't change its name --> "show")
    show () {
      this.$refs.dialog.show()
    },
    // following method is REQUIRED
    // (don't change its name --> "hide")
    hide () {
      this.$refs.dialog.hide()
    },

    onDialogHide () {
      // required to be emitted
      // when QDialog emits "hide" event
      this.$emit('hide')
    },

    onOKClick () {
      // on OK, it is REQUIRED to
      // emit "ok" event (with optional payload)
      // before hiding the QDialog
      this.$emit('ok')
      // or with payload: this.$emit('ok', { ... })

      // then hiding dialog
      this.hide()
    },

    onCancelClick () {
      // we just need to hide dialog
      this.hide()
    }
  }
}
</script>
