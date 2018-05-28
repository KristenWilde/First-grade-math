<template>
  <div>
    <h1>To sign up:</h1>
    <p>Choose a username and password that will be easy for you to remember but hard for other people to guess.</p>
    <form method="post" action="/users">
      <label for="username">Username</label>
      <input type="text" id="username" name="username" v-model="username"required v-on:blur="validateUniqueUsername" />
      <p>{{ usernameMsg }}</p>

      <label for="password">Password (at least 6 characters)</label>
      <input type="text" id="password" name="password"v-model="password" v-on:blur="validatePasswordLength" required/>
      <p>{{ passwordLengthMsg }}</p>

      <label for="password_confirmation">Password again</label>
      <input type="text" id="password_confirmation" v-model="password_confirmation" required v-on:blur="validateMatchingPasswords" />
      <p>{{ passwordMatchMsg }}</p>
      <button type="submit">Sign up</button>
    </form>
    <p></p>
  </div>
</template>

<script>
export default {
  data() {
    return {
      username: "",
      password: "",
      password_confirmation: "",
      passwordLengthMsg: "",
      passwordMatchMsg: "",
      usernameMsg: "",
    }
  },
  methods: {
    createUser() {
      if (!this.allFieldsValid()) {
        console.log('invalid submission');
        return
      }

      // .then(() => {
      //   this.$emit('registered', this.username);
      // });
    },
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
        console.log("msg: " + this.passwordLengthMsg)
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
    allFieldsValid() {
      return this.usernameMsg === "That username is ok!" && this.validateMatchingPasswords() && this.validatePasswordLength();
    }
  }
}
</script>

<style scoped>

</style>
