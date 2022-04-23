<template>
  <div class="container">
    <h1>SQL execution console</h1>
    <form class="row g-3">
      <div class="col-md-10">
        <label for="inputPassword2" class="visually-hidden">Password</label>
        <input
          type="text"
          class="form-control"
          placeholder="sql script here"
          v-model="sqlScript"
        />
      </div>
      <div class="col-auto">
        <button class="btn btn-primary mb-3" @click="executeScript">
          Execute sql
        </button>
      </div>
    </form>
  </div>
</template>

<script>
export default {
  data() {
    return {
      sqlScript: "",
    };
  },
  methods: {
    executeScript(e) {
      e.preventDefault();
      console.log("execute", this.sqlScript);
    },
  },
};
</script>
