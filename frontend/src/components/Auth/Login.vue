<template>
  <div class="container mt-3">
    <h1>Login</h1>
    <div class="mt-5">
      <label class="form-label">Email address</label>
      <input type="email" class="form-control" placeholder="name@example.com" />
    </div>
    <div class="mt-3">
      <label class="form-label">Password</label>
      <input type="password" class="form-control" />
    </div>
    <div class="row mt-3">
      <router-link
        to="/register/"
        type="button"
        class="btn btn-outline-primary col-auto me-3"
        >Register</router-link
      >
      <button type="button" class="btn btn-primary col-auto">Login</button>
    </div>
  </div>
</template>
