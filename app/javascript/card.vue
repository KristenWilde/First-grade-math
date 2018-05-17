<template>
  <article class="card-container" v-show="showing">
    <div class="minuend">{{ minuend }}</div>
    <div class="subtrahend">- {{ subtrahend }}</div>
    <input type="text" class="answer" ref="input"
           v-on:keyup="evaluate">
  </article>
</template>

<script>
export default {
  name: 'card',
  props: ["problem", "showing"],
  data() {
    return {
      minuend: this.problem.minuend,
      subtrahend: this.problem.subtrahend,
      timer: null,
    }
  },
  updated() {
    if (this.showing) {
      this.$refs.input.focus();
    }
  },
  methods: {
    focusCurrent: function() {
      if (this.$props.showing) {
        return true
      }
    },
    evaluate: function(event) {
      if (Number(event.target.value) == Number(this.minuend) - Number(this.subtrahend)) {
        console.log('correct answer!');
        this.$emit('success', this.problem);
        event.target.value = '';
      }
    },
  }
}
</script>
