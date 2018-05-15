<template>
  <li class="problem"
      v-bind:class="{ mastered: isMastered, working: isSelected }">
    {{ minuend }} - {{ subtrahend }}
  </li>
</template>


<script>



export default {
  props: ["problem_id", "minuend", "subtrahend", "success_times", "data-working"],
  computed: {
    isMastered: function() {
      return this.success_times >= 2;
    },
    isSelected: function() {
      return this.dataWorking.includes(this.problem_id);
    }
  }
}
</script>

