<div align="center">
  <h2 style="font-weight: bold">Postwoman</h2>
  <p>
    <b>Um Cliente Web rápido e gratuito</b>
  </p>
  <p>
     <i>Alternativa ao Postman - Ajuda você a testar APIs de forma rápida e prática, salvando seu precioso tempo de desenvolvimento</i>
  </p>
  <p>
  </p>
</div>

---

## Acessar 🚀
[Postwoman Web Client](#)

## Recursos ✨

❤️ **Leveza**: Criado com um interface minimalista.

⚡️ **Rapidez**: Envia requisições e obtem respotas em tempo real.

**Métodos suportados:**

`GET`, `HEAD`, `POST`, `PUT`, `DELETE`, `CONNECT`, `OPTIONS` , `TRACE`, `PATCH`

**Tema:**

- Escolha seu tema: Escuro(padrão) ou Claro
- Escolha o esquema de cores: Verde (padrão), Amarelo, Rosa, Vermelho, Roxo, Laranja, Ciano ou Azul
- Toggle multi-colored headings

_As customizações de tema são salvas localmente na sessão do navegador_

🚀 **Requisição**: Obter instantaneamente a resposta de um _endpoint_.

- Escolha um `Método`
- Forneça o `Endereço da URL`
- Clique em `Enviar`

**Mais Funcionalidades:**

- Gerar/copiar código da requisição para `JavaScript XHR`, `Fetch` e `cURL`
- Importar `cURL`
- Descrição das requisições

🔌 **WebSocket**: Establish full-duplex communication channels over a single TCP connection.

- Send and receive data
- Basic and Bearer Token authentication

📡 **Server Sent Events**: Receive a stream of updates from a server over a HTTP connection without resorting to polling.

🌩 **Socket.IO**: Send and Receive data with SocketIO server.

🦟 **MQTT**: Subscribe and Publish to topics of a MQTT Broker.

🔮 **GraphQL**: GraphQL is a query language for APIs and a runtime for fulfilling those queries with your existing data.

- Set endpoint and get schemas
- Multi-column docs
- Set custom request headers
- Query schema
- Get query response

🔐 **Authentication**: Allows to identify the end user.

**Types:**

- None
- Basic
- Bearer Token
- OAuth 2.0
- OIDC Access Token/PKCE

📢 **Headers**: Describes the format the body of your request is being sent as.

📫 **Parameters**: Use request parameters to set varying parts in simulated requests.

📃 **Request Body**: Used to send and receive data via the REST API.

**Options:**

- Set `Content Type`
- Add or remove Parameter list
- Toggle between key-value and RAW input parameter list

👋 **Responses**: Contains the status line, headers and the message/response body.

- Copy response to clipboard
- Download response as a file
- View preview of HTML responses

⏰ **History**: Request entries are synced with cloud / local session storage to restore with a single click.

📁 **Collections**: Keep your API requests organized with collections and folders. Reuse them with a single click.

_Collections are synced with cloud / local session storage_

🌐 **Proxy**: Enable Proxy Mode from Settings to access blocked APIs.

**Features:**

- Hide your IP address
- Fixes [`CORS`](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS) (Cross Origin Resource Sharing) issues
- Access APIs served in non-HTTPS (`http://`)
- Use custom Proxy URL

_Official Postwoman Proxy is hosted by Apollo Software - **[Privacy Policy](https://apollosoftware.xyz/legal/postwoman)**_

📜 **Pre-Request Scripts β**: Snippets of code associated with a request that are executed before the request is sent.

**Use-cases:**

- Include timestamp in the request headers
- Send a random alphanumeric string in the URL parameters

📄 **API Documentation**: Create and share dynamic API documentation easily, quickly.

**Usage:**

1. Add your requests to Collections and Folders
2. Export Collections and easily share your APIs with the rest of your team
3. Import Collections and Generate Documentation on-the-go

⌨️ **Keyboard Shortcuts**: Optimized for efficiency.

**Shortcuts:**

- Send/Cancel Request <kbd>Ctrl</kbd> + <kbd>G</kbd>
- Save to Collections <kbd>Ctrl</kbd> + <kbd>S</kbd>
- Copy Request Link <kbd>Ctrl</kbd> + <kbd>K</kbd>
- Reset Request <kbd>Ctrl</kbd> + <kbd>L</kbd>

  > **Extensions fixes `CORS` issues.**

✅ **Post-Request Tests β**: Write tests associated with a request that are executed after the request response.

**Use-cases:**

- Check the status code as an integer
- Filter response headers
- Parse the response data

🌱 **Environments** : Environment variables allow you to store and reuse values in your requests and scripts.

**Use-cases:**

- By storing a value in a variable, you can reference it throughout your request section
- If you need to update the value, you only have to change it in one place
- Using variables increases your ability to work efficiently and minimizes the likelihood of error



## Usage 💡

1. Choose `method`
2. Enter `URL`
3. Send request
4. Get response

## Criado utilizando 🔧

- HTML
- CSS
- JavaScript (para as mágica)
- [Vue](https://vuejs.org/)
- [Nuxt](https://nuxtjs.org/)

## Developing 👷

0. Update [`.env.example`](https://github.com/liyasthomas/postwoman/blob/master/.env.example) file found in repository's root directory with your own keys and rename it to `.env`.

_Sample keys only works with the [production build](https://postwoman.io)._

#### Browser based development environment

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/liyasthomas/postwoman)

#### Local development environment

1. [Clone this repo](https://help.github.com/en/articles/cloning-a-repository) with git.
2. Install dependencies by running `npm install` within the directory that you cloned (probably `postwoman`).
3. Start the development server with `npm run dev`.
4. Open development site by going to [`http://localhost:3000`](http://localhost:3000) in your browser.

#### Docker compose

1. [Clone this repo](https://help.github.com/en/articles/cloning-a-repository) with git.
2. Run `docker-compose up`
3. Open development site by going to [`http://localhost:3000`](http://localhost:3000) in your browser.

## Docker 🐳 [![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/liyasthomas/postwoman?logo=Docker)](https://hub.docker.com/r/liyasthomas/postwoman)

```bash
#pull
docker pull liyasthomas/postwoman

#run
docker run -p 3000:3000 liyasthomas/postwoman:latest

#build
docker build -t postwoman:latest .
```

## Releasing 🧞

1. [Clone this repo](https://help.github.com/en/articles/cloning-a-repository) with git.
2. Install dependencies by running `npm install` within the directory that you cloned (probably `postwoman`).
3. Build the release files with `npm run build`.
4. Find the built project in `./dist`.

## Contributing 🍰

Please read [`CONTRIBUTING`](CONTRIBUTING.md) for details on our [`CODE OF CONDUCT`](CODE_OF_CONDUCT.md), and the process for submitting pull requests to us.

## Continuous Integration 💚 [![Travis Build Status](https://img.shields.io/travis/com/liyasthomas/postwoman?logo=Travis)](https://travis-ci.com/liyasthomas/postwoman)

We use [Travis CI](https://travis-ci.com) for continuous integration. Check out our [Travis CI Status](https://travis-ci.com/liyasthomas/postwoman).

## Versioning 🔖 [![GitHub release](https://img.shields.io/github/release/liyasthomas/postwoman/all?logo=GitHub)](https://github.com/liyasthomas/postwoman/releases/latest)

This project is developed by [Liyas Thomas](https://github.com/liyasthomas) using the [Semantic Versioning specification](https://semver.org). For the versions available, see the [releases on this repository](https://github.com/liyasthomas/postwoman/releases).

## Change log 📝

See the [`CHANGELOG`](CHANGELOG.md) file for details.

## Sobre o Projeto 📄

Esse projeto é privativo, de propriedade da Infracommerce.

É baseado em um antigo projeto opensource (Licença MIT) de mesmo nome.

Foi criado iniciamente por `Rafael Neri`, para atender as necessidades de desenvolvimento do cliente AgroGalaxy.


<div align="center">
  <br>
  <img src="https://raw.githubusercontent.com/liyasthomas/templates/master/assets/logo.gif" alt="Postwoman.io" width="200">
  <br>
  <h3>Happy Coding ❤︎</h3>
</div>
