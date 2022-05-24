<template>
  <tr>
    <th scope="row">{{ item_index }}</th>
    <td v-for="(item, index) in itemObjectList">
      <input
        v-if="item['field'] != 'bill_user'"
        type="text"
        class="input-table"
        :value="item.data"
        @input="(e) => changeField(e, item.field)"
      />
      <MySelect
        v-else-if="item['field'] == 'bill_user'"
        :selectCallback="userBillOptionsSelect.bind(this)"
        :dataCallback="userBillOptionsSelectDataCallback.bind(this)"
        :defaultDisplayName="userBillOptionsSelectDefaultName"
        :defaultOption="item"
        :displayFormatFunction="userBillOptionsSelectFormatFunction"
      />
    </td>
    <td class="table-controls">
      <button class="btn btn-success me-2" @click="updateItem">Update</button>
      <button class="btn btn-danger" @click="deleteItem">Delete</button>
    </td>
  </tr>
</template>
<script>
import MySelect from "./MySelect.vue";
import { apiServer } from "../../utils/apiServer";

export default {
  components: {
    MySelect,
  },
  props: ["itemsCols", "itemObject", "item_index", "getItems", "serverFields"],
  data() {
    return {
      newItemObject: {},
      userBillOptions: [],
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
    userBillOptionsSelectDefaultName() {
      // console.log(this.newItemObject, "test");
      return `${this.itemObject["user_name"]}`;
    },
  },

  methods: {
    userBillOptionsSelect(option) {
      console.log(option);
      this.newItemObject["bill_user"] = option["user_id"];
    },
    userBillOptionsSelectFormatFunction(option) {
      if (option["user_id"]) return `${option["user_name"]}`;
      else return `${option["user_name"]}`;
    },
    async userBillOptionsSelectDataCallback() {
      try {
        let result = await apiServer.get(`bills/user_bills/`);

        return result.data;
      } catch (e) {
        console.error(e);
      }
    },
    changeField(e, fieldType) {
      const value = e.srcElement.value;
      // console.log(value);
      this.newItemObject[fieldType] = value;
      // console.log(this.newItemObject);
    },
    async updateItem() {
      try {
        // console.log(object);
        const itemId = this.newItemObject["bill_id"];
        console.log(itemId, this.newItemObject);
        await apiServer.put(`bills/bill/${itemId}`, this.newItemObject);
        console.log("bill updated");
        this.getItems();
      } catch (e) {
        console.log(e);
      }
    },
    async deleteItem() {
      try {
        const itemId = this.newItemObject["bill_id"];
        await apiServer.delete(`bills/bill/${itemId}`);
        console.log("delete bill");
        this.getItems();
      } catch (e) {
        console.log(e);
      }
    },
  },
  mounted() {
    // console.log(this.userObject);
    //  = this.itemObject
    let newObj = {};
    for (let col of this.serverFields) {
      newObj[col] = this.itemObject[col];
    }
    // const userBillOption = this.itemObject['bill_user']
    this.newItemObject = newObj;
  },
};
</script>
