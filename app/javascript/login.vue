<template>
  <div id="login">
    <p class="message">{{ message }}</p>
    <form action="/login" method="post">
      <label for="username">Username:</label>
      <input type="text" id="username" name="username" autocomplete="off"/>
      <label for="password">Password:</label>
      <input type="text" id="password" name="password" autocomplete="off"/>
      <button type="submit" class="button">Log in</button>
    </form>
  </div>
</template>

<script>
export default {
  props: ['message'],
  methods: {
  }
}
</script>
