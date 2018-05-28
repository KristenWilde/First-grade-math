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
    newUserStart(username) {
      this.$http.post("/users", {
        username: this.username,
        password: this.password,
      }).then(function(response) {
      })
    }
  },
  components: {
    'app': App,
    'welcome': Welcome,
    'register': Register,
    'login': Login,
  },
}
</script>
