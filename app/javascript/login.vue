<template>
  <div id="login">

    <form action="/login" method="post">
      <label>Username:</label>
      <input type="text" name="username" autocomplete="off"/>

      <label>Password:</label>
      <input v-bind:type="passwordType" name="password" autocomplete="current-password"/>

      <label class="hidePassword"><input type="checkbox" v-on:click="hidePassword"> Hide my typing</label>

      <button type="submit" class="button">Log in</button>
    </form>
  </div>
</template>

<script>
export default {
  // props: ['message'],
  data() {
    return {
      passwordType: 'text',
    }
  },
  methods: {
    hidePassword() {
      this.passwordType = 'password';
    }
  }
}
</script>
