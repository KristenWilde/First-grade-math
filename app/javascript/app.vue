<template>
  <div id="app">
    <div id="app-index" v-show="showIndex">
      <h2>Hello {{ username }}!</h2>
      <p class="result-msg" v-if="resultMsg">{{resultMsg}}</p>
      <p>You’ll be working on the yellow problems below. For an extra challenge you can click on more problems.</p>
      <p>When you master a problem it will be green. (Answer in 5 seconds two times.)</p>
      <button v-on:click="startPeriod">Start</button>

      <ol id="problem-list">
        <p class="validation-msg">{{invalidMsg()}}</p>
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
                    v-bind:problem="problem"
                    v-bind:showing="showCard(idx)"
                    v-on:success="updateProblem($event)"
                    v-on:next="handleAnswer($event)">
      </problem-card>
    </div>
  </div>
</template>

<script>
  // Next steps:
  // Send practice time as a query parameter (seconds)
  //
import Card from 'card.vue'

export default {
  name: 'app',
  props: ["username", "problems",],
  data() {
    return {
      selectedProblems: [],
      showIndex: true,
      showPractice: false,
      currentCardIdx: null,
      timer: null,
      updatedProblems: [],
      resultMsg: '',
      workingProblems: this.nextProblems(),
      seconds: parseInt(this.$route.query.seconds, 10) || 180,
    }
  },
  computed: {

  },
  methods: {
    nextProblems() {
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
        this.remove(problem);
      }
      else {
        this.selectedProblems.push(problem)
      }
    },
    remove(problem) {
      const idx = this.selectedProblems.indexOf(problem);
      this.selectedProblems.splice(idx, 1);
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
      if (this.timer) {
        this.nextCard();
      } else {
        this.endPeriod();
      }
    },
    nextCard() {
      let newIndex = this.currentCardIdx;
      while (newIndex == this.currentCardIdx) {
        newIndex = Math.floor(Math.random() * this.workingProblems.length);
      }
      this.currentCardIdx = newIndex;
      this.workingProblems[this.currentCardIdx].showing = true;
    },
    startPeriod() {
      this.getWorkingProblems();
      this.nextCard();
      this.showIndex = false;
      this.showPractice = true;
      this.timer = setTimeout( () => { this.timer = null }, this.seconds * 1000 );
    },
    endPeriod() {
      this.save();
      this.showIndex = true;
      this.showPractice = false;
    },
    invalidMsg() {
      return this.invalidSelection() ? "You must select 3 problems or more." : " ";
    },
    invalidSelection(){
      return this.workingProblems.length < 3;
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
      const problemData = this.updatedProblems.map( (problem) => {
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
        this.updateResultMsg(problemData);
        this.workingProblems = this.nextProblems();
        this.updatedProblems = [];
      });
      request.send(json);
    },
    updateResultMsg(problemData) {
      let total = 0;
      for (let i = 0; i < problemData.length; i++) {
        if (problemData[i]['success_times'] >= 2) {
          total += 1;
        }
      }
      if (total === 1) {
        this.resultMsg = "You just mastered 1 more problem!"
      } else if (total > 1) {
        this.resultMsg = `You just mastered ${total} more problems!!`
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
