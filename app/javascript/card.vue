<template>
  <article class="card-container" v-show="showing">
    <div class="minuend">{{ minuend }}</div>
    <div class="subtrahend">- {{ subtrahend }}</div>
    <input type="text" class="answer" ref="input"
           v-on:keyup="evaluate">
  </article>
</template>

<script>
import App from 'app.vue';

export default {
  name: 'card',
  props: ["problem", "showing"],
  data() {
    return {
      minuend: this.problem.minuend,
      subtrahend: this.problem.subtrahend,
      timer: null,
      targetTime: 5000,
    }
  },
  updated() {
    if (this.showing) {
      this.$refs.input.focus();
      this.startTimer();
    }
  },
  methods: {
    focusCurrent: function() {
      if (this.$props.showing) {
        return true
      }
    },
    startTimer: function() {
      this.timer = setTimeout( () => { this.timer = null }, this.targetTime)
    },
    evaluate: function(event) {
      if (Number(event.target.value) == Number(this.minuend) - Number(this.subtrahend)) {
        if (!!this.timer) {
          console.log('timer: ' + this.timer);
          this.problem.success_times += 1;
          this.$emit('success', this.problem)
        }
        console.log('success_times: ' + this.problem.success_times)
        this.$emit('next');
        event.target.value = '';
      }
    },
  }
}
</script>
