import { createApp } from "vue";
import App from "./App.vue";
import router from "./router";
import store from "./store";

// import styles
import "./assets/libs/bootstrap/bootstrap.min.css";
import "./assets/libs/bootstrap-icons-1.8.1/bootstrap-icons.css";

createApp(App).use(store).use(router).mount("#app");
