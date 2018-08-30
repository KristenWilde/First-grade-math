<template>
  <main id="welcome">
    <header>
      <h1>Welcome to Subtract.Online</h1>
      <p>Get really good at subtracting
        numbers up to 20! </p>
      <p class="message">{{ message }}</p>
      <nav>
        <a id="show-sign-up" href="#" @click.prevent="toggleForm('register')" v-bind:class="{ selected: showing('register') }">
          Sign up
        </a>
        <a id="show-log-in" href="#" @click.prevent="toggleForm('login')"    v-bind:class="{ selected: showing('login') }">
         Log in
       </a>
      </nav>
    </header>
    <transition name="slideUp">
      <register v-show="showing('register')"></register>
    </transition>
    <transition name="slideUp">
      <login v-show="showing('login')"></login>
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
      currentForm: null,
    }
  },
  methods: {
    toggleForm(componentName) {
      if (this.currentForm == componentName) {
        this.currentForm = null;
      } else {
        this.currentForm = componentName;
      }
    },
    showing(componentName) {
      return this.currentForm === componentName;
    }
  },
  components: {
    'register': Register,
    'login': Login,
  }
}

</script>

<style scoped>

</style>
