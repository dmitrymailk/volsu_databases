import { createRouter, createWebHistory, RouteRecordRaw } from "vue-router";
import Home from "../components/Home.vue";

import Users from "../components/Users/Users.vue";
import Product from "../components/Product/Product.vue";
import Obligation from "../components/Obligation/Obligation.vue";

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
  {
    path: "/products",
    component: Product,
  },
  {
    path: "/obligations",
    component: Obligation,
  },
];

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
});

export default router;
