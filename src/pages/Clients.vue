<template>

<q-page class="">
   <q-card>
    <div class="flex flex-center">
    <div class="q-gutter-sm" :style="'width:80vw;min-width:380px;padding:10px'">
      <br>
      <q-input
        filled
        bottom-slots
        v-model="searchText"
        label="Search Clients"
        style="width:38vw;max-width:800px;min-width:350px"
        @input="debouncedHandleMounted"
      >
        <template v-slot:append>
          <q-icon v-if="searchText !== ''" name="close" @click="resetSearch" class="cursor-pointer" />
          <q-icon name="search" />
        </template>
      </q-input>
      <br />
      <div v-for="(client,cindex) in list" :key="'C'+cindex">
        <q-item clickable v-ripple :to="'/client/'+client.id">
          <q-item-section top>
            <q-item-label lines="1">
              <q-item-label>
                <q-avatar color="teal" text-color="white" size="lg">{{ client.name[0] }}</q-avatar>&nbsp;
                <span class="text-weight-medium">{{client.name}}</span>&nbsp;&nbsp;&nbsp;&nbsp;
              <q-item-label caption class="text-bold">{{ client.number }}</q-item-label>
              <q-item-label caption v-if="client.lasthere && client.lasthere.length" class="text-primary">{{ client.lasthere}} - {{ client.laststaff}}</q-item-label>
              <q-item-label caption v-if="client.lastitem && client.lastitem.length" >{{ client.lastitem}}</q-item-label>
              </q-item-label>
            </q-item-label>
          </q-item-section>
        </q-item>
        <q-separator spaced />
      </div>
    </div>
</div>
</q-card>
</q-page>
</template>
<script>
import { debounce } from 'quasar'

export default {
  data () {
    return {
      list: [],
      searchText: '',
      debouncedHandleMounted: ''
    }
  },
  components: {
  },
  async mounted () {
    await this.handleMounted()
  },
  created () {
    this.debouncedHandleMounted = debounce(this.handleMounted, 500)
  },
  methods: {
    async handleMounted () {
      const data = await this.$M('getClients^CLIENTS', {
        searchText: this.searchText
      })
      if (data && data.data && data.data.list) {
        this.list = data.data.list
      }
    },
    async resetSearch () {
      this.searchText = ''
      await this.handleMounted()
    }
  }
}
</script>
