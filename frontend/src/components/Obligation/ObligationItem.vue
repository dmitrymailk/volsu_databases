<template>
  <tr>
    <th scope="row">{{ item_index }}</th>
    <td v-for="item in itemObjectList">
      <input
        type="text"
        class="input-table"
        :value="item.data"
        @input="(e) => changeField(e, item.field)"
      />
    </td>
    <td class="table-controls">
      <button class="btn btn-success me-2" @click="updateItem">Update</button>
      <button class="btn btn-danger" @click="deleteItem">Delete</button>
    </td>
  </tr>
</template>
<script>
import axios from "axios";

export default {
  props: ["itemsCols", "itemObject", "item_index", "getItems"],
  data() {
    return {
      newItemObject: {},
    };
  },
  computed: {
    itemObjectList: function () {
      return this.itemsCols.map((item) => {
        return {
          data: this.itemObject[item],
          field: item,
        };
      });
    },
  },
  methods: {
    changeField(e, fieldType) {
      const value = e.srcElement.value;
      // console.log(value);
      this.newItemObject[fieldType] = value;
      // console.log(this.newItemObject);
    },
    async updateItem() {
      try {
        // console.log(object);
        const itemId = this.newItemObject["obligation_id"];
        console.log(itemId, this.newItemObject);
        await axios.put(
          `http://localhost:5000/api/v1/obligations/obligation/${itemId}`,
          this.newItemObject
        );
        console.log("obligation updated");
        this.getItems();
      } catch (e) {
        console.log(e);
      }
    },
    async deleteItem() {
      try {
        const itemId = this.newItemObject["obligation_id"];
        await axios.delete(
          `http://localhost:5000/api/v1/obligations/obligation/${itemId}`
        );
        console.log("delete obligation");
        this.getItems();
      } catch (e) {
        console.log(e);
      }
    },
  },
  mounted() {
    // console.log(this.userObject);
    this.newItemObject = this.itemObject;
  },
};
</script>
