<script>
import { required, minLength, maxLength } from 'vuelidate/lib/validators'
import { validationMessage } from 'vuelidate-messages'
import FUZMixin from '../FUZMixin'
export default {
  name: 'FUZInputMixin',
  mixins: [FUZMixin],
  props: {
    required: {
      default: false,
      type: Boolean
    },
    disabled: {
      default: false,
      type: Boolean
    },
    dbField: {
      default: '',
      type: String
    },
    label: {
      default: '',
      type: String
    },
    placeholder: {
      default: '',
      type: String
    },
    helperText: {
      default: '',
      type: String
    },
    invalidText: {
      default: '',
      type: String
    },
    invalidMessage: {
      default: '',
      type: String
    },
    mask: {
      default: '',
      type: String
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
    defaultProps () {
      return {
        label: 'Text Area label',
        required: true,
        disabled: false,
        placeholder: 'Place holder',
        helperText: 'Helper text',
        invalidText: 'Invalid text',
        invalidMessage: 'Invalid message',
        dbmodel: 'dbmodel'
      }
    },
    emitInput (event) {
      this.$nextTick(() => {
        this.$emit('input', event)
      })
    },
    emitChange (event) {
      this.$nextTick(() => {
        this.$emit('change', event)
      })
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
    }
  }
}
</script>
