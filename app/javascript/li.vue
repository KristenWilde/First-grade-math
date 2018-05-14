<template>
  <li class="problem"
      v-bind:class="{ mastered: isMastered, working: isSelected }">
    {{ minuend }} - {{ subtrahend }}
  </li>
</template>


<script>
export default {
  props: ["minuend", "subtrahend", "success_times"],
  computed: {
    isMastered: function() {
      return this.success_times >= 2;
    },
    isSelected: function() {
      return false;
    }
  }
}
</script>

