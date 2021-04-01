<template>
  <div :class="{'fullscreen text-center q-pa-md flex flex-center bg-black text-white':$q.localStorage.getItem('dark-mode'),'fullscreen text-center q-pa-md flex flex-center bg-white text-black':!$q.localStorage.getItem('dark-mode')}">
    <div>
      <div class="text-h2" style="opacity:.4">
        You've been logged out!
      </div>

      <q-btn
        :size="'xl'"
        class="q-mt-xl"
        rounded
        outline
        unelevated
        to="/login"
        label="Login"
        no-caps
      />
    </div>
  </div>
</template>

<script >
export default {
  name: 'ErrorLoggedOut'
}
</script>
