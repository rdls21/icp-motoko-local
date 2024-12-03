import { html, render } from 'lit-html';
import { perritos_backend } from 'declarations/perritos_backend';
import logo from './logo2.svg';

class App {
  greeting = '';

  constructor() {
    this.#render();
    // cargar backend
  }

  #handleSubmit = async (e) => {
    e.preventDefault();
    const name = document.getElementById('name').value;
    const breed = document.getElementById('breed').value;
    const age = document.getElementById('age').value;
    this.greeting = await perritos_backend.crearRegistro(name, breed, age);
    this.#render();
  };

  #render() {
    let body = html`
      <main>
        <form action="#">
          <label for="name">Enter the Dog Name: &nbsp;</label>
          <input id="name" alt="Name" type="text" />
          <button type="submit">Click Me!</button>
        </form>
        <section id="greeting">${this.greeting}</section>
      </main>
    `;
    render(body, document.getElementById('root'));
    document
      .querySelector('form')
      .addEventListener('submit', this.#handleSubmit);
  }
}

export default App;
