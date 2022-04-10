<template>
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
    </tbody>
  </table>
</template>

<script lang="ts">
import { Vue } from "vue-class-component";
import axios from "axios";

export default class Users extends Vue {
  name: string = "Users";
  usersData: Array<any> = [];
  usersCols: Array<string> = [];

  async mounted() {
    await this.getUsers();
  }

  async getUsers() {
    let users = await axios.get("http://localhost:5000/api/v1/users/");
    users = users.data;
    // @ts-ignore
    const usersCols: Array<string> = Object.keys(users[0]);
    console.log(usersCols);
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
}
</script>
