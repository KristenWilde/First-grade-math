<template>
  <main id="app">
    <div id="app-index" v-show="showIndex">
      <h2>Hello {{ username }}!</h2>
      <p class="result-msg" v-if="resultMsg">{{resultMsg}}</p>
      <p>You’ll be working on the yellow problems below. For an extra challenge you can click on more problems.</p>
      <p>When you master a problem it will be green. (Answer in 5 seconds two times.)</p>
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
      <problem-card v-for="problem in workingProblems"
                    :key="problem.id"
                    v-bind:problem="problem"
                    v-bind:showing="problem.showing"
                    v-on:next="handleAnswer($event)">
      </problem-card>
    </div>
  </main>
</template>

<script>

import Card from 'card.vue'

export default {
  name: 'app',
  props: ["username", "problems",],
  data() {
    return {
      selectedProblems: [],
      showIndex: true,
      showPractice: false,
      timer: null,
      justMasteredProblems: [],
      resultMsg: '',
      workingProblems: [],
      seconds: parseInt(this.$route.query.seconds, 10) || 180,
      probsPerPeriod: parseInt(this.$route.query.problems, 10) || 10,
    }
  },
  computed: {

  },
  created() {
    this.$props.problems.forEach( problem => {
      this.$set(problem, 'showing', false);
    })
    this.$props.problems = this.$props.problems.sort((prob1, prob2) => prob1.id - prob2.id);
    this.workingProblems = this.nextProblems();
  },
  methods: {
    nextProblems() {
      const result = [];
      let idx = 0;
      while (result.length < this.probsPerPeriod) {
        if (this.problems[idx].success_times < 2) {
          result.push(this.problems[idx]);
        }
        idx += 1;
      }
      return result;
    },
    getWorkingProblems() {
      let prob;
      for (let i = 0; i < this.selectedProblems.length; i++) {
        prob = this.selectedProblems[i];
        if (!this.workingProblems.includes(prob)) {
          this.workingProblems.push(prob);
        }
      }
    },
    toggleProblem(problem) {
      if (this.nextProblems().includes(problem)){
        return;
      }
      if (this.selectedProblems.includes(problem)){
        this.remove(problem, this.selectedProblems);
      }
      else {
        this.selectedProblems.push(problem)
      }
    },
    remove(problem, problemSet) {
      const idx = problemSet.indexOf(problem);
      problemSet.splice(idx, 1);
    },
    isSelected(problem) {
      return this.selectedProblems.includes(problem) || this.workingProblems.includes(problem);
    },
    isMastered(problem) {
      return problem.success_times >= 2;
    },
    find(problemId) {
      return this.problems.filter((prob) => prob.id == problemId)[0];
    },
    handleAnswer(problem) {
      problem.showing = false;
      if (this.timer) {
        if (this.isMastered(problem)) {
          this.remove(problem, this.workingProblems);
          this.justMasteredProblems.push(problem);
        }
        if (this.workingProblems.length === 0) {
          this.endPeriod();
        } else {
          this.nextCard(problem);
        }
      } else {
        this.endPeriod();
      }
    },
    nextCard(oldProblem) {
      if (this.workingProblems.length === 1) {
        this.workingProblems[0].showing = true;
        return;
      }
      let newProblem;
      let newIdx;
      do {
        newIdx = Math.floor(Math.random() * (this.workingProblems.length));
        newProblem = this.workingProblems[newIdx];
      } while (newProblem === oldProblem)
      newProblem.showing = true;
    },
    startPeriod() {
      this.getWorkingProblems();
      this.nextCard(this.workingProblems[0]);
      this.showIndex = false;
      this.showPractice = true;
      this.timer = setTimeout( () => { this.timer = null }, this.seconds * 1000 );
    },
    endPeriod() {
      this.save();
      this.showIndex = true;
      this.showPractice = false;
    },
    showCard(idx) {
      return idx == this.currentCardIdx;
    },
    updateProblem(problem) {
      if (!this.updatedProblems.includes(problem)) {
        this.updatedProblems.push(problem);
      }
    },
    save() {
      const request = new XMLHttpRequest;
      const problemsToUpdate = this.workingProblems.concat(this.justMasteredProblems)
      const problemData = problemsToUpdate.map( (problem) => {
        return {
          'problem_id': problem.id,
          'success_times': problem.success_times,
        }
      })
      const json = JSON.stringify({
        'problems': problemData,
      });
      request.open('PATCH', '/users/' + this.username)
      request.setRequestHeader('Content-Type', 'application/json');
      request.addEventListener('load', () => {
        console.log(`updated ${problemData.length} problems!`);
        this.updateResultMsg(this.justMasteredProblems.length);
        this.workingProblems = this.nextProblems();
        this.justMasteredProblems = [];
      });
      request.send(json);
    },
    updateResultMsg(total) {
      if (total === 1) {
        this.resultMsg = "You just mastered 1 problem!"
      } else if (total > 1) {
        this.resultMsg = `You just mastered ${total} problems!!`
      } else {
        this.resultMsg = "";
      }
    },
  },
  components: {
    'problem-card': Card,
  }

}

</script>

<style scoped>

</style>
