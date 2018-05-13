<template>
  <div id="app">
    <p>Hello {{ username }}</p>
    <p>Here are your problems.</p>
    <p>{{ problems }}</p>
  </div>
</template>

<script>
export default {
  props: ["username", "problems"],
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
