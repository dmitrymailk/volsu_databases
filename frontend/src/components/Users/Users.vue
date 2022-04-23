<template>
  <div class="container">
    <h1>{{ name }}</h1>
    <h3>Search elements</h3>
    <div class="container">
      <form class="form-inline my-2 search">
        <input
          class="form-control mr-sm-2"
          type="search"
          placeholder="Search"
          aria-label="Search"
          v-model="searchPhrase"
        />
        <button
          class="btn btn-outline-success my-2 my-sm-0 mx-3"
          @click="searchItems"
        >
          Search
        </button>
      </form>
      <ul class="list-group list-group-horizontal">
        <li class="list-group-item" v-for="searchField in allowedFields">
          <div class="form-check form-switch">
            <input
              class="form-check-input"
              type="checkbox"
              role="switch"
              @change="() => setSearchFields(searchField)"
            />
            <label class="form-check-label">{{ searchField }}</label>
          </div>
        </li>
      </ul>
    </div>
    <h3 class="my-3">Sort elements</h3>
    <div class="container">
      <ul class="list-group list-group-horizontal">
        <li class="list-group-item" v-for="sortField in allowedFields">
          <div class="form-check">
            <input
              class="form-check-input"
              type="radio"
              name="flexRadioDefault"
              @click="() => setSortField(sortField)"
            />
            <label class="form-check-label">
              {{ sortField }}
            </label>
          </div>
        </li>
      </ul>
      <div class="form-check form-switch my-3">
        <input
          class="form-check-input"
          type="checkbox"
          @change="setSortOrder"
        />
        <label class="form-check-label">Descending order</label>
      </div>
    </div>
    <table class="table">
      <thead>
        <tr>
          <th scope="col">#</th>
          <th scope="col" v-for="col in usersCols">{{ col }}</th>
          <th>Controls</th>
        </tr>
      </thead>
      <tbody>
        <UserItem
          :userObject="user"
          :usersCols="usersCols"
          :user_index="index"
          :getItems="getItems"
          v-for="(user, index) in usersData"
        />

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
import UserItem from "./UserItem.vue";
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
      searchFields: {},
      searchPhrase: "",
      sortField: "",
      descendingOrder: false,
    };
  },
  components: {
    UserItem,
  },
  methods: {
    isFieldWritable(field_name) {
      return this.allowedFields.includes(field_name);
    },
    changeNewUserField(e, colData) {
      const value = String(e.target.value);
      this.newUser[colData] = value;
    },
    async getItems() {
      this.usersData = [];
      let users = await axios.get("http://localhost:5000/api/v1/users/");
      users = users.data;
      const usersCols = Object.keys(users[0]);
      for (let item of usersCols) {
        this.newUser[item] = "";
        this.searchFields[item] = false;
      }
      this.usersCols = usersCols;

      this.usersData = users;
    },

    async addItem() {
      this.displayMessages = [];
      console.log("add item");
      const len = (elem) => elem.length;
      const isBool = (str) => str == "0" || str == "1";
      let error = false;

      let user_credit = this.newUser["user_credit"];
      let user_name = this.newUser["user_name"];
      let user_phone = this.newUser["user_phone"];
      let user_email = this.newUser["user_email"];
      let user_admin = this.newUser["user_admin"];
      let user_read = this.newUser["user_read"];
      let user_write = this.newUser["user_write"];

      if (len(user_name) == 0) {
        error = true;
        this.displayMessages.push({
          type: "error",
          text: "Incorrect user_name",
        });
      }

      if (isNaN(user_credit) || len(user_credit) == 0) {
        error = true;
        this.displayMessages.push({
          type: "error",
          text: "Incorrect user_credit",
        });
      }

      if (len(user_phone) == 0 || isNaN(user_phone)) {
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
          await axios.post("http://localhost:5000/api/v1/users/", userData);
          this.displayMessages.push({
            type: "success",
            text: "User successfully added",
          });
          this.getItems();
        } catch (e) {
          console.error(e);
        }
      }
    },
    async searchItems(e) {
      e.preventDefault();
      console.log("search");
      try {
        const searchFields = this.searchFields;
        const searchPhrase = this.searchPhrase;
        let newItems = await axios.post(
          "http://localhost:5000/api/v1/users/search/",
          {
            searchFields,
            searchPhrase,
          }
        );
        newItems = newItems.data;

        this.usersData = newItems;
      } catch (e) {
        console.log(e);
      }
    },
    setSearchFields(searchField) {
      this.searchFields[searchField] = !this.searchFields[searchField];
    },
    async sortElements() {
      console.log("sort");
      if (this.sortField) {
        try {
          const sortField = this.sortField;
          const sortType = !this.descendingOrder ? "ASC" : "DESC";
          let items = await axios.get(
            `http://localhost:5000/api/v1/users/?field=${sortField}&sortType=${sortType}`
          );
          items = items.data;
          console.log(items);
          this.usersData = items;
        } catch (e) {
          console.log(e);
        }
      }
    },
    setSortOrder() {
      this.descendingOrder = !this.descendingOrder;
      this.sortElements();
    },
    setSortField(field) {
      this.sortField = field;
      this.sortElements();
    },
  },
  async mounted() {
    await this.getItems();
  },
};
</script>

<style lang="sass">
.search
	display: flex

.input-table
	width: 100%
</style>
