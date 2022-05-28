<template>
  <div class="container mt-3">
    <h1>Login</h1>
    <div class="mt-5">
      <label class="form-label">Email address</label>
      <input
        v-model="user_email"
        type="email"
        class="form-control"
        placeholder="name@example.com"
      />
    </div>
    <div class="mt-3">
      <label class="form-label">Password</label>
      <input v-model="password" type="password" class="form-control" />
    </div>
    <div class="row mt-3">
      <router-link
        to="/register/"
        type="button"
        class="btn btn-outline-primary col-auto me-3"
        >Register</router-link
      >
      <button @click="login" type="button" class="btn btn-primary col-auto">
        Login
      </button>
    </div>
    <div class="mt-3">
      <template v-for="item in messages">
        <div
          v-if="item.type == 'error'"
          class="alert alert-danger"
          role="alert"
        >
          {{ item.status }}
        </div>
        <div
          v-else-if="item.type == 'ok'"
          class="alert alert-success"
          role="alert"
        >
          {{ item.status }}
        </div>
      </template>
    </div>
  </div>
</template>

<script>
import { apiServer } from "../../utils/apiServer.js";

export default {
  data() {
    return {
      password: "",
      user_email: "",
      messages: [],
    };
  },
  methods: {
    login() {
      //   try {
      const { password, user_email } = this;
      console.log(password, user_email);
      this.$store
        .dispatch("LOGIN", {
          password,
          user_email,
        })
        .then(() => this.$router.push("/"))
        .catch((e) => {
          console.log("error");
          console.error(Object.keys(e), e);
          const mess1 = {
            status: "Register Error",
            type: "error",
          };
          this.messages.push(mess1);
        });
      // console.log(result, result.status);
      // if (result) {
      //   const mess1 = {
      //     status: result.data.status,
      //     type: "ok",
      //   };
      //   this.messages.push(mess1);
      // }
      //   } catch (e) {
      //     console.log("error");
      //     console.error(Object.keys(e), e);
      //     const mess1 = {
      //       status: "Register Error",
      //       type: "error",
      //     };
      //     this.messages.push(mess1);
      //   }
    },
  },
};
</script>
