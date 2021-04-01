import Vue from 'vue'

export function setList (state, val) {
  Vue.set(state.list, val.type, val.data)
}

export function refreshList (state, val) {
  Vue.set(state.refresh, val.type, !state.refresh[val.type])
}
