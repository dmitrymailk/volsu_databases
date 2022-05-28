import axios from "axios";

import store from "../store/index.js";
import { getToken, removeToken } from "./jwtUtils";

let apiServer = axios.create({
  baseURL: "http://localhost:5000/api/v1/",
});

apiServer.defaults.headers.common["x-access-token"] = getToken();

apiServer.interceptors.response.use(
  function (response) {
    return response;
  },
  function (error) {
    if (401 === error.response.status) {
      store.dispatch("LOGOUT");

      return Promise.reject(error);
    } else {
      return Promise.reject(error);
    }
  }
);

const apiServerSetToken = (token) => {
  apiServer.defaults.headers.common["x-access-token"] = token;
};
const apiServerRemoveToken = (token) => {
  apiServer.defaults.headers.common["x-access-token"] = "";
};
export { apiServer, apiServerSetToken, apiServerRemoveToken };
