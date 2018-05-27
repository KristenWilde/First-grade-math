<template>
  <div>
    <h1>To sign up:</h1>
    <ol>
      <li>Choose a username and password that will be easy for you to remember but hard for other people to guess.</li>
      <li>Don't use your real name.</li>
      <li>Write down your username and password or print this page after you fill it in.</li>
    </ol>
    <form>
      <label for="username">Username</label>
      <input type="text" id="username" v-model="username"required v-on:blur="validateUniqueUsername" />
      <p>{{ usernameMsg }}</p>

      <label for="password">Password (at least 8 characters)</label>
      <input type="text" id="password" v-model="password" v-on:blur="validatePasswordLength" required/>
      <p>{{ passwordLengthMsg }}</p>

      <label for="password_confirmation">Password again</label>
      <input type="text" id="password_confirmation" v-model="password_confirmation" required v-on:blur="validateMatchingPasswords" />
      <p>{{ passwordMatchMsg }}</p>
      <button v-on:click.prevent="createUser">Sign up</button>
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
      this.$http.post("/users", {
        username: this.username,
        password: this.password,
      });
    },
    validateUniqueUsername() {
      if (this.username.trim().length == 0) {
        this.usernameMsg = "Username is required.";
        return;
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
    validatePasswordLength() {
      if (this.password.length < 8) {
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
