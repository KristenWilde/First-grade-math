<template>
  <main id="welcome">
    <div>
      <article>
        <h1>Welcome to Subtract.Online!</h1>
        <p>We're here to help <strong>you</strong>
          get <br><em>really good</em> at subtracting<br>
          numbers up to 20. </p>
      </article>
      <section>
        <a class="button" href="/user/new">Sign up</a>
        <p class="or">or</p>
        <a class="button" href="#">Log in</a>
      </section>
    </div>
  </main>
</template>

<script>
export default {
  name: 'welcome',
  props: ["username", "problems"],
  data() {
    return {
    }
  },
  methods: {
  },
}

</script>

<style scoped>

</style>
