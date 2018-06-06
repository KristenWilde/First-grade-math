<template>
  <div id="practice">
<!--   <transition-group name="fade"> -->
    <article class="card-container">
      <div v-for="problem in workingProblems" v-show="problem === currentProb" :key="problem.id">
        <div class="minuend">{{ problem.minuend }}</div>
        <div class="subtrahend">- {{ problem.subtrahend }}</div>
      </div>
  <!-- </transition-group> -->
      <input type="text" class="answer" v-on:keyup="evaluate" ref="input">
      <div class="hint-frame" v-if="!timer">
      <div class="manipulative" v-for="disc in manipulatives()"  v-on:click="toggleColor" v-show="!timer"></div>
      </div>
    </article>
  </div>
</template>

<script>
/*
The practice component:
Sets startTime when session starts.
contains an element for each card.
displays each problem
  When transition ends:
    1. input receives focus
    2. timer starts
responds to user input and timer
  If incorrect: do nothing.
  On timeOut
    1. clear timer
    2. display manipulatives (with v-if !timer)
  On correct input,
    1. increment reps
    2. if timer,
      1. increment success_times
      2. add problem to problemsToUpdate
      3. clear timer
    3. start transition to next problem
      1. determine what next problem is
      2. start transition
At end of practice session,
  1. Send event and data back to parent.
  */
export default {
  props: ["workingProblems", "username", "maxSeconds"],
  data() {
    return {
      startTime: 1,
      timer: 1,
      problemsToUpdate: [],
      currentProb: this.workingProblems[0],
      reps: 0,
      targetTime: 5000,
      seconds: 0,
    }
  },
  mounted() {
    this.startPeriod()
  },
  methods: {
    startPeriod() {
      this.startTime = Date.now()
      this.getNextProblem(this.workingProblems[0]);
    },
    getNextProblem() {
      if (this.workingProblems.length === 1) {
        this.currentProb = this.workingProblems[0];
        this.startProblem();
        return;
      }
      let nextProblem;
      let idx;
      do {
        idx = Math.floor(Math.random() * (this.workingProblems.length));
        nextProblem = this.workingProblems[idx];
      } while (nextProblem === this.currentProb)
      this.currentProb = nextProblem;
      this.startProblem();
    },
    startProblem() {
      console.log(this.$refs.input);
      this.$refs.input.focus();
      this.startTimer();
    },
    startTimer: function() {
      this.timer = setTimeout( () => {
        this.timer = null;
      }, this.targetTime)
    },
    manipulatives() {
      return new Array(this.currentProb.minuend);
    },
    toggleColor(event) {
      event.target.classList.toggle('clicked');
    },
    evaluate(event) {
      console.log(this.timer)
      const answer = Number(this.currentProb.minuend) - Number(this.currentProb.subtrahend);
      if (Number(event.target.value) != answer) {
        return;
      }
      this.reps += 1;
      event.target.value = '';
      if (this.timer) {
        this.handleSuccess();
      }
      this.checkPeriod();
    },
    handleSuccess() {
      this.currentProb.success_times += 1;
      this.removeIfMastered(this.currentProb);
      this.addToUpdateList(this.currentProb);
      clearInterval(this.timer);
    },
    addToUpdateList(problem) {
      if (!this.problemsToUpdate.includes(problem)){
        this.problemsToUpdate.push(problem);
      }
    },
    removeIfMastered() {
      if (this.currentProb.success_times >= 2) {
        const idx = this.workingProblems.indexOf(this.currentProb);
        this.workingProblems.splice(idx, 1);
      }
    },
    checkPeriod() {
      this.getSecondsPracticed();
      if (this.workingProblems.length === 0 || this.seconds >= this.maxSeconds) {
        this.stopPeriod();
      } else {
        this.getNextProblem();
      }
    },
    getSecondsPracticed() {
      this.seconds = new Date(Date.now() - this.startTime).getSeconds();
    },
    stopPeriod() {
      const periodData = {
        username: this.username,
        problems: this.problemsToUpdate,
        seconds: this.seconds,
        reps: this.reps
      }
      this.$emit('finished', periodData)
    },
  },
}
</script>
