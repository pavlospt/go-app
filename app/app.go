package main

import (
	"encoding/json"
	"net/http"

	"github.com/gorilla/mux"
)

type App struct {
	Router *mux.Router
}

func welcomeHandler(rw http.ResponseWriter, r *http.Request) {
	response := map[string]string{
		"message": "Welcome!",
	}

	err := json.NewEncoder(rw).Encode(response)

	if err != nil {
		panic(err)
	}
}

func (app *App) initialiseRoutes() {
	app.Router = mux.NewRouter()
	app.Router.HandleFunc("/", welcomeHandler)
}

func (app *App) run() {
	err := http.ListenAndServe(":8080", app.Router)

	if err != nil {
		panic(err)
	}
}
