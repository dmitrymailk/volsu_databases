<template>
  <div class="container">
    <h1>{{ name }}</h1>
    <table class="table">
      <thead>
        <tr>
          <th scope="col">#</th>
          <th scope="col" v-for="col in showedFields">{{ col }}</th>
          <th>Controls</th>
        </tr>
      </thead>
      <tbody>
        <BillItem
          :itemObject="item"
          :itemsCols="showedFields"
          :item_index="index"
          :getItems="getItems"
          :serverFields="serverFields"
          v-for="(item, index) in itemsData"
        />

        <!-- add new item -->
        <tr>
          <th scope="row">{{ itemsData.length }}</th>
          <td v-for="(colData, index) in showedFields">
            <input
              v-if="isFieldWritable(colData) && colData != 'bill_user'"
              type="text"
              class="input-table"
              @input="(e) => changenewItemField(e, colData)"
            />
            <MySelect
              v-else-if="isFieldWritable(colData) && colData == 'bill_user'"
              :selectCallback="newUserBillOptionsSelect.bind(this)"
              :dataCallback="newUserBillOptionsSelectDataCallback.bind(this)"
              :defaultDisplayName="newUserBillOptionsSelectDefaultName"
              :defaultOption="{}"
              :displayFormatFunction="newUserBillOptionsSelectFormatFunction"
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
import axios from "axios";
import MySelect from "./MySelect.vue";

export default {
  data() {
    return {
      name: "Bills",
      itemsData: [],
      itemsCols: [],
      allowedFields: ["bill_user", "bill_sum"],
      showedFields: ["bill_user", "bill_sum"],
      serverFields: ["bill_id", "bill_user", "bill_sum"],
      displayMessages: [],
      newItem: {
        user_name: "",
      },
    };
  },
  components: {
    BillItem,
    MySelect,
  },
  computed: {
    newUserBillOptionsSelectDefaultName() {
      return `${this.newItem["user_name"]}`;
    },
  },
  methods: {
    newUserBillOptionsSelect(option) {
      console.log(option);
      this.newItem["bill_user"] = option["user_id"];
      this.newItem["user_name"] = option["user_name"];
    },
    async newUserBillOptionsSelectDataCallback() {
      try {
        let result = await axios.get(
          `http://localhost:5000/api/v1/bills/user_bills/`
        );

        return result.data;
      } catch (e) {
        console.error(e);
      }
    },
    newUserBillOptionsSelectFormatFunction(option) {
      if (option["user_id"]) return `${option["user_name"]}`;
      else return `${option["user_name"]}`;
    },
    isFieldWritable(field_name) {
      return this.allowedFields.includes(field_name);
    },
    changenewItemField(e, colData) {
      const value = String(e.target.value);
      this.newItem[colData] = value;
    },
    async getItems() {
      this.itemsData = [];
      let items = await axios.get("http://localhost:5000/api/v1/bills/");
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
          await axios.post("http://localhost:5000/api/v1/bills/", itemData);
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
