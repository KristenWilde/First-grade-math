<template>
  <div id="practice">
    <section class="card-container">
      <a class="quit" href="#" v-on:click.prevent="stopPeriod">Stop</a>
      <div class="card" v-for="problem in workingProblems" v-show="problem === currentProb" :key="problem.id">
        <div class="minuend">{{ problem.minuend }}</div>
        <div class="subtrahend">- {{ problem.subtrahend }}</div>
      </div>

      <div class="hint-card card">
        <div class="hint-frame" v-if="!timer">
          <div class="manipulative" v-for="disc in manipulatives()"  v-on:click="toggleColor" v-on:mouseenter="toggleColor" v-show="!timer"></div>
        </div>
      </div>

      <div class="card">
        <input type="text" class="answer" v-on:keyup="evaluate" ref="input" v-bind:value="answer"/>
      </div>
    </section>
    <div class="buttons">
      <button v-on:click="changeAnswer('1')">1</button>
      <button v-on:click="changeAnswer('2')">2</button>
      <button v-on:click="changeAnswer('3')">3</button>
      <button v-on:click="changeAnswer('4')">4</button>
      <button v-on:click="changeAnswer('5')">5</button>
      <button v-on:click="changeAnswer('6')">6</button>
      <button v-on:click="changeAnswer('7')">7</button>
      <button v-on:click="changeAnswer('8')">8</button>
      <button v-on:click="changeAnswer('9')">9</button>
      <button v-on:click="changeAnswer('0')">0</button>
      <button v-on:click="backspace" class="backspace">◀</button>
    </div>
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
      answer: "",
    }
  },
  mounted() {
    this.startPeriod()
  },
  methods: {
    backspace() {
      this.answer = this.answer.slice(0, -1);
    },
    clear() {
      this.answer = "";
      this.$refs.input.classList.remove('correct', 'incorrect');
    },
    changeAnswer(digit) {
      this.answer += digit;
      this.evaluate();
    },
    startPeriod() {
      this.seconds = 0;
      this.reps = 0;
      this.startTime = Date.now();
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
    keyInput(event) {
      console.log(event.key);
    },
    evaluate(e) {
      console.log(this.timer)
      const answer = Number(this.currentProb.minuend) - Number(this.currentProb.subtrahend);
      if (e) {
        this.answer = e.target.value;
      }
      if (this.answer != answer) {
        this.$refs.input.classList.add('incorrect');
        return;
      }
      this.$refs.input.classList.add('correct');
      setTimeout( this.respondToCorrectAnswer, 400 );
    },
    respondToCorrectAnswer() {
      if (this.timer) {
        this.handleSuccess();
      }
      this.reps += 1;
      this.clear();
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
      if (this.workingProblems.length === 0 ||
        this.getSecondsPracticed() >= this.maxSeconds) {
        this.stopPeriod();
      } else {
        this.getNextProblem();
      }
    },
    getSecondsPracticed() {
      return new Date(Date.now() - this.startTime).getSeconds();
    },
    stopPeriod() {
      const periodData = {
        username: this.username,
        problems: this.problemsToUpdate,
        seconds: this.getSecondsPracticed(),
        reps: this.reps
      }
      console.log(periodData)
      this.$emit('finished', periodData)
    },
  },
}
</script>
