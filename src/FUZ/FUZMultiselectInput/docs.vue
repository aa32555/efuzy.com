<template>
<q-layout>
    <q-page-container>
      <q-page class="flex flex-center">
      <cv-form>
            <FUZMultiselectInput :props="props" v-model="model" />
           <cv-code-snippet kind="multiline">
            {{JSON.stringify($data,null,4)}}
            </cv-code-snippet>
      </cv-form>
    </q-page>
    </q-page-container>
 </q-layout>
</template>
<script>
import FUZMultiselectInput from './FUZMultiselectInput'
export default {
  name: 'FUZMultiselectInputDocs',
  components: {
    FUZMultiselectInput
  },
  data () {
    return {
      model: [],
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
        props: {},
        options: [
          { name: 'a1', value: 'Abc', label: 'hahah1' },
          { name: 'a2', value: 'Abc2', label: 'hahah2' },
          { name: 'a3', value: 'Abc3', label: 'hahah3' }
        ]
      }
    }
  },
  methods: {
  }
}
</script>
