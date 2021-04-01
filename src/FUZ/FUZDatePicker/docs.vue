<template>
<q-layout>
    <q-page-container>
      <q-page class="flex flex-center">
      <cv-form>
            <FUZDatePicker :props="props" v-model="model" ref="component" />
           <cv-code-snippet kind="multiline">
            {{JSON.stringify($data,null,4)}}
            </cv-code-snippet>
      </cv-form>
    </q-page>
    </q-page-container>
 </q-layout>
</template>
<script>
import FUZDatePicker from './FUZDatePicker'
export default {
  name: 'FUZDatePickerDocs',
  components: {
    FUZDatePicker
  },
  data () {
    return {
      model: '',
      props: {
        label: 'label',
        disabled: false,
        placeholder: 'Placeholder',
        helperText: 'helperText',
        invalidText: '',
        required: true,
        min: 0,
        max: 0,
        styleXS: '',
        styleMD: '',
        styleLG: '',
        styleXL: '',
        baseStyle: '',
        mask: '####-###',
        type: 'range',
        props: {}
      }
    }
  },
  methods: {
  }
}
</script>
