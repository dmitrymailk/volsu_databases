<template>
  <div class="container">
    <h1>{{ name }}</h1>
    <table class="table">
      <thead>
        <tr>
          <th scope="col">#</th>
          <th scope="col" v-for="col in usersCols">{{ col }}</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(user, index) in usersData">
          <th scope="row">{{ index }}</th>
          <td v-for="colData in user">{{ colData }}</td>
        </tr>

        <!-- add new item -->
        <tr>
          <th scope="row">{{ usersData.length }}</th>
          <td v-for="(colData, index) in usersCols">
            <input
              v-if="isFieldWritable(colData)"
              type="text"
              class="input-table"
            />
          </td>
        </tr>
      </tbody>
    </table>
    <div class="row">
      <button
        type="button"
        class="btn btn-outline-primary mx-auto w-25"
        @click="addItem"
      >
        <i class="bi bi-plus"></i>
      </button>
    </div>
  </div>
</template>

<script lang="ts">
import { Vue } from "vue-class-component";
import axios from "axios";

export default class Users extends Vue {
  name: string = "Users";
  usersData: Array<any> = [];
  usersCols: Array<string> = [];
  allowedFields: Array<string> = [
    "user_name",
    "user_credit",
    "user_phone",
    "user_email",
    "user_admin",
    "user_read",
    "user_write",
  ];

  isFieldWritable(field_name: string) {
    return this.allowedFields.includes(field_name);
  }

  async mounted() {
    await this.getUsers();
  }

  async getUsers() {
    let users = await axios.get("http://localhost:5000/api/v1/users/");
    users = users.data;
    // @ts-ignore
    const usersCols: Array<string> = Object.keys(users[0]);
    // console.log(usersCols);
    this.usersCols = usersCols;

    // @ts-ignore
    for (let user of users) {
      let item = [];
      for (let col of usersCols) {
        item.push(user[col]);
      }
      // @ts-ignore
      this.usersData.push(item);
    }
  }

  addItem() {
    console.log("add item");
  }
}
</script>

<style lang="sass">
.input-table
	width: 100%
</style>
