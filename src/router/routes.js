import { LocalStorage } from 'quasar'

const pages = LocalStorage.getItem('appDetails')
let routes = []
if (pages && pages.pages) {
  const components = {
    FUZPage: () => import('components/FUZPage'),
    Profile: () => import('pages/Profile.vue'),
    SyncSchedule: () => import('pages/SyncSchedule'),
    Dashboard: () => import('pages/Dashboard/Dashboard'),
    SalonProfile: () => import('pages/SalonProfile'),
    StaffHours: () => import('pages/StaffHours'),
    Calendar: () => import('pages/Calendar/Calendar'),
    ClientRetention: () => import('pages/Client_Retention'),
    Settings: () => import('pages/Settings.vue')
  }

  routes = [
    {
      path: '/',
      component: () => import('layouts/MainLayout.vue'),
      meta: { requiresAuth: true },
      children: pages && pages.pages && pages.pages.map((page) => {
        return {
          path: page.path,
          component: components[page.component],
          name: page.name,
          meta: {
            requiresAuth: page.requiresAuth,
            icon: page.icon,
            routine: page.routine,
            type: page.type,
            childBreadcrump: page.childBreadcrump,
            breadcrump: page.breadcrump
          }
        }
      })
    }
  ]
}
routes.push({
  path: '/login',
  component: () => import('pages/LoginPage'),
  name: 'loginPublic',
  children: [
    { path: '/login/go', component: () => import('pages/LoginPage/LoginPageGo'), name: 'LoginPageGo' },
    { path: '/login/signup', component: () => import('pages/LoginPage/LoginPageRegister'), name: 'LoginPageRegister' }
  ]
})
routes.push({ path: '/logged_out', component: () => import('pages/Logged_Out.vue'), name: 'logged_out' })

routes.push({ path: '*', component: () => import('pages/LoginPage'), name: 'login' })
// routes.push({
//   path: '*',
//  component: () => import('pages/Notallowed.vue')
// })

export default routes
/*
[
      {
        path: '',
        component: () => import('pages/Index.vue'),
        meta: {
          requiresAuth: true
        }
      },
      {
        path: 'Schedule',
        component: () => import('pages/Schedule.vue'),
        name: 'schedule',
        meta: {
          requiresAuth: true
        }
      }
    ]
*/
