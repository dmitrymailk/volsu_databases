import { createRouter, createWebHistory, RouteRecordRaw } from "vue-router";
import Home from "../components/Home.vue";

import Users from "../components/Users/Users.vue";
import Product from "../components/Product/Product.vue";
import Obligation from "../components/Obligation/Obligation.vue";
import Bill from "../components/Bill/Bill.vue";
import Experiment from "../components/Experimenal/Experiment.vue";

import { ALLOWED_ROUTES } from "./router.constants.js";

import Login from "../components/Auth/Login.vue";
import Register from "../components/Auth/Register.vue";
import Unauthorized from "../components/Auth/401.vue";

import store from "../store/index.js";

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
  {
    path: "/bills",
    component: Bill,
  },
  {
    path: "/experiment",
    component: Experiment,
  },
  {
    path: "/unauthorized/",
    component: Unauthorized,
  },
  {
    path: "/login/",
    component: Login,
  },
  {
    path: "/register/",
    component: Register,
  },
];

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
});

router.beforeEach((to, from, next) => {
  console.log("store.getters.isAuthenticated", store.getters.isAuthenticated);

  const toPath = to.path;
  const isAllowedRoute = ALLOWED_ROUTES.includes(toPath);
  if (isAllowedRoute) {
    next();
  } else {
    if (store.getters.isAuthenticated) {
      next();
    } else router.push("/unauthorized/");
  }
});

export default router;
