<template>
<div>
<q-item v-for="(row,index) in definition" :key="'row'+index">
        <q-item-section v-bind="col" v-for="(col,colIndex) in row" :key="'row'+index+'col'+colIndex"
         >
          <div :class="{'row':col.newline}">
            <q-skeleton v-bind="col" />
            </div>
        </q-item-section>
      </q-item>
</div>
</template>
<script>
export default {
  props: ['definition'],
  data () {
    return {

    }
  }
}
</script>
