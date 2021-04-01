<template>
<q-layout>
    <q-page-container>
      <q-page class="flex flex-center">
      <cv-form>
            <FUZNumberInput :props="props" v-model="model" />
           <cv-code-snippet kind="multiline">
            {{JSON.stringify($data,null,4)}}
            </cv-code-snippet>
      </cv-form>
    </q-page>
    </q-page-container>
 </q-layout>
</template>
<script>
import FUZNumberInput from './FUZNumberInput'
export default {
  name: 'FUZNumberInputDocs',
  components: {
    FUZNumberInput
  },
  data () {
    return {
      model: 5,
      props: {
        label: 'label',
        disabled: false,
        placeholder: 'Placeholder',
        helperText: 'helperText',
        invalidText: '',
        required: true,
        min: 0,
        max: 99999,
        styleXS: '',
        styleMD: '',
        styleLG: '',
        styleXL: '',
        baseStyle: '',
        mask: '',
        props: {},
        numberStep: 5,
        mobileView: true
      }
    }
  },
  methods: {
  }
}
</script>
