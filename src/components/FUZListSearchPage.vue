<template>
  <q-card>
     <q-card-section>
        <div class="text-h6">Search {{type | lowercase}} to edit</div>
      </q-card-section>

       <q-card-section class="q-pt-none">
          <FUZListSearch :type="type" :routine="routine" :selectItems="selectItems" v-model="id" :label="label"/>
      </q-card-section>
       <q-card-section class="q-pt-none">
          <FUZNew :type="type" :routine="routine" v-if="id && !!id.id && id.id!=='*'" :id.sync="id.id" :key="'id-'+id.id" />
      </q-card-section>
    </q-card>
</template>
<script>
import FUZListSearch from './FUZListSearch'
import FUZNew from './FUZNew'
export default {
  data () {
    return {
      id: null,
      editId: ''
    }
  },
  filters: {
    lowercase: function (value) {
      if (!value) return ''
      return value.toLowerCase()
    }
  },
  components: {
    FUZListSearch,
    FUZNew
  },
  props: ['type', 'routine', 'selectItems', 'label'],
  methods: {

  },
  async created () {
  }
}
</script>
