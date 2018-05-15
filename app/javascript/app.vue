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
                  v-bind:success_times="problem.success_times"
                  v-bind:problem_id="problem.id"
                  v-bind:data-working="workingIds">
       </problem-li>
    </ol>
  </div>
</template>

<script>



import Li from 'li.vue'
export default {
  props: ["username", "problems"],
  computed: {
    workingIds: function() {
      const ids = [];
      let idx = 0;
      let currentId;

      while (ids.length < 8) {
        currentId = this.problems[idx].id;
        if (this.problems[idx].success_times < 2) {
          ids.push(currentId);
        }
        idx += 1;
      }
      return ids;
    },
  },
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
