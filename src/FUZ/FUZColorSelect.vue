<template>
   <q-select
              v-bind="$props"
              rounded
              outlined
              v-model="currentStaffColor"
              @input="setSelectedValue"
              :options="colorOptions"
              option-value="color"
              behavior="dialog"
            >
                   <template v-slot:prepend>
          <q-avatar  :color="currentStaffColor.color" />
        </template>
              <template v-slot:option="scope">
                <q-item
                  v-bind="scope.itemProps"
                  v-on="scope.itemEvents"
                >
                  <q-item-section :class="'bg-'+scope.opt.color">
                    <q-item-label class="text-black text-bold">{{ scope.opt.label }}</q-item-label>
                  </q-item-section>
                </q-item>
              </template>
            </q-select>
</template>

<script>
export default {
  name: 'FUZColorSelect',
  props: ['value', 'label'],
  data () {
    return {
      currentStaffColor: this.value,
      colorOptions: [
        { color: 'FUZ-light-pink', label: 'Light Pink' },
        { color: 'FUZ-light-purple', label: 'Light Purple' },
        { color: 'FUZ-light-violet', label: 'Light Violet' },
        { color: 'FUZ-light-blue', label: 'Light Blue' },
        { color: 'FUZ-green-blue', label: 'Light Green Blue' },
        { color: 'FUZ-green', label: 'Green' },
        { color: 'FUZ-light-green', label: 'Light Green' },
        { color: 'FUZ-light-yellow', label: 'Light Yellow' },
        { color: 'FUZ-yellow', label: 'Yellow' },
        { color: 'FUZ-orange', label: 'Orange' },
        { color: 'red-4', label: 'Red' },
        { color: 'pink-4', label: 'Pink' },
        { color: 'purple-4', label: 'Purple' },
        { color: 'deep-purple-4', label: 'Deep Purple' },
        { color: 'indigo-4', label: 'Indigo' },
        { color: 'blue-4', label: 'Blue' },
        { color: 'light-blue-4', label: 'Light-Blue' },
        { color: 'cyan-4', label: 'Cyan' },
        { color: 'teal-4', label: 'Teal' },
        { color: 'green-4', label: 'Green' },
        { color: 'light-green-4', label: 'Light Green' },
        { color: 'lime-4', label: 'Lime' },
        { color: 'yellow-4', label: 'Yellow' },
        { color: 'amber-4', label: 'Amber' },
        { color: 'orange-4', label: 'Orange' },
        { color: 'deep-orange-4', label: 'Deep Orange' },
        { color: 'brown-4', label: 'Brown' }
      ]
    }
  },
  components: {
  },
  methods: {
    setSelectedValue (value) {
      this.$emit('input', value)
      this.$emit('change', value)
    }
  }
}
</script>
