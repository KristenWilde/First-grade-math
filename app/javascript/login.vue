<template>
  <div id="login">

    <form action="/login" method="post">
      <label>Username:</label>
      <input type="text" name="username" autocomplete="on"/>

      <label>Password:</label>
      <input v-bind:type="passwordType" name="password" autocomplete="current-password"/>

      <label class="hidePassword"><input type="checkbox" v-on:click="toggleShowPassword"> Show my typing</label>

      <button type="submit" class="button">Log in</button>
    </form>
  </div>
</template>

<script>
export default {
  data() {
    return {
      passwordType: 'password',
    }
  },
  methods: {
    toggleShowPassword() {
      if (this.passwordType === 'text') {
        this.passwordType = 'password';
      } else {
        this.passwordType = 'text';
      }
    }
  }
}
</script>
