<template>
  <cv-header :aria-label="`${label?label:''} header`" :style="'background-color:var(--c-toolbar-bg);height:46px;font-color:var(--c-toolbar-color);'+getStyle" :class="'absolute absolute-top'+ getClass" >
    <cv-header-name :to="to?to:undefined" @click="raiseEvent?emit(raiseEvent,eventData):undefined" prefix="">
      {{label}}
    </cv-header-name>
    <cv-header-nav :aria-label="`${label} header`" v-if="mainNav" >
      <component v-for="(item,i) in mainNav" :key="i + key" :is="!item.children?'cv-header-menu-item':'cv-header-menu'" :to="item.to?item.to:undefined" :aria-label="(item.label && item.children) ? item.lable:undefined" :title="(item.label && item.children) ? item.label:undefined"
        @click="item.raiseEvent?emit(item.raiseEvent,item.eventData):undefined">
        <div v-if="item.children">
          <component :is="!subitem.children?'cv-header-menu-item':'cv-header-menu'" :style="'background-color:var(--c-toolbar-bg);height:46px;font-color:var(--c-toolbar-color);'"
          v-for="(subitem,k) in item.children" :key="k + key"
          :to="subitem.to?subitem.to:undefined"
           @click="subitem.raiseEvent?emit(subitem.raiseEvent,subitem.eventData):undefined"
           :aria-label="(subitem.label && subitem.children) ? subitem.lable:undefined" :title="(subitem.label && subitem.children) ? subitem.label:undefined"
           >
            {{! subitem.children? subitem.label:''}}

        <div v-if="subitem.children">
        <component :is="!subsubitem.children?'cv-header-menu-item':'cv-header-menu'" :style="'background-color:var(--c-toolbar-bg);height:46px;font-color:var(--c-toolbar-color);'"
          v-for="(subsubitem,m) in subitem.children" :key="'subsunheader'+m + key"
          :to="subsubitem.to?subsubitem.to:undefined"
           @click="subsubitem.raiseEvent?emit(subsubitem.raiseEvent,subitem.eventData):undefined"
           :aria-label="(subsubitem.label && subsubitem.children) ? subsubitem.lable:undefined" :title="(subsubitem.label && subsubitem.children) ? subsubitem.label:undefined"
           >
            {{! subsubitem.children? subsubitem.label:''}}
          </component>
          </div>

          </component>
        </div>
        {{!item.children?item.label:''}}
      </component>

    </cv-header-nav>
        <template v-slot:left-panels >

  <cv-side-nav v-if="sideNav" id="side-nav" :rail="true" fixed :expanded="true" :reveal="false" :style="leftSideNavStyle">
       <cv-side-nav-link to="javascript:void(0)">

        </cv-side-nav-link>
        <cv-side-nav-link to="javascript:void(0)">
        <q-icon name="code" style="font-size: 2em;padding:0px" color="white" />
        </cv-side-nav-link>
    </cv-side-nav>
    </template>
    <template v-slot:header-global>
      <slot></slot>
      </template>
  </cv-header>
</template>
<script>

import FUZMixin from '../FUZMixin'
import FUZIcon from '../FUZIcon'

export default {
  name: 'FUZHeader',
  mixins: [FUZMixin],
  components: {
    FUZIcon
  },
  data () {
    return {
      key: this.newUID()
    }
  },
  props: {
    leftSideNavStyle: {
      default: '',
      type: String
    },
    to: {
      default: '',
      type: String
    },
    label: {
      default: '',
      type: String
    },
    raiseEvent: {
      default: '',
      type: String
    },
    eventData: {
      type: Object
    },
    mainNav: {
      type: Array
    },
    sideNav: {
      default: false
    }
  },
  methods: {
    defaultProps () {
      return {
        leftSideNavStyle: '',
        to: '',
        label: '',
        reaiseEvent: '',
        eventData: {},
        mainNav: []
      }
    }
  }
}
</script>
