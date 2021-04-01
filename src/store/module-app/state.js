import { LocalStorage, uid } from 'quasar'

const sessionDetails = LocalStorage.getItem('sessionDetails') || {}
const appDetails = LocalStorage.getItem('appDetails') || {}

export default function () {
  return {
    logo: [],
    session: sessionDetails,
    ajaxLoading: false,
    app: appDetails,
    controller: {

    },
    routerKey: uid(),
    salonBreadCrumps: '',
    salonChildBreadCrumps: '',
    salonBreadCrumpsChildren: {},
    refreshEvents: {}
  }
}
