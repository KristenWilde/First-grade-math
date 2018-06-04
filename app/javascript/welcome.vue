<template>
  <main id="welcome">
    <header>
      <article>
        <h1>Welcome to Subtract.Online</h1>
        <p>Get <em>really good</em> at subtracting
          numbers up to 20! </p>
      </article>
      <nav>
        <a @click="state = 'register'" v-bind:class="{ selected: (state === 'register') }">Sign up</a>
        <a @click="state = 'login'" v-bind:class="{ selected: (state === 'login') }">Log in</a>
      </nav>
    </header>
    <transition name="fade">
      <register v-show="state === 'register'"></register>
    </transition>
    <transition name="fade">
      <login v-show="state === 'login'" v-bind:message="message"></login>
    </transition>
  </main>
</template>

<script>
import Register from './register.vue';
import Login from './login.vue';

export default {
  name: 'welcome',
  props: ["username", "problems", "message"],
  data() {
    return {
      state: 'default'
    }
  },
  created() {
    if (this.$props.message) {
      this.state = 'login';
    }
  },
  methods: {
  },
  components: {
    'register': Register,
    'login': Login,
  }
}

</script>

<style scoped>

</style>
