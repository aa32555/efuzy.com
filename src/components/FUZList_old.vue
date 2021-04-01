<template>
  <div :class="''" >
    <q-card :class="'q-pa-md  ' + (!this.$q.dark.isActive ? ' bg-white' : '')" >
       <div class="q-pa-md q-gutter-sm" style="width:80vw;min-width:380px;padding:10px;max-width:1200px;">
      <q-breadcrumbs>
        <q-breadcrumbs-el
          label="Home"
          to="/"
        />
        <q-breadcrumbs-el
          :label="$route.name"
        />
      </q-breadcrumbs>
    </div>
      <FUZSkeleton :definition="skeleton" v-if="!loaded" />
      <q-list v-if="loaded" padding bordered>
        <div>
          <FUZIcon
            class="float-left"
            path="LoadingScissors"
            :width="60"
            :height="60"
            :loop="false"
          />
        </div>
        <q-item-label v-if="header" header class="text-h6"
          >{{ header }}
          <q-btn
            class="float-right"
            rounded
            v-for="(b, i) in buttons"
            :key="'button-' + i"
            label-position="left"
            :color="b.color"
            :icon="b.icon"
            :label="b.label"
          />&nbsp;
          <q-btn
            class="float-right"
            rounded
            label-position="left"
            icon="search"
            label="Search"
            @click="searchButton"
            flat
          />
          &nbsp;
        <q-toggle
        v-if="orderable"
        class="float-right"
        color='green'
        style="font-size:15px"
        v-model="isOrderable"
        size="xs"
        label="CHANGE ORDER"
      />
          &nbsp;
        </q-item-label>
        <q-item v-if="searchBar">
          <q-input
            rounded
            outlined
            v-model="search"
            label="Search"
            class="full-width"
            @input="refreshList"
          >
            <template v-slot:prepend>
              <q-icon name="search" />
            </template>
            <template v-slot:append>
              <q-icon
                name="close"
                @click="searchButton"
                class="cursor-pointer"
              />
            </template>
          </q-input>
        </q-item>
        <div class="text-center" v-if="(!list || !list.length) && loaded">
          <FUZIcon path="AddToList" :width="300" :height="300" :loop="true" />
          <q-btn
            :size="'lg'"
            class="q-mt-md text-center"
            text-color="primary"
            rounded
            outline
            unelevated
            :label="emptyListText"
            no-caps
            @click="addNew"
          />
        </div>
        <q-item> </q-item>
        <component :is="isOrderable?'draggable':'div'" v-model="list" handle=".dragHandler" @end="dragEnd" >
          <transition-group
            appear
            enter-active-class="animated fadeIn"
            leave-active-class="animated fadeOut"
          >
            <q-item v-for="(row, rowIndex) in list" :key="'row' + rowIndex" style=" border-bottom: 1px solid grey;">
              <q-btn v-if="isOrderable" flat rounded icon="drag_indicator" class="dragHandler" :key="'row' + rowIndex + 'dragcol'" />
              <component
                v-for="(def, defIndex) in definition"
                v-bind="def.component.props"
                :key="'row' + rowIndex + 'col' + defIndex"
                :is="def.component.is"
              >
                {{ def.component.insertValue && row[def.model] }}
                <component
                  v-if="def.subComponent"
                  v-bind="def.subComponent.props"
                  :is="def.subComponent.is"
                  :src="
                    def.subComponent.props &&
                    def.subComponent.props.src === 'insertValue'
                      ? typeof row[def.model] === 'object'
                        ? row[def.model].join('')
                        : row[def.model]
                      : undefined
                  "
                  :value="
                    def.subComponent.props &&
                    def.subComponent.props.value === 'insertValue'
                      ? typeof row[def.model] === 'object'
                        ? row[def.model].join('')
                        : row[def.model]
                      : undefined
                  "
                  @click="
                    def.subComponent.is === 'span' &&
                    def.subComponent.props.toID
                      ? $store.dispatch(
                          'app/changeRoute',
                          def.subComponent.props.toID + row.id
                        )
                      : undefined
                  "
                >
                  {{ def.subComponent.insertValue && row[def.model] }}
                  <component
                    v-if="def.subSubComponent"
                    v-bind="def.subSubComponent.props"
                    :is="def.subSubComponent.is"
                    :src="
                      def.subSubComponent.props &&
                      def.subSubComponent.props.src === 'insertValue'
                        ? typeof row[def.model] === 'object'
                          ? row[def.model].join('')
                          : row[def.model]
                        : undefined
                    "
                    @click="
                      def.subSubComponent.is === 'span' &&
                      def.subSubComponent.props.toID
                        ? $store.dispatch(
                            'app/changeRoute',
                            def.subSubComponent.props.toID + row.id
                          )
                        : undefined
                    "
                  >
                    {{
                      def.subSubComponent.insertValue === true
                        ? row[def.model]
                        : ""
                    }}
                  </component>
                </component>
              </component>
            </q-item>
          </transition-group>
        </component>
      </q-list>
    </q-card>

    <q-dialog
      v-model="newDialog"
      persistent
      :maximized="true"
      transition-show="slide-up"
      transition-hide="slide-down"
    >
      <FUZNew
        @updateSingle="updateSingle"
        :type="type"
        @dismiss="dismissNewDialog"
        :id="selectedId"
      >
        <slot name="form-skeleton"></slot>
      </FUZNew>
    </q-dialog>
  </div>
