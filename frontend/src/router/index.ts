import { createRouter, createWebHistory, RouteRecordRaw } from "vue-router";
import Home from "../components/Home.vue";
import Users from "../components/Users/Users.vue";
const routes: Array<RouteRecordRaw> = [
  {
    path: "/",
    name: "home",
    component: Home,
  },
  {
    path: "/users",
    component: Users,
  },
];

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
});

export default router;
