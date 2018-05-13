<template>
  <div id="app">
    <h2>Hello {{ username }}!</h2>
    <p id="info-problems">You’ll be working on the yellow problems below. For an extra challenge you can click on more problems.</p>
    <p id="info-mastered-problems">When you "master" a problem it will be pink. We'll review these problems too.</p>
    <button>Start</button>
    <ol id="problem-list">
      <li v-for="problem in problems" class="problem">
        {{ problem.minuend }} - {{ problem.subtrahend }}
      </li>
    </ol>
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
