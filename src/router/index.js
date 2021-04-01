import Vue from 'vue'
import VueRouter from 'vue-router'
import routes from './routes'
import store from '../store/index'

Vue.use(VueRouter)

const Router = new VueRouter({
  scrollBehavior: () => ({ x: 0, y: 0 }),
  routes,
  store,
  // Leave these as they are and change in quasar.conf.js instead!
  // quasar.conf.js -> build -> vueRouterMode
  // quasar.conf.js -> build -> publicPath
  mode: process.env.VUE_ROUTER_MODE,
  base: process.env.VUE_ROUTER_BASE
})
Router.beforeEach((to, from, next) => {
  const requiresAuth = to.matched.some(record => record.meta.requiresAuth)
  const typeMatched = to.matched.some(record => record.meta.type === store.getters['app/accountType'])
  if (requiresAuth && (!store.state.app.session.jwt || !store.state.app.session.session || !typeMatched)) {
    next({ path: '/login', query: { redirect: to.path } })
  } else {
    next()
  }
})
export default Router
