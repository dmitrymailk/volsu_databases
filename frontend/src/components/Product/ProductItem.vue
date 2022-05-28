<template>
  <tr>
    <th scope="row">{{ item_index }}</th>
    <td v-for="item in itemObjectList">
      <input
        type="text"
        class="input-table"
        :value="item.data"
        @input="(e) => changeField(e, item.field)"
        v-if="isFieldWritable(item.field)"
      />
    </td>
    <td class="table-controls">
      <button class="btn btn-success me-2" @click="updateItem">Update</button>
      <button class="btn btn-danger" @click="deleteItem">Delete</button>
    </td>
  </tr>
</template>
<script>
// import axios from "axios";
import { apiServer } from "../../utils/apiServer";
export default {
  props: [
    "itemsCols",
    "itemObject",
    "item_index",
    "getItems",
    "allowedFields",
    "displayMessages",
  ],
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
    isFieldWritable(field_name) {
      return this.allowedFields.includes(field_name);
    },
    async updateItem() {
      try {
        // console.log(object);
        // const itemId = this.newItemObject["product_id"];
        // console.log(itemId, this.newItemObject);
        // await apiServer.put(`products/product/${itemId}`, this.newItemObject);
        // console.log("product updated");
        // this.getItems();
        console.log("add item");
        const len = (elem) => elem.length;
        const isBool = (str) => str == "0" || str == "1";
        const isNegative = (str) => +str < 0;
        let error = false;

        let product_name = this.newItemObject["product_name"];
        let product_price = this.newItemObject["product_price"];
        let product_type = this.newItemObject["product_type"];
        let product_img = this.newItemObject["product_img"];

        if (len(product_name) == 0) {
          error = true;
          this.displayMessages.push({
            type: "error",
            text: "Incorrect product_name",
          });
        }

        if (
          isNaN(product_price) ||
          len(product_price) == 0 ||
          isNegative(product_price)
        ) {
          error = true;
          this.displayMessages.push({
            type: "error",
            text: "Incorrect product_price",
          });
        }

        if (len(product_type) == 0) {
          error = true;
          this.displayMessages.push({
            type: "error",
            text: "Incorrect product_type",
          });
        }

        if (len(product_img) == 0) {
          error = true;
          this.displayMessages.push({
            type: "error",
            text: "Incorrect product_img",
          });
        }

        if (!error) {
          console.log("send to server");
          product_price = Number(product_price);

          const itemId = this.newItemObject["product_id"];
          console.log(itemId, this.newItemObject);
          await apiServer.put(`products/product/${itemId}`, this.newItemObject);
          console.log("product updated");
          this.getItems();
        }
      } catch (e) {
        console.log(e);
      }
    },
    async deleteItem() {
      try {
        const itemId = this.newItemObject["product_id"];
        await apiServer.delete(`products/product/${itemId}`);
        console.log("delete product");
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
