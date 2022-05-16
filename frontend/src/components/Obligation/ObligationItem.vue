<template>
  <tr>
    <th scope="row">{{ item_index }}</th>
    <td v-for="item in itemObjectList">
      <input
        v-if="item.field != ''"
        type="text"
        class="input-table"
        :value="item.data"
        @input="(e) => changeField(e, item.field)"
      />
      <select
        v-else-if="item.field == 'obligation_bill'"
        class="form-select form-select-sm"
        aria-label=".form-select-sm example"
      >
        <option
          @change="() => changeSelectField(item.field, obligation_bill)"
          v-for="obligation_bill in obligation_bills"
        >
          {{ obligation_bill }}
        </option>
      </select>
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
      selectFields: {
        obligation_bill: "",
      },
      obligation_bills: [],
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
    async changeSelectField(field, data) {
      this.selectFields[field] = data;
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
    async getObligationBills() {
      try {
        const itemId = this.newItemObject["obligation_id"];
        let bills = await axios.get(
          `http://localhost:5000/api/v1/obligations/bill/${itemId}`
        );
        bills = bills.data;
        console.log(bills);
      } catch (e) {
        console.log(e);
      }
    },
  },
  async mounted() {
    // console.log(this.userObject);
    this.newItemObject = this.itemObject;
    this.getObligationBills();
  },
};
</script>
