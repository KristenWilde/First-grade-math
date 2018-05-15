<template>
  <article class="card-container">
    <div class="minuend">{{ minuend }}</div>
    <div class="subtrahend">- {{ subtrahend }}</div>
    <input type="text" class="answer" ref="input"
           v-on:keyup="evaluate">
  </article>
</template>

<script>
export default {
  name: 'card',
  props: ["problem_id", "minuend", "subtrahend", "success_times", "data-working"],
  methods: {
    evaluate: function(event) {
      if (Number(event.target.value) == Number(this.minuend) - Number(this.subtrahend)) {
        console.log('correct answer!');
      }
    },
    success: function() {
      this.success_times += 1;
    }
  }
}
</script>
