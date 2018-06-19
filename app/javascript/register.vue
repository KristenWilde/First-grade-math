<template>
  <div id="register">
    <p>Choose a username and password that will be easy for you to remember but hard for other people to guess.</p>
    <form method="post" action="/users" id="register_new_user" v-on:submit="checkForm" novalidate>

        <label for="username">Username:
          <span class="alert">{{ usernameMsg }}</span>
        </label>
        <input type="text" id="username" name="username" v-model="username" v-on:blur="validateUniqueUsername" v-bind:class="{error: usernameError}" autocomplete="off"/>

        <label for="password">Password:
          <span class="alert">{{ passwordLengthMsg }}</span>
        </label>
        <input v-bind:type="passwordType" id="password" name="password" v-model="password" v-on:blur="validatePasswordLength" autocomplete="off"/>

        <label for="password_confirmation">Password again:
          <span class="alert">{{ passwordMatchMsg }}</span>
        </label>
        <input v-bind:type="passwordType" id="password_confirmation" v-model="password_confirmation" v-on:blur="validateMatchingPasswords" autocomplete="off"/>

        <label class="hidePassword"><input type="checkbox" v-on:click="toggleShowPassword"> Show my typing</label>

      <button type="submit" class="button">Sign up</button>
    </form>
  </div>
</template>

<script>
export default {
  data() {
    return {
      username: "",
      password: "",
      password_confirmation: "",
      usernameError: false,
      passwordError: false,
      passwordConfError: false,
      passwordLengthMsg: "",
      passwordMatchMsg: "",
      usernameMsg: "",
      passwordType: 'password',
    }
  },
  methods: {
    toggleShowPassword() {
      if (this.passwordType === 'text') {
        this.passwordType = 'password';
      } else {
        this.passwordType = 'text';
      }
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
          this.usernameMsg = "Ok";
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
        this.passwordLengthMsg = "Password must be at least 6 characters.";
        return false;
      }
      else {
        this.passwordLengthMsg = "Ok";
        return true;
      }
    },
    validateMatchingPasswords() {
      if (this.passwordLengthMsg === 'Ok'){
        if (this.password !== this.password_confirmation){
          this.passwordMatchMsg = "Passwords don't match.";
          return false;
        }
        this.passwordMatchMsg = "Ok";
        return true;
      }
    },
    checkForm(e) {
      const v1 = this.validateUsernameFormat();
      const v2 = this.validatePasswordLength();
      const v3 = this.validateMatchingPasswords();
      const v4 = (this.usernameMsg === "Ok");

      if (!(v1 && v2 && v3 && v4)) {
        e.preventDefault();
      }
    }
  }
}
</script>

<style scoped>

</style>
