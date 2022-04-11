<template>
  <th scope="row">{{ index }}</th>
  <td v-for="colData in props">{{ colData }}</td>
</template>

<script lang="ts" setup>
import axios from "axios";

const props = defineProps<{
  user_admin: string;
  user_credit: string;
  user_email: string;
  user_hash: string;
  user_id: string;
  user_name: string;
  user_phone: string;
  user_read: string;
  user_write: string;
  index: number;
}>();
</script>
