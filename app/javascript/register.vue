<template>
  <main id="register">
    <h1>To sign up:</h1>
    <p>Choose a username and password that will be easy for you to remember but hard for other people to guess.</p>
    <form method="post" action="/users" id="register_new_user" v-on:submit="checkForm" novalidate>

      <label for="username">Username:</label>
      <input type="text" id="username" name="username" v-model="username" v-on:blur="validateUniqueUsername" />
      <p class="alert">{{ usernameMsg }}</p>

      <label for="password">Password: (at least 6 characters)</label>
      <input type="text" id="password" name="password" v-model="password" v-on:blur="validatePasswordLength"/>
      <p class="alert">{{ passwordLengthMsg }}</p>

      <label for="password_confirmation">Type password again:</label>
      <input type="text" id="password_confirmation" v-model="password_confirmation" v-on:blur="validateMatchingPasswords" />
      <p class="alert">{{ passwordMatchMsg }}</p>
      <button type="submit">Sign up</button>
    </form>
  </main>
</template>

<script>
export default {
  data() {
    return {
      username: "",
      password: "",
      password_confirmation: "",
      passwordLengthMsg: " ",
      passwordMatchMsg: " ",
      usernameMsg: " ",
    }
  },
  methods: {
    validateUniqueUsername() {
      if (!this.validateUsernameFormat()) {
        return false;
      }
      this.$http.get("/validate_username", {
        params: { username: this.username },
      }).then(function(response) {
        console.log(response);
        if (response.bodyText == 'true') {
          this.usernameMsg = "That username is ok!";
        } else {
          this.usernameMsg = "That username is taken. Try another.";
        }
      }, function(response) {
        console.log(response);
      })
    },
    validateUsernameFormat() {
      this.username = this.username.trim();
      if (this.username.length == 0) {
        this.usernameMsg = "Username can not be blank.";
        return false;
      }
      if (this.username.match(/\W/)) {
        this.usernameMsg = "Only letters and numbers are allowed.";
        return false;
      }
      if (this.username.length > 50) {
        this.usernameMsg = "Username is too long."
        return false;
      }
      return true;
    },
    validatePasswordLength() {
      if (this.password.length < 6) {
        this.passwordLengthMsg = "Password is too short.";
        return false;
      }
      else {
        this.passwordLengthMsg = "";
        return true;
      }
    },
    validateMatchingPasswords() {
      if (this.password !== this.password_confirmation){
        this.passwordMatchMsg = "Passwords don't match.";
        return false;
      }
      else {
        this.passwordMatchMsg = "";
        return true;
      }
    },
    checkForm(e) {
      const v1 = this.validateUsernameFormat();
      const v2 = this.validatePasswordLength();
      const v3 = this.validateMatchingPasswords();
      const v4 = (this.usernameMsg === "That username is ok!");

      if (!(v1 && v2 && v3 && v4)) {
        e.preventDefault();
      }
    }
  }
}
</script>

<style scoped>

</style>
