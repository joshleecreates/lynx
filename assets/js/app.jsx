import "bulma/css/bulma.min.css"
import '../css/app.css';
import React from "react";
import ReactDOM from "react-dom";
import URIForm from "./components/URIForm";
const app = document.getElementById("app");
ReactDOM.render(<URIForm />, app);
