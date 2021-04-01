<template>
  <div class="flex flex-center" :style="'width:350px;background-color:'+(color.hex)" >
          <div class="row q-pa-md" style="font-size:16px" :style="'background-color:'+(color.hex)">{{label}}</div>
          <div class="row" >
      <q-color :style="'color:'+($q.dark.isActive?'#FFFFFF;':'#000000;')+('background-color:'+($q.dark.isActive?'#000000;':'#FFFFFF;'))" v-model="color.hex" no-header  @input="setSelectedValue" @change="setSelectedValue" format-model="hex" flat  />
      <q-input v-model="color.hex" no-header  @input="setSelectedValue" @change="setSelectedValue" />
      </div></div>
</template>

<script>
export default {
  name: 'FUZColorPicker',
  data () {
    return {
      color: {
        hex: this.value
      }
    }
  },
  props: ['value', 'label'],
  components: {
  },
  methods: {
    setSelectedValue (value) {
      this.$emit('input', this.color.hex)
      this.$emit('change', this.color.hex)
    }
  }
}
</script>
