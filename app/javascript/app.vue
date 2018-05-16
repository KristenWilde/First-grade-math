<template>
  <div id="app">
    <div id="app-index">
      <h2>Hello {{ username }}!</h2>
      <p id="info-problems">You’ll be working on the yellow problems below. For an extra challenge you can click on more problems.</p>
      <p id="info-mastered-problems">When you answer a problem two times in less than 5 seconds, it will be pink.</p>
      <button>Start</button>
      <ol id="problem-list">
        <li v-for="(problem, idx) in problems"
            class="problem"
            v-bind:class="{
                mastered: isMastered(problem),
                working: isSelected(problem),
              }"
            v-on:click="toggleProblem(problem)">
            {{ problem.minuend }} - {{ problem.subtrahend }}
         </li>
      </ol>
    </div>
    <div id="practice">
      <problem-card v-for="problem in workingProblems"
                    v-bind:minuend="problem.minuend"
                    v-bind:subtrahend="problem.subtrahend"
                    v-bind:success_times="problem.success_times"
                    v-bind:key="problem.id"
                    v-bind:problem_id="problem.id"
                    v-on:success="incrementSuccess($event)">
      </problem-card>
    </div>
  </div>
</template>

<script>
import Card from 'card.vue'

export default {
  name: 'app',
  props: ["username", "problems"],
  data() {
    return { workingProblems: this.next8() }
  },
  methods: {
    next8: function() {
      const result = [];
      let idx = 0;

      while (result.length < 8) {
        if (this.problems[idx].success_times < 2) {
          result.push(this.problems[idx]);
        }
        idx += 1;
      }
      return result;
    },
    toggleProblem(problem) {
      if (this.workingProblems.includes(problem)){
        this.remove(problem);
      }
      else {
        this.workingProblems.push(problem)
      }
    },
    remove(problem) {
      const idx = this.workingProblems.indexOf(problem);
      this.workingProblems.splice(idx, 1);
    },
    isSelected(problem) {
      return this.workingProblems.includes(problem);
    },
    isMastered(problem) {
      return problem.success_times >= 2;
    },
    find(problemId) {
      return this.problems.filter((prob) => prob.id == problemId)[0];
    },
    incrementSuccess(problemId) {
      this.find(problemId).success_times += 1;
    },
  },
  components: {
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
