<template>
  <div>

    <main>
      <welcome v-if="!username"></welcome>
      <register v-if="!username"></register>
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
  components: {
    'app': App,
    'welcome': Welcome,
    'register': Register,
    'login': Login,
  },
}
</script>
