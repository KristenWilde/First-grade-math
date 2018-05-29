/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

console.log('Hello World from Kristen')

import TurbolinksAdapter from 'vue-turbolinks';
import Vue from 'vue/dist/vue.esm';
import VueRouter from 'vue-router';
import VueResource from 'vue-resource';
import Layout from '../layout.vue'
import App from '../app.vue';

Vue.use(TurbolinksAdapter)
Vue.use(VueRouter)
Vue.use(VueResource)

Vue.component('layout', Layout)
Vue.component('app', App)

const router = new VueRouter({
  routes: [
    { path: '/', component: Layout },
    { path: '/:username', component: Layout },
    { path: '/user/new', component: Layout },
    // { path: '/user/guest', component: Layout },
  ],
  mode: 'history',
});



document.addEventListener('turbolinks:load', () => {
  const layout = new Vue({
    el: '[data-behavior="vue"]',
    props: ["username", "problems"],
    router: router,
  })
  // const app = new Vue({
  //   el: 'app',
  //   props: ["username", "problems"],
  //   router: router,
  // })

})
