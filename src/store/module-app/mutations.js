import Vue from 'vue'

export function updateRouterKey (state, val) {
  state.routerKey = val
}

export const setSessionDetails = (state, val) => {
  Vue.set(state, 'session', Object.freeze(val))
}
export const setSalonBreadCrumps = (state, val) => {
  Vue.set(state, 'salonBreadCrumps', val)
}

export const setSalonChildBreadCrumps = (state, val) => {
  Vue.set(state, 'salonChildBreadCrumps', val)
}
export const setSalonBreadCrumpsChildren = (state, val) => {
  Vue.set(state, 'salonBreadCrumpsChildren', val)
}

export const setAppDetails = (state, val) => {
  Vue.set(state, 'app', val)
}

export const showFUZDialog = (state, val) => {
  Vue.set(state.controller, 'FUZDialog', val)
  // state.controller.FUZDialog = true
  // state.controller.FUZDialogProps = val
  // console.log(state)
}

export const hideFUZDialog = (state, val) => {
  state.controller.FUZDialog = false
  state.controller.FUZDialogProps = {}
}
export const showFUZListEditDialog = (state, val) => {
  Vue.set(state.app, 'FUZListEditDialog', val)
}

export const setAjaxLoading = (state, val) => {
  Vue.set(state, 'ajaxLoading', !!val)
}

export const refreshEvents = (state, val) => {
  state.refreshEvents = val
}
export function setLogo (state, val) {
  state.logo = val
}
