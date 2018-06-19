<template>
  <main id="app">
    <transition name="fade">
      <div id="index" v-if="showing('index')">
        <header>
          <a class="quit" href="/logout">Log out</a>
          <h1>Hello {{ username }},</h1>
          <p>{{ resultMsg }}</p>
          <p>{{ message }}</p>
          <button class="button" v-on:click="start">Go</button>

          <nav>
            <a @click="toggleGrid('problem-list')" v-bind:class="{ selected: showing('problem-list') }">
              See Problem List
            </a>
            <a @click="toggleGrid('date-records')"    v-bind:class="{ selected: showing('date-records') }">
             See Daily Records
           </a>
         </nav>
        </header>

        <article id="problem-list" v-show="showing('problem-list')">
          <p class="key">
            <span>
              <span class="working"></span> Next problems to practice
            </span>
            <span>
              <span class="mastered"></span> Mastered problems
            </span>
          </p>
          <ol>
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
        </article>
        <date-records v-if="showing('date-records')" v-bind:username="username"></date-records>
      </div>
    </transition>

    <practice v-if="showing('practice')" v-bind:workingProblems="workingProblems" v-bind:maxSeconds="maxSeconds" v-bind:username="username" v-on:finished="endPeriod">
    </practice>
  </main>
</template>

<script>
/*
Consider using Vuex to track state such as updatedProblems, username, and hold methods

The app component:
  displays a message to the user based on
    secondsToday and problemsToday √
  determines what problems will be practiced √
  starts the practice session √
  submits ajax request to update user when practice session is finished √
*/
import Practice from 'practice.vue'
import DateRecords from 'date-records.vue'

export default {
  name: 'app',
  props: [ "username", "problems", "secondsToday", "problemsToday" ],
  data() {
    return {
      currentView: 'index',
      currentGrid: null,
      selectedProblems: [],
      workingProblems: [],
      maxSeconds: parseInt(this.$route.query.seconds, 10) || 180,
      probsPerPeriod: parseInt(this.$route.query.problems, 10) || 10,
      startTime: null,
      numMasteredToday: 0,
      resultMsg: '',
      message: "Let's start subtracting. Ready, set . . . ",
      todayProblems: this.problemsToday,
      todaySeconds: this.secondsToday,
    }
  },
  created() {
    // sort the problems.
    this.$props.problems = this.$props.problems.sort((prob1, prob2) => prob1.id - prob2.id);
    this.reset();
  },
  methods: {
    showing(componentName) {
      return this.currentView === componentName || this.currentGrid === componentName;
    },
    toggleGrid(componentName) {
      if (this.currentGrid === componentName) {
        this.currentGrid = null;
      } else {
        this.currentGrid = componentName;
      }
    },
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
    start() {
      this.getWorkingProblems();
      this.currentView = 'practice';
    },
    endPeriod(periodData) {
      this.save(periodData);
    },
    save(periodData) {
      this.$http.patch("/users/" + this.username, periodData).then(function(response) {
        this.todayProblems = response.body.problems_answered;
        this.todaySeconds = response.body.seconds;
        this.reset();
      })
    },
    reset() {
      this.currentView = 'index';
      this.workingProblems = this.nextProblems();
      this.updateMessages();
    },
    updateMessages(total) {
      const minutes = this.todaySeconds/60;
      let timeStr;
      if (this.todaySeconds === 0) {
        return;
      } else if (minutes < 1) {
        timeStr = this.todaySeconds + ' seconds';
      } else {
        timeStr = minutes.toFixed(1) + ' minutes'
      }
      this.resultMsg = `You've practiced for ${timeStr} today and answered ${this.todayProblems} problems!`
      this.message = "Keep up the great work!"
    },
  },
  components: {
    'practice': Practice,
    'date-records': DateRecords,
  }

}

</script>

<style scoped>

</style>
