<template>
   <q-select
        :key="key"
        :style="'background-color:var(--c-ui-01);'"
        ref="FUZListSearchMini"
        :value="value"
        use-input
        input-debounce="100"
        :label="label"
        option-value="id"
        option-label="name"
        :options="options"
        @filter="filterFn"
        :behavior="$q.screen.lt.md === true ? 'dialog' : 'menu'"
        rounded
        outlined
        @input="setSelectedValue"
        @popup-hide="hidePopup"
      >
      <template v-slot:option="scope" v-if="selectItems">
          <q-item
           :style="'background-color:var(--c-ui-01);'"
            v-bind="scope.itemProps"
            v-on="scope.itemEvents"
          >
            <q-item-section :avatar="!!selectItems.avatar" v-if="!!selectItems.avatar">
              <q-avatar size="50px">
                 <img :src="typeof scope.opt[selectItems.avatar] === 'object' ? scope.opt[selectItems.avatar].join(''):scope.opt[selectItems.avatar]">
              </q-avatar>
            </q-item-section>
            <q-item-section>
              <q-item-label>{{ scope.opt[selectItems.label]  }}</q-item-label>
              <q-item-label caption v-for="(caption,captionIndex) in selectItems.caption" :key="'caption-'+captionIndex">{{ scope.opt[caption]  }}</q-item-label>
            </q-item-section>
          </q-item>
        </template>
        <template v-slot:no-option>
              <FUZNewSubSub :noHeader="noHeader" :key="type+''" :type="type" :routine="routine" @updateSingle="updateSingle" :noRerouteAfterSave="true" :id="'*'" />
        </template>
          <template v-slot:append v-if="clearable">
          <q-icon name="close" @click="clearSelected" class="cursor-pointer" />
        </template>
      </q-select>
</template>
<script>
import FUZNewSubSub from './FUZNewSubSub'
import { uid } from 'quasar'
export default {
  name: 'FUZListSearchMini',
  data () {
    return {
      model: typeof this.value === 'object' ? '' : this.value,
      options: [],
      list: [],
      key: uid(),
      clearable: false
    }
  },
  components: {
    FUZNewSubSub
  },
  props: ['type', 'routine', 'selectItems', 'value', 'label', 'noHeader', 'donotSelectFist'],
  methods: {
    filterValue (value) {
      value = this.list.filter(option => typeof value === 'string' ? option.id === value : option.id === value.id)
      return value
    },
    hidePopup (e) {},
    clearSelected () {
      this.clearable = false
      this.$set(this.$data, 'model', null)
      this.$emit('input', '')
      this.$emit('change', '')
      this.key = uid()
    },
    updateSingle (value) {
      this.$emit('input', value)
      this.$emit('change', value)
      this.list = this.list || []
      this.list.push(value)
      this.options = [value]
      this.model = value
      this.$refs.FUZListSearch.hidePopup()
    },
    setSelectedValue (value) {
      this.$emit('input', value)
      this.$emit('change', value)
    },
    async filterFn (val, update) {
      if (val === '') {
        this.clearable = false
        update(() => {
          this.options = this.list
        })
        return
      }
      this.clearable = true
      update(async () => {
        const list = await this.$m('GetList^FUZLIST', {
          type: this.type,
          routine: this.routine,
          search: val
        })
        this.options = list.list || []
      })
    }
  },
  async created () {
    const list = await this.$m('GetList^FUZLIST', {
      type: this.type,
      routine: this.routine,
      search: ''
    })
    this.list = list.list
    if (this.list.length === 1 && !this.value && !this.donotSelectFist) {
      this.model = this.list[0]
      this.$emit('input', this.model)
      this.$emit('change', this.model)
    }
  }
}
</script>
