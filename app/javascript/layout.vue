<template>
  <div>
    <main>
      <welcome v-if="!username"></welcome>
      <register v-if="!username" v-on:registered="newUserStart($event)"></register>
      <login></login>
      <app v-if="username" v-bind:username="username" v-bind:problems="problems"></app>
    </main>
  </div>
</template>

<script>
import App from './app.vue';
import Welcome from './welcome.vue';
import Register from './register.vue';
import Login from './login.vue';

export default {
  props: ["username", "problems"],
  data() {
    return {
    }
  },
  methods: {

  },

}
</script>
