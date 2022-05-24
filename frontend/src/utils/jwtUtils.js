const TOKEN_ID = "JWT_TOKEN";

const getToken = () => {
  return window.localStorage.getItem(TOKEN_ID);
};

const setToken = (data) => {
  window.localStorage.setItem(TOKEN_ID, data);
};
const removeToken = () => {
  window.localStorage.removeItem(TOKEN_ID);
};

export { getToken, setToken, removeToken };
