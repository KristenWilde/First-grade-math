<template>
  <div id="app">
    <div id="app-index" v-show="showIndex">
      <h2>Hello {{ username }}!</h2>
      <p id="info-problems">You’ll be working on the yellow problems below. For an extra challenge you can click on more problems.</p>
      <p id="info-mastered-problems">When you answer a problem two times in less than 5 seconds, it will be pink.</p>
      <button v-on:click="startPeriod">Start</button>
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
    <div id="practice" v-show="showPractice">
      <problem-card v-for="(problem, idx) in workingProblems"
                    v-bind:minuend="problem.minuend"
                    v-bind:subtrahend="problem.subtrahend"
                    v-bind:success_times="problem.success_times"
                    v-bind:key="problem.id"
                    v-bind:problem_id="problem.id"
                    v-on:success="handleCorrectAnswer($event)"
                    v-show="showCard(idx)">
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
    return {
      workingProblems: this.getWorkingProblems(),
      showIndex: true,
      showPractice: false,
      currentCardIdx: 0,
      timer: null,
      periodLength: 10000,
    }
  },
  methods: {
    getWorkingProblems() {
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
    handleCorrectAnswer(problemId) {
      this.incrementSuccess(problemId);
      if (this.timer) {
        this.nextCard();
      } else {
        this.endPeriod();
      }
    },
    incrementSuccess(problemId) {
      this.find(problemId).success_times += 1;
    },
    nextCard() {
      this.currentCardIdx = Math.floor(Math.random() * this.workingProblems.length);
    },
    startPeriod() {
      this.nextCard();
      this.showIndex = false;
      this.showPractice = true;
      this.timer = setTimeout( () => { this.timer = null },
                               this.periodLength );
    },
    endPeriod() {
      console.log('period ended');
      this.workingProblems = this.getWorkingProblems();
      this.showIndex = true;
      this.showPractice = false;
    },
    showCard(idx) {
      return idx == this.currentCardIdx;
    }
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