</template>

<script>
import m from '../utils/M'
import FUZNew from './FUZNew'
import FUZSkeleton from './FUZSkeleton'
import FUZButtonGroup from './FUZButtonGroup'
import {
  QItemSection,
  QItemLabel,
  QIcon,
  QAvatar,
  QBtn,
  QSeparator
} from 'quasar'
import FUZIcon from './FUZIcon'
import FUZImg from './FUZImg'
import draggable from 'vuedraggable'
export default {
  props: ['routine', 'type', 'header', 'buttons', 'skeleton', 'emptyListText', 'orderable'],
  data () {
    return {
      // list: [],
      search: '',
      fabButton: false,
      newDialog: false,
      loaded: false,
      definition: [],
      selectedId: '',
      searchBar: true,
      loopIcon: false,
      listOrder: [],
      isOrderable: !!this.orderable
    }
  },
  components: {
    FUZNew,
    FUZSkeleton,
    QItemSection,
    QItemLabel,
    QIcon,
    QAvatar,
    QBtn,
    FUZButtonGroup,
    FUZIcon,
    FUZImg,
    QSeparator,
    draggable
  },
  async mounted () {
    await this.refreshList()
  },
  computed: {
    list: {
      get () {
        return this.$store.getters['list/list'](this.type)
      },
      set (value) {
        this.$store.dispatch('list/setList', {
          type: this.type,
          data: value
        })
      }
    },
    refresh () {
      return this.$store.getters['list/refresh'](this.type)
    }
  },
  watch: {
    async refresh (v) {
      await this.refreshList()
    }
  },
  methods: {
    async dragEnd () {
      const orderedList = this.list && this.list.map((row) => {
        return row.id
      })
      await this.$m('saveOrderedList^FUZLIST', {
        type: this.type,
        list: orderedList
      })
      /*
      if (status.status) {
        this.$q.notify({
          message: 'Order Saved',
          color: 'success',
          multiLine: true
        })
      }
      */
    },
    async searchButton () {
      this.searchBar = !this.searchBar
      this.search = ''
      await this.refreshList()
    },
    async refreshList () {
      const list = await m('GetList^FUZLIST', {
        type: this.type,
        routine: this.routine,
        search: this.search
      })

      this.list = list.list
      this.definition = list.definition
      // await this.dragEnd()
      this.loaded = true
    },
    addNew () {
      this.selectedId = ''
      this.$nextTick(() => {
        // this.newDialog = true
        this.$store.dispatch('app/changeRoute', '/' + this.type + '/edit/*')
      })
    },
    async updateSingle (id) {
      /*
      const result = await this.$m('updateSingle^FUZLIST', { id: id.id, type: this.type })
      const elementIndex = this.list.findIndex(element => element.id === id.id)
      if (!elementIndex) {
        return
      }
      const newArray = [...this.list]
      newArray[elementIndex] = { ...result.updated }
      // this.$set(this.$data, 'list', newArray)
      // await this.refreshList()
      */
      await this.refreshList()
    },
    async dismissNewDialog () {
      this.newDialog = false
      this.selectedId = ''
      // this.$store.dispatch('app/showFUZListEditDialog', '')
      // await this.refreshList()
    }
  }
}
</script>
