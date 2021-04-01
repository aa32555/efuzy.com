<script>
import { required, minLength, maxLength } from 'vuelidate/lib/validators'
import { validationMessage } from 'vuelidate-messages'

export default {
  name: 'FUZInputMixin',
  props: ['props', 'value'],
  mounted () {

  },
  data () {
    return {
      model: this.value,
      title: this.props.label,
      label: this.props.label,
      required: !!this.props.required,
      disabled: !!this.props.disabled,
      placeholder: this.props.placeholder || '',
      helperText: this.props.helperText || '',
      invalidText: this.props.invalidText || '',
      styleXS: this.props.styleXS,
      styleMD: this.props.styleMD,
      styleLG: this.props.styleLG,
      styleXL: this.props.styleXL,
      baseStyle: this.props.baseStyle,
      invalidMessage: this.props.invalidMessage,
      mask: this.props.mask ? this.props.mask : undefined,
      minCharacters: this.props.minCharacters,
      maxCharacters: this.props.maxCharacters
    }
  },
  validations () {
    return {
      model: {
        required: this.required ? required : {},
        txtMinLen: this.minCharacters ? minLength(this.minCharacters) : {},
        txtMaxLen: this.maxCharacters ? maxLength(this.maxCharacters) : {}
      }
    }
  },
  methods: {
    updateModel (val) {
      this.$emit(val, this.model)
    },
    validationMsg (field) { return validationMessage(this.fieldMessages)(field) }
  },
  computed: {
    fieldMessages () {
      return {
        required: this.required ? () => 'Required' : undefined,
        txtMinLen: this.minCharacters ? ({ $params }) => `Must be at least ${$params.txtMinLen.min} characters.` : undefined,
        txtMaxLen: this.maxCharacters ? ({ $params }) => `Cannot Exceed ${$params.txtMaxLen.max} characters.` : undefined
      }
    },
    getStyle () {
      let style = ''
      if (this.styleXS && this.$q.screen.name === 'xs') {
        style = this.styleXS
      } else if (this.styleMD && this.$q.screen.name === 'md') {
        style = this.styleMD
      } else if (this.styleLG && this.$q.screen.name === 'lg') {
        style = this.styleLG
      } else if (this.styleXL && this.$q.screen.name === 'xl') {
        style = this.styleXL
      }
      if (this.baseStyle) {
        style = this.baseStyle + style
      }
      return style
    }

  }
}
</script>
