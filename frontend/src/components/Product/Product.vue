<template>
  <div class="container">
    <h1>{{ name }}</h1>
    <table class="table">
      <thead>
        <tr>
          <th scope="col">#</th>
          <th scope="col" v-for="col in itemsCols">{{ col }}</th>
          <th>Controls</th>
        </tr>
      </thead>
      <tbody>
        <ProductItem
          :itemObject="item"
          :itemsCols="itemsCols"
          :item_index="index"
          :getItems="getItems"
          :allowedFields="allowedFields"
          :displayMessages="displayMessages"
          v-for="(item, index) in itemsData"
        />

        <!-- add new item -->
        <tr>
          <th scope="row">{{ itemsData.length }}</th>
          <td v-for="(colData, index) in itemsCols">
            <input
              v-if="isFieldWritable(colData)"
              type="text"
              class="input-table"
              @input="(e) => changenewItemField(e, colData)"
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
import ProductItem from "./ProductItem.vue";
// import axios from "axios";
import { apiServer } from "../../utils/apiServer";

export default {
  data() {
    return {
      name: "Products",
      itemsData: [],
      itemsCols: [],
      allowedFields: [
        "product_name",
        "product_price",
        "product_type",
        "product_img",
      ],
      displayMessages: [],
      newItem: {},
    };
  },
  components: {
    ProductItem,
  },
  methods: {
    isFieldWritable(field_name) {
      return this.allowedFields.includes(field_name);
    },
    changenewItemField(e, colData) {
      const value = String(e.target.value);
      this.newItem[colData] = value;
    },
    async getItems() {
      this.itemsData = [];
      let items = await apiServer.get("products/");
      items = items.data;
      const itemsCols = Object.keys(items[0]);
      for (let item of itemsCols) {
        this.newItem[item] = "";
      }
      this.itemsCols = itemsCols;

      this.itemsData = items;
    },
    async addItem() {
      this.displayMessages = [];
      console.log("add item");
      const len = (elem) => elem.length;
      const isBool = (str) => str == "0" || str == "1";
      const isNegative = (str) => +str < 0;
      let error = false;

      let product_name = this.newItem["product_name"];
      let product_price = this.newItem["product_price"];
      let product_type = this.newItem["product_type"];
      let product_img = this.newItem["product_img"];

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

        let itemData = {
          product_name,
          product_price,
          product_type,
          product_img,
        };

        try {
          await apiServer.post("products/", itemData);
          this.displayMessages.push({
            type: "success",
            text: "Product successfully added",
          });
          this.getItems();
        } catch (e) {
          console.error(e);
        }
      }
    },
  },
  async mounted() {
    await this.getItems();
  },
};
</script>
