<template>
  <main id="login">
    <form action="/login" method="post" id="login">
      <p>{{ message }}</p>
      <label for="username">Username:</label>
      <input type="text" id="username" name="username"/>
      <label for="password">Password:</label>
      <input type="text" id="password" name="password"/>
      <button type="submit">Log in</button>
    </form>
  </main>
</template>

<script>
export default {
  props: ['message'],
}
</script>
