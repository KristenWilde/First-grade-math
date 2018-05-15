<template>
  <div id="app">
    <div id="app-index">
      <h2>Hello {{ username }}!</h2>
      <p id="info-problems">You’ll be working on the yellow problems below. For an extra challenge you can click on more problems.</p>
      <p id="info-mastered-problems">When you "master" a problem it will be pink.</p>
      <button>Start</button>
      <ol id="problem-list">
        <problem-li v-for="problem in problems"
                    v-bind:minuend="problem.minuend"
                    v-bind:subtrahend="problem.subtrahend"
                    v-bind:success_times="problem.success_times"
                    v-bind:key="problem.id"
                    v-bind:problem_id="problem.id"
                    v-bind:data-working="workingIds">
         </problem-li>
      </ol>
    </div>
    <div id="practice">
      <problem-card v-for="problem in problems"
                    v-bind:minuend="problem.minuend"
                    v-bind:subtrahend="problem.subtrahend"
                    v-bind:success_times="problem.success_times"
                    v-bind:key="problem.id"
                    v-bind:problem_id="problem.id"
                    v-bind:data-working="workingIds"
                    v-on:success="incrementSuccess($event)">
      </problem-card>
    </div>
  </div>
</template>

<script>
import Li from 'li.vue'
import Card from 'card.vue'

export default {
  name: 'app',
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
  methods: {
    incrementSuccess: function(problemId) {
      const problem = this.problems.filter((prob) => prob.id == problemId)[0];
      console.log(problem.id)
      problem.success_times += 1;
    }
  },
  components: {
    'problem-li': Li,
    'problem-card': Card,
  }

}

</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
