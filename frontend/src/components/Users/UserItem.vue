<template>
  <tr>
    <th scope="row">{{ user_index }}</th>
    <td v-for="item in userObjectList">
      <input
        type="text"
        class="input-table"
        :value="item.data"
        @input="(e) => changeField(e, item.field)"
        v-if="isFieldWritable(item.field)"
      />
    </td>
    <td class="table-controls">
      <button class="btn btn-success me-2" @click="updateUser">Update</button>
      <button class="btn btn-danger" @click="deleteUser">Delete</button>
    </td>
  </tr>
</template>

<script>
// import axios from "axios";
import { apiServer } from "../../utils/apiServer";
export default {
  props: [
    "usersCols",
    "userObject",
    "user_index",
    "getItems",
    "allowedFields",
    "displayMessages",
  ],
  data() {
    return {
      newUserObject: {},
    };
  },
  computed: {
    userObjectList: function () {
      return this.usersCols.map((item) => {
        return {
          data: this.userObject[item],
          field: item,
        };
      });
    },
  },
  methods: {
    changeField(e, fieldType) {
      const value = e.srcElement.value;
      // console.log(value);
      this.newUserObject[fieldType] = value;
      // console.log(this.newUserObject);
    },
    isFieldWritable(field_name) {
      return this.allowedFields.includes(field_name);
    },
    async updateUser() {
      try {
        // console.log(object);
        // const userId = this.newUserObject["user_id"];
        // console.log(userId, this.newUserObject);
        // await apiServer.put(`users/user/${userId}`, this.newUserObject);
        // console.log("user updated");
        // this.getItems();
        const len = (elem) => elem.length;
        const isBool = (str) => str == "0" || str == "1";
        const isNegative = (str) => +str < 0;
        let error = false;

        let user_credit = this.newUserObject["user_credit"];
        let user_name = this.newUserObject["user_name"];
        let user_phone = this.newUserObject["user_phone"];
        let user_email = this.newUserObject["user_email"];
        let user_admin = this.newUserObject["user_admin"];
        let user_read = this.newUserObject["user_read"];
        let user_write = this.newUserObject["user_write"];

        if (len(user_name) == 0) {
          error = true;
          this.displayMessages.push({
            type: "error",
            text: "Incorrect user_name",
          });
        }

        if (
          isNaN(user_credit) ||
          len(user_credit) == 0 ||
          isNegative(user_credit)
        ) {
          error = true;
          this.displayMessages.push({
            type: "error",
            text: "Incorrect user_credit",
          });
        }

        if (
          len(user_phone) == 0 ||
          isNaN(user_phone) ||
          isNegative(user_phone)
        ) {
          error = true;
          this.displayMessages.push({
            type: "error",
            text: "Incorrect user_phone",
          });
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
          const userId = this.newUserObject["user_id"];
          console.log(userId, this.newUserObject);
          await apiServer.put(`users/user/${userId}`, this.newUserObject);
          console.log("user updated");
          this.getItems();
        }
      } catch (e) {
        console.log(e);
      }
    },
    async deleteUser() {
      try {
        const userId = this.newUserObject["user_id"];
        await apiServer.delete(`users/user/${userId}`);
        console.log("delete user");
        this.getItems();
      } catch (e) {
        console.log(e);
      }
    },
  },
  mounted() {
    // console.log(this.userObject);
    this.newUserObject = this.userObject;
  },
};
</script>

<style scoped lang="sass">
.table-controls
  display: flex
</style>
