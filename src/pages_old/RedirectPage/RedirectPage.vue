<template>
<q-layout>
    <q-page-container>
      <q-page class="flex flex-center" style="width:100vw;height:100vh;background-image:linear-gradient(#48c6ef,#6f86d6);">
      {{JSON.stringify($route.path) + 'ss'}}
      </q-page>
    </q-page-container>
 </q-layout>
</template>
<script>
export default {
  name: 'RedirectPage',
  mounted () {
    let route = '/' + this.$route.fullPath.split('/redirect/')[1]
    if (!route) {
      route = '/'
    }
    this.$router.push(route)
  }
}
</script>
