import Vue from 'vue'

import 'normalize.css/normalize.css'// A modern alternative to CSS resets

import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'

import '@/styles/index.scss' // global css

import App from './App'
import router from './router'
import store from './store'

import '@/icons' // icon
import '@/permission' // permission control

Vue.use(ElementUI);

Vue.config.productionTip = false;
Vue.prototype.$baseUrl = process.env.baseUrl;

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount("#app");
