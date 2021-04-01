<template>
 <div :class="'fullscreen text-center q-pa-md flex flex-center'">
    <div>
      <div style="font-size: 30vh">
        401
      </div>

      <div class="text-h2" style="opacity:.4">
        Not Allowed!
      </div>

      <q-btn
        :size="'xl'"
        class="q-mt-xl"
        rounded
        outline
        unelevated
        to="/"
        label="Go Home"
        no-caps
      />
    </div>
  </div>
</template>

<script >
export default {
  name: 'Error404',
  created () {
    this.$q.dark.set(!!this.$q.localStorage.getItem('dark-mode'))
  }
}
</script>
