<template>
  <div id="app">
    <h2>Hello {{ username }}!</h2>
    <p id="info-problems">You’ll be working on the yellow problems below. For an extra challenge you can click on more problems.</p>
    <p id="info-mastered-problems">When you "master" a problem it will be pink. We'll review these problems too.</p>
    <button>Start</button>
    <ol id="problem-list">
      <problem-li v-for="problem in problems"
                  v-bind:minuend="problem.minuend"
                  v-bind:subtrahend="problem.subtrahend"
                  v-bind:success_times="problem.success_times">
       </problem-li>
    </ol>
  </div>
</template>



<script>
import Li from 'li.vue'

export default {
  props: ["username", "problems"],
  components: {
    'problem-li': Li,
  }

}

</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
