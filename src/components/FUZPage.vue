<template>
    <div bordered>
    <component v-for="(r,i) in rows" :key="'r'+i" :is="r.is" v-bind="r.props">
        <component v-for="(c,ci) in r.cols" :key="'r'+i+'c'+ci"
        :is="c.is" v-bind="c.props" />
    </component>
    </div>
</template>
<script>
import m from '../utils/M'
import FUZList from './FUZList'
import FUZNew from './FUZNew'
import FUZListSearchPage from './FUZListSearchPage'
import { QInput, QCard } from 'quasar'

export default {
  name: 'FUZPage',
  data () {
    return {
      rows: []
    }
  },
  async mounted () {
    const data = await m('getPageData^FUZPage', { routine: this.$route.meta.routine })
    this.rows = data.page.rows
  },
  methods: {
    clickChildButton (btn) {
      this.$store.dispatch('app/setSalonChildBreadCrumps', btn.name)
      if (this.$route.path !== btn.path) {
        this.$store.dispatch('app/changeRoute', btn.path)
      } else {
        this.$store.dispatch('app/updateRouterKey')
      }
    }
  },
  components: {
    FUZList,
    FUZNew,
    QInput,
    FUZListSearchPage,
    QCard
  }
}
</script>
