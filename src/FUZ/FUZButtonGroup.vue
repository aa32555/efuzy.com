<template>
    <q-btn-dropdown v-bind="groupProps">

         <q-list>
        <q-item
        v-for="(button,buttonIndex) in buttons"
        :key="'button'+buttonIndex"
        :v-bind="button.props"
        clickable v-close-popup @click="
        button.onClick && button.action === 'routine'?runRoutine(button.onClick,button.type,src)
        :''" >
          <q-item-section>
            <q-item-label>{{button.title}}</q-item-label>
          </q-item-section>
        </q-item>
         </q-list>
    </q-btn-dropdown>
</template>
<script>
export default {
  data () {
    return {

    }
  },
  props: ['buttons', 'groupProps', 'singleProps', 'src'],
  methods: {
    async runRoutine (action, type, id) {
      await this.$m(action, { type, id })
    }
  }
}
</script>
