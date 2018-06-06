<template>
  <main id="app">
    <transition name="fade">
      <ol id="problem-list" v-show="state === 'index'">
        <header>
          <a class="log-out" href="/logout">Log out</a>
          <h1>Hello {{ username }},</h1>
          <p v-if="resultMsg">{{resultMsg}}</p>
          <p>{{ message }}</p>
          <button v-on:click="state = 'practice'">Go</button>
          <p class="key">
            <span>
              <span class="mastered"></span> Mastered problems
            </span>
            <span>
              <span class="working"></span> Next problems to practice
            </span>
          </p>
        </header>

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
    </transition>

    <practice v-if="state === 'practice'" v-bind:workingProblems="workingProblems" v-bind:maxSeconds="maxSeconds" v-bind:username="username" v-on:finished="endPeriod">
    </practice>
  </main>
</template>

<script>
/*
The app component:
  displays a message to the user based on
    secondsToday and problemsToday
  determines what problems will be practiced √
  starts the practice session √
  submits ajax request to update user when practice session is finished √

*/
import Practice from 'practice.vue'

export default {
  name: 'app',
  props: [ "username", "problems", "secondsToday", "problemsToday" ],
  data() {
    return {
      state: 'index',
      selectedProblems: [],
      workingProblems: this.nextProblems(),
      maxSeconds: parseInt(this.$route.query.seconds, 10) || 180,
      probsPerPeriod: parseInt(this.$route.query.problems, 10) || 3,
      startTime: null,
      numMasteredToday: 0,
      resultMsg: '',
      message: "Let's start subtracting. Ready . . . set . . . "
    }
  },
  computed: {

  },
  created() {
    // add the 'showing' property to each problem,
    // along with a vue getter and setter,
    // and set it to 'false'
    // this.$props.problems.forEach( problem => {
    //   this.$set(problem, 'showing', false);
    // })

    // sort the problems.
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
    endPeriod(periodData) {
      this.save(periodData);
      this.state = 'index';
    },
    save(periodData) {
      this.$http.patch("/users/" + this.username, periodData).then(function(response) {
        console.log(response);
      }, function(response) {
        console.log(response);
      })
    },
    //Not currently working:
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
    'practice': Practice,
  }

}

</script>

<style scoped>

</style>
