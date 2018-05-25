<template>
  <div>
    <header>
      <a id="home-link" href="#">SummerSubtraction</a>
      <a class="nav-link" href="#">Log in</a>
    </header>
    <main>
      <app v-bind:username="username" v-bind:problems="problems" v-bind:seconds="seconds"></app>
      <p v-if="usernameInRoute">There is a username in the params.</p>

      <p v-else>Hello Kristen, the layout.vue template is here!</p>
    </main>
  </div>
</template>

<script>
import App from './app.vue';

export default {
  props: ["username", "problems"],
  computed: {
    usernameInRoute() {
      return !!this.$route.params.username
    }
  },
  components: {
    'app': App,
  },
}
</script>
