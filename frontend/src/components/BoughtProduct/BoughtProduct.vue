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
        <BillItem
          :itemObject="item"
          :itemsCols="itemsCols"
          :item_index="index"
          :getItems="getItems"
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
import BillItem from "./BillItem.vue";
import { apiServer } from "../../utils/apiServer";

export default {
  data() {
    return {
      name: "Bills",
      itemsData: [],
      itemsCols: [],
      allowedFields: ["bill_user", "bill_sum"],
      displayMessages: [],
      newItem: {},
    };
  },
  components: {
    BillItem,
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
      let items = await apiServer.get("bills/");
      console.log(items);
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
      console.log("add bill");
      const len = (elem) => elem.length;
      const isBool = (str) => str == "0" || str == "1";
      let error = false;

      let bill_user = this.newItem["bill_user"];
      let bill_sum = this.newItem["bill_sum"];

      if (len(bill_user) == 0 || isNaN(bill_user)) {
        error = true;
        this.displayMessages.push({
          type: "error",
          text: "Incorrect bill_user",
        });
      }

      if (isNaN(bill_sum) || len(bill_sum) == 0) {
        error = true;
        this.displayMessages.push({
          type: "error",
          text: "Incorrect bill_sum",
        });
      }

      if (!error) {
        console.log("send to server");
        bill_sum = Number(bill_sum);

        let itemData = {
          bill_user,
          bill_sum,
        };

        try {
          await apiServer.post("bills/", itemData);
          this.displayMessages.push({
            type: "success",
            text: "Bill successfully added",
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
