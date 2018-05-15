<template>
  <li class="problem"
      v-bind:class="{ mastered: isMastered, working: isSelected }"
      v-on:click="toggleProblem">
    {{ minuend }} - {{ subtrahend }}
  </li>
</template>


<script>

export default {
  name: 'problem-li',
  props: ["problem_id", "minuend", "subtrahend", "success_times", "data-working"],
  data: function(){
    return { clicked: false }
  },
  computed: {
    isMastered: function() {
      return this.success_times >= 2;
    },
    isSelected: function() {
      return this.dataWorking.includes(this.problem_id) ||
             this.clicked;
    },
  },
  methods: {
    toggleProblem: function() {
      this.clicked = !this.clicked;
    },
  }
}
</script>

