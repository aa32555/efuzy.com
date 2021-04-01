import router from '../../router/index'
import { LocalStorage, uid } from 'quasar'
import m from '../../utils/M'
export function someAction (/* context */) {
}

export function setSessionDetails (ctx, val) {
  ctx.commit('setSessionDetails', val)
}

export async function logOut (ctx, val) {
  if (val) {
    const status = await m('LogOff^SALON')
    if (status.status) {
      LocalStorage.set('sessionDetails', undefined)
      LocalStorage.set('appDetails', undefined)
      ctx.commit('setSessionDetails', undefined)
      ctx.commit('setAppDetails', undefined)
      router.push('/logged_out')
    }
  } else {
    LocalStorage.set('sessionDetails', undefined)
    LocalStorage.set('appDetails', undefined)
    ctx.commit('setSessionDetails', undefined)
    ctx.commit('setAppDetails', undefined)
    router.push('/logged_out')
  }
}

export function setAppDetails (ctx, val) {
  ctx.commit('setAppDetails', val)
}

export function showFUZDialog (ctx, val) {
  ctx.commit('showFUZDialog', val)
}
export function setAjaxLoading (ctx, val) {
  ctx.commit('setAjaxLoading', val)
}
export function hideFUZDialog (ctx, val) {
  ctx.commit('hideFUZDialog', val)
}

export function showFUZListEditDialog (ctx, val) {
  ctx.commit('showFUZListEditDialog', val)
}
export function setSalonBreadCrumps (ctx, val) {
  ctx.commit('setSalonBreadCrumps', val)
}

export function setSalonChildBreadCrumps (ctx, val) {
  ctx.commit('setSalonChildBreadCrumps', val)
}

export function setSalonBreadCrumpsChildren (ctx, val) {
  ctx.commit('setSalonBreadCrumpsChildren', val)
}
export function changeRoute (ctx, val) {
  if (val === -1) {
    router.go(-1)
  } else {
    router.push(val)
  }
  // ctx.commit('updateRouterKey', uid())
}
export function updateRouterKey (ctx) {
  ctx.commit('updateRouterKey', uid())
}

export function refreshEvents (ctx, val) {
  ctx.commit('refreshEvents', val)
}

export function setLogo (ctx, val) {
  ctx.commit('setLogo', val)
}
