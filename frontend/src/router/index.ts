import { createRouter, createWebHistory, RouteRecordRaw } from "vue-router";
import Home from "../components/Home.vue";

import Users from "../components/Users/Users.vue";
import Product from "../components/Product/Product.vue";
import Obligation from "../components/Obligation/Obligation.vue";
import Bill from "../components/Bill/Bill.vue";
import Experiment from "../components/Experimenal/Experiment.vue";

import { ALLOWED_ROUTES, ADMIN_PAGES } from "./router.constants.js";

import Login from "../components/Auth/Login.vue";
import Register from "../components/Auth/Register.vue";
import Unauthorized from "../components/Auth/401.vue";
import AccessDenied from "../components/Auth/AccessDenied.vue";

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
  {
    path: "/forbidden/",
    component: AccessDenied,
  },
];

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
});

router.beforeEach((to, from, next) => {
  const toPath = to.path;
  const isAllowedRoute = ALLOWED_ROUTES.includes(toPath);
  const isAdminPage = ADMIN_PAGES.includes(toPath);
  const user = store.getters.user;
  let isUserAdmin = false;
  if (user) isUserAdmin = user.user_admin === 1;
  console.log(user, isUserAdmin);
  console.log("isAllowedRoute", isAdminPage);
  if (isAllowedRoute) {
    next();
  } else {
    if (store.getters.isAuthenticated) {
      console.log(
        "store.getters.isAuthenticated",
        store.getters.isAuthenticated,
        isAdminPage,
        isUserAdmin
      );
      if (isAdminPage && isUserAdmin) {
        next();
      } else if (isAdminPage && !isUserAdmin) {
        router.push("/forbidden/");
      } else next();
    } else router.push("/unauthorized/");
  }
});

export default router;
