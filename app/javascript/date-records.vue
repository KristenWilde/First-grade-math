<template>
  <table>
    <tr>
      <th>Date</th>
      <th>Time</th>
      <th>Problems</th>
    </tr>
    <tr v-for="record in records">
      <td>{{ record.date }}</td>
      <td>{{ record.time }}</td>
      <td>{{ record.problems }}</td>
    </tr>
  </table>
</template>

<script>
export default {
  props: ['username'],
  data() {
    return {
      records: [],
    }
  },
  created() {
    this.getDateRecords();
  },
  methods: {
    getDateRecords() {
      console.log('called getDateRecords.')
      const url = `/${this.username}/date_records`;

      this.$http.get(url, {
        params: { username: this.username }
      }).then( function(response) {
        // console.log(response);
        this.processJson(response.body)
      });
    },
    processJson(jsonArray) {
      jsonArray.forEach((json) => {
        if (json.problems_answered === 0) {
          return;
        }
        const obj = {
          date: this.dateString(json),
          time: this.timeString(json),
          problems: this.numProblems(json),
        }
        this.records.push(obj)
      });
    },
    dateString(json) {
      return new Date(json.created_at).toDateString();
    },
    timeString(json) {
      if (json.seconds === 0) {
        return '0';
      }
      else if (json.seconds < 60) {
        return json.seconds + ' seconds';
      }
      else {
        return (json.seconds/60).toFixed(1) + ' minutes'
      }
    },
    numProblems(json) {
      return json.problems_answered;
    }
  }
}
</script>
