import { createStore } from "vuex";
import { getToken, setToken, removeToken } from "../utils/jwtUtils";
import {
  apiServer,
  apiServerSetToken,
  apiServerRemoveToken,
} from "../utils/apiServer";

export default createStore({
  state: {
    user: {},
    isAuthenticated: !!getToken(),
  },
  getters: {
    currentUser(state) {
      return state.user;
    },
    isAuthenticated(state) {
      return state.isAuthenticated;
    },
  },
  mutations: {
    SET_AUTH(state, user) {
      state.isAuthenticated = true;
      state.user = user;
      setToken(user.token);
      apiServerSetToken(user.token);
    },
    PURGE_AUTH(state) {
      state.isAuthenticated = false;
      state.user = {};
      removeToken();
      apiServerRemoveToken();
    },
  },
  actions: {
    LOGIN(context, credentials) {
      return new Promise((resolve) => {
        apiServer
          .post("/login", { ...credentials })
          .then(({ data }) => {
            context.commit("SET_AUTH", data);
            resolve(data);
          })
          .catch(({ response }) => {
            console.log("LOGIN ERROR");
          });
      });
    },
    LOGOUT(context) {
      context.commit("PURGE_AUTH");
    },
    REGISTER(context, credentials) {
      return new Promise((resolve, reject) => {
        apiServer
          .post("/register", { ...credentials })
          .then(({ data }) => {
            console.log("DATAAA", data);
            context.commit("SET_AUTH", data);
            resolve(data);
          })
          .catch(({ response }) => {
            console.log("REGISTER ERROR");
            reject(response);
          });
      });
    },
    CHECK_AUTH(context) {
      if (getToken()) {
        apiServer.setHeader();
        apiServer
          .get("user")
          .then(({ data }) => {
            context.commit("SET_AUTH", data.user);
          })
          .catch(({ response }) => {
            context.commit("SET_ERROR", response.data.errors);
          });
      } else {
        context.commit("PURGE_AUTH");
      }
    },
  },
  modules: {},
});
