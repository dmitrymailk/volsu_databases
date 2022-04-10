<template>
  <h1>Index page {{ msg }}</h1>
</template>

<script lang="ts">
import { Vue } from "vue-class-component";

export default class Home extends Vue {
  msg: string = "123";
}
</script>
