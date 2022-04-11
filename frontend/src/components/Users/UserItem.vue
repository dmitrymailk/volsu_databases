<template>
  <th scope="row">{{ index }}</th>
  <td v-for="colData in props">{{ colData }}</td>
</template>

<script>
import axios from "axios";

export default {
  props: [
    "user_id",
    "user_name",
    "user_hash",
    "user_credit",
    "user_phone",
    "user_email",
    "user_admin",
    "user_read",
    "user_write",
  ],
  data() {},
};
</script>
