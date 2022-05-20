import { createApp } from "vue";
import App from "./App.vue";
import router from "./router";
import store from "./store";

// @ts-ignore
import vSelect from "vue-select";

// import styles
import "./assets/libs/bootstrap/bootstrap.min.css";
import "./assets/libs/bootstrap-icons-1.8.1/bootstrap-icons.css";
import "vue-select/dist/vue-select.css";

const app = createApp(App);
app.use(store).use(router);
app.component("v-select", vSelect);
app.mount("#app");
