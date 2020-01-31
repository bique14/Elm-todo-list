import { Elm } from './Main.elm'

var app = Elm.Main.init({ node: document.querySelector('main') })

app.ports.sendTodo.subscribe(function(todo) {
  console.log(`todo from js ${todo}`)
});
