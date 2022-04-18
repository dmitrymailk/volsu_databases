<template>
  <tr>
    <th scope="row">{{ user_index }}</th>
    <td v-for="item in userObjectList">
      <input
        type="text"
        class="input-table"
        :value="item.data"
        @input="(e) => changeField(e, item.field)"
      />
    </td>
    <td class="table-controls">
      <button class="btn btn-success me-2" @click="updateUser">Update</button>
      <button class="btn btn-danger" @click="deleteUser">Delete</button>
    </td>
  </tr>
</template>

<script>
import axios from "axios";

export default {
  props: ["usersCols", "userObject", "user_index", "getUsers"],
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
    async updateUser() {
      try {
        // console.log(object);
        const userId = this.newUserObject["user_id"];
        console.log(userId, this.newUserObject);
        await axios.put(
          `http://localhost:5000/api/v1/users/user/${userId}`,
          this.newUserObject
        );
        console.log("user updated");
        this.getUsers();
      } catch (e) {
        console.log(e);
      }
    },
    async deleteUser() {
      try {
        const userId = this.newUserObject["user_id"];
        await axios.delete(`http://localhost:5000/api/v1/users/user/${userId}`);
        console.log("delete user");
        this.getUsers();
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
