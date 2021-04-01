
const routes = [
  {
    path: '/login',
    component: () => import('pages/LoginPage'),
    name: 'login'
  },
  {
    path: '/',
    component: () => import('layouts/MainLayout.vue'),
    name: 'layout',
    children: [
      {
        path: '/components',
        component: () => import('pages/ComponentsPage'),
        name: 'components'
      }
    ]
  },

  // Always leave this as last one,
  // but you can also remove it
  {
    path: '*',
    component: () => import('pages/LoginPage'),
    name: 'login'
  }
]

export default routes
