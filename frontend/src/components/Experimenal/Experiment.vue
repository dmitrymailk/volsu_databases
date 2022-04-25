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
  <table class="table">
    <thead>
      <tr>
        <th scope="col">#</th>
        <th scope="col" v-for="col in itemsCols">{{ col }}</th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="(item, item_index) in itemObjectList">
        <th scope="row">{{ item_index }}</th>
        <td v-for="objItem in item">{{ objItem }}</td>
      </tr>
    </tbody>
  </table>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      sqlScript: "",
      items: [],
      itemsCols: [],
    };
  },
  computed: {
    itemObjectList: function () {
      let itemObjectList = [];
      for (let item of this.items) {
        let row = [];
        for (let col of this.itemsCols) row.push(item[col]);
        itemObjectList.push(row);
      }
      return itemObjectList;
    },
  },
  methods: {
    async executeScript(e) {
      e.preventDefault();
      console.log("execute", this.sqlScript);
      const SQL_script = this.sqlScript;
      try {
        let items = await axios.post(
          "http://localhost:5000/api/v1/experiment/",
          {
            SQL_script,
          }
        );
        console.log(items);
        items = items.data;
        const itemsCols = Object.keys(items[0]);
        this.itemsCols = itemsCols;
        this.items = items;
      } catch (e) {
        console.log(e);
      }
    },
  },
};
</script>
