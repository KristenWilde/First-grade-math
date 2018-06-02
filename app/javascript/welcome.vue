<template>
  <main id="welcome">
    <div>
      <article>
        <h1>Welcome to Subtract.Online</h1>
        <p>Get <em>really good</em> at subtracting
          numbers up to 20! </p>
      </article>
      <section>
        <a class="button" href="/user/new">Sign up</a>
        <p class="or">or</p>
        <a class="button" href="/login">Log in</a>
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
