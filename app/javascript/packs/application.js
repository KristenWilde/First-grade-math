/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import TurbolinksAdapter from 'vue-turbolinks';
import Vue from 'vue/dist/vue.esm';
import VueRouter from 'vue-router';
import VueResource from 'vue-resource';
import Vuex from 'vuex';

import Welcome from '../welcome.vue';
import Register from '../register.vue';
import Login from '../login.vue';
import App from '../app.vue';

Vue.use(TurbolinksAdapter)
Vue.use(VueRouter)
Vue.use(VueResource)
Vue.use(Vuex)

Vue.component('welcome', Welcome)
Vue.component('app', App)
Vue.component('register', Register)
Vue.component('login', Login)

const router = new VueRouter({
  routes: [
    { path: '/:username', component: App      },
    { path: '/',          component: Welcome  },
    { path: '/user/new',  component: Register },
    { path: '/login',     component: Login    } ],
  mode: 'history',
});

// for possible future refactor
const store = new Vuex.Store({
  state: {
  },
  mutations: {
  },
  getters: {
  },
  actions: {
  }
})

document.addEventListener('turbolinks:load', () => {
  const root = new Vue({
    el: '[data-behavior="vue"]',
    props: ["username", "problems"],
    router: router,
    components: {
      'welcome': Welcome,
      'register': Register,
      'login': Login,
      'app': App,
    },
  })

})
