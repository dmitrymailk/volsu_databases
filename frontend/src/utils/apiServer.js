import axios from "axios";

import { getToken, removeToken } from "./jwtUtils";

let apiServer = axios.create({
  baseURL: "http://localhost:5000/api/v1/",
});

apiServer.defaults.headers.common["x-access-token"] = getToken();
const apiServerSetToken = (token) => {
  apiServer.defaults.headers.common["x-access-token"] = token;
};
const apiServerRemoveToken = (token) => {
  apiServer.defaults.headers.common["x-access-token"] = "";
};
export { apiServer, apiServerSetToken, apiServerRemoveToken };
