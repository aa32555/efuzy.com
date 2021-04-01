
export function FUZDialog (state) {
  return state.controller && state.controller.FUZDialog
}

export function accountType (state) {
  return state.session && state.session.type
}

export function email (state) {
  return state.session && state.session.email
}
export function account (state) {
  return state.session && state.session.account
}
export function ajaxLoading (state) {
  return state.ajaxLoading
}

export function salonBreadCrumps (state) {
  return state.salonBreadCrumps
}

export function salonChildBreadCrumps (state) {
  return state.salonChildBreadCrumps
}
export function salonBreadCrumpsChildren (state) {
  return state.salonBreadCrumpsChildren
}

export function logo (state) {
  return state.logo
}
