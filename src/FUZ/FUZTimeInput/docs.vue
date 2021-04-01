<template>
<q-layout>
    <q-page-container>
      <q-page class="flex flex-center">
      <cv-form class="row">
            <FUZTimeInput :props="props" v-model="model" class="col-12" />
           <cv-code-snippet kind="multiline">
            {{JSON.stringify($data,null,4)}}
            </cv-code-snippet>
      </cv-form>
    </q-page>
    </q-page-container>
 </q-layout>
</template>
<script>
import FUZTimeInput from './FUZTimeInput'
export default {
  name: 'FUZTimeInputDocs',
  components: {
    FUZTimeInput
  },
  data () {
    return {
      model: '12:01 AM',
      props: {
        label: 'label',
        title: 'title',
        disabled: false,
        placeholder: 'Placeholder',
        helperText: 'helperText',
        invalidText: '',
        required: true,
        styleXS: '',
        styleMD: '',
        styleLG: '',
        styleXL: '',
        baseStyle: '',
        props: {}
      }
    }
  },
  methods: {
  }
}
</script>
