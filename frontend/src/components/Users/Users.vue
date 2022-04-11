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
              @input="(e) => changeNewUserField(e, colData)"
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
    <div class="row mt-3">
      <template v-for="mess in displayMessages">
        <div
          v-if="mess.type == 'error'"
          class="alert alert-danger"
          role="alert"
        >
          {{ mess.text }}
        </div>
        <div
          v-else-if="mess.type == 'success'"
          class="alert alert-success"
          role="alert"
        >
          {{ mess.text }}
        </div>
      </template>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      name: "Users",
      usersData: [],
      usersCols: [],
      allowedFields: [
        "user_name",
        "user_credit",
        "user_phone",
        "user_email",
        "user_admin",
        "user_read",
        "user_write",
      ],
      displayMessages: [],
      newUser: {},
    };
  },
  methods: {
    isFieldWritable(field_name) {
      return this.allowedFields.includes(field_name);
    },
    changeNewUserField(e, colData) {
      const value = String(e.target.value);
      this.newUser[colData] = value;
    },
    async getUsers() {
      let users = await axios.get("http://localhost:5000/api/v1/users/");
      users = users.data;
      const usersCols = Object.keys(users[0]);
      for (let item of usersCols) {
        this.newUser[item] = "";
      }
      this.usersCols = usersCols;

      for (let user of users) {
        let item = [];
        for (let col of usersCols) {
          item.push(user[col]);
        }
        this.usersData.push(item);
      }
    },
    async addItem() {
      this.displayMessages = [];
      console.log("add item");
      const len = (elem) => elem.length;
      const isBool = (str) => str == "0" || str == "1";
      let error = false;

      // @ts-ignore
      let user_credit = this.newUser["user_credit"];
      // @ts-ignore
      let user_name = this.newUser["user_name"];
      // @ts-ignore
      let user_phone = this.newUser["user_phone"];
      // @ts-ignore
      let user_email = this.newUser["user_email"];
      // @ts-ignore
      let user_admin = this.newUser["user_admin"];
      // @ts-ignore
      let user_read = this.newUser["user_read"];
      // @ts-ignore
      let user_write = this.newUser["user_write"];

      if (len(user_name) == 0) {
        error = true;
        this.displayMessages.push("Incorrect user_name");
      }

      if (isNaN(user_credit) || len(user_credit) == 0) {
        error = true;
        this.displayMessages.push({
          type: "error",
          text: "Incorrect user_credit",
        });
      }

      if (len(user_phone) == 0) {
        error = true;
        this.displayMessages.push({
          type: "error",
          text: "Incorrect user_phone",
        });
      }
      if (len(user_phone) == 0 || isNaN(user_phone)) {
        error = true;
        this.displayMessages.push("Incorrect user_phone");
      }
      if (len(user_email) == 0) {
        error = true;
        this.displayMessages.push({
          type: "error",
          text: "Incorrect user_email",
        });
      }

      if (!isBool(user_admin)) {
        error = true;
        this.displayMessages.push({
          type: "error",
          text: "Incorrect user_admin",
        });
        this.displayMessages.push("Incorrect user_admin");
      }
      if (!isBool(user_read)) {
        error = true;
        this.displayMessages.push({
          type: "error",
          text: "Incorrect user_read",
        });
      }

      if (!isBool(user_write)) {
        error = true;
        this.displayMessages.push({
          type: "error",
          text: "Incorrect user_write",
        });
      }

      if (!error) {
        console.log("send to server");
        user_admin = Number(user_admin);
        user_write = Number(user_write);
        user_read = Number(user_read);
        user_credit = Number(user_credit);

        let userData = {
          user_credit,
          user_name,
          user_phone,
          user_email,
          user_admin,
          user_read,
          user_write,
        };
        try {
          // await axios.post("http://localhost:5000/api/v1/users/", userData);
          this.displayMessages.push({
            type: "success",
            text: "User successfully added",
          });
        } catch (e) {
          console.error(e);
        }
      }
    },
  },
  async mounted() {
    await this.getUsers();
  },
};
</script>

<style lang="sass">
.input-table
	width: 100%
</style>
