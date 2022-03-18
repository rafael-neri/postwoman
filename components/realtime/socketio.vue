<template>
  <div>
    <pw-section class="blue" label="Requisição" ref="request">
      <ul>
        <li>
          <label for="socketio-url">URL</label>
          <input
            id="socketio-url"
            type="url"
            spellcheck="false"
            :class="{ error: !urlValid }"
            v-model="url"
            @keyup.enter="urlValid ? toggleConnection() : null"
          />
        </li>
        <div>
          <li>
            <label for="connect" class="hide-on-small-screen">&nbsp;</label>
            <button :disabled="!urlValid" id="connect" name="connect" @click="toggleConnection">
              {{ !connectionState ? "Conectar" : "Desconectar" }}
              <span>
                <i class="material-icons">
                  {{ !connectionState ? "sync" : "sync_disabled" }}
                </i>
              </span>
            </button>
          </li>
        </div>
      </ul>
    </pw-section>

    <pw-section class="purple" label="Comunicação" id="response" ref="response">
      <ul>
        <li>
          <realtime-log title="Log" :log="communication.log" />
        </li>
      </ul>
      <ul>
        <li>
          <label for="event_name">Nome do evento</label>
          <input
            id="event_name"
            name="event_name"
            type="text"
            v-model="communication.eventName"
            :readonly="!connectionState"
          />
        </li>
      </ul>
      <ul>
        <li>
          <label for="socketio-message">Mensagem</label>
          <input
            id="socketio-message"
            name="message"
            type="text"
            v-model="communication.input"
            :readonly="!connectionState"
            @keyup.enter="connectionState ? sendMessage() : null"
          />
        </li>
        <div>
          <li>
            <label for="send" class="hide-on-small-screen">&nbsp;</label>
            <button id="send" name="send" :disabled="!connectionState" @click="sendMessage">
              send
              <span>
                <i class="material-icons">send</i>
              </span>
            </button>
          </li>
        </div>
      </ul>
    </pw-section>
  </div>
</template>

<script>
import { socketioValid } from "~/helpers/utils/valid"
import io from "socket.io-client"
import wildcard from "socketio-wildcard"

export default {
  components: {
    "pw-section": () => import("~/components/layout/section"),
    realtimeLog: () => import("./log"),
  },
  data() {
    return {
      url: "ws://",
      connectionState: false,
      io: null,
      communication: {
        log: null,
        eventName: "",
        input: "",
      },
    }
  },
  computed: {
    urlValid() {
      return socketioValid(this.url)
    },
  },
  methods: {
    toggleConnection() {
      // If it is connecting:
      if (!this.connectionState) return this.connect()
      // Otherwise, it's disconnecting.
      else return this.disconnect()
    },
    connect() {
      this.communication.log = [
        {
          payload: `Conectando à ${this.url}...`,
          source: "info",
          color: "var(--ac-color)",
        },
      ]

      try {
        this.io = new io(this.url)
        // Add ability to listen to all events
        wildcard(io.Manager)(this.io)
        this.io.on("connect", () => {
          this.connectionState = true
          this.communication.log = [
            {
              payload: `Contectado a ${this.url}`,
              source: "info",
              color: "var(--ac-color)",
              ts: new Date().toLocaleTimeString(),
            },
          ]
          this.$toast.success("Conectado", {
            icon: "sync",
          })
        })
        this.io.on("*", ({ data }) => {
          const [eventName, message] = data
          this.communication.log.push({
            payload: `[${eventName}] ${message ? JSON.stringify(message) : ""}`,
            source: "server",
            ts: new Date().toLocaleTimeString(),
          })
        })
        this.io.on("connect_error", (error) => {
          this.handleError(error)
        })
        this.io.on("reconnect_error", (error) => {
          this.handleError(error)
        })
        this.io.on("error", (data) => {
          this.handleError()
        })
        this.io.on("disconnect", () => {
          this.connectionState = false
          this.communication.log.push({
            payload: `Desconectado de ${this.url}`,
            source: "info",
            color: "#ff5555",
            ts: new Date().toLocaleTimeString(),
          })
          this.$toast.error("Desconectado", {
            icon: "sync_disabled",
          })
        })
      } catch (ex) {
        this.handleError(ex)
        this.$toast.error("Ocorreu um erro!", {
          icon: "error",
        })
      }
    },
    disconnect() {
      this.io.close()
    },
    handleError(error) {
      this.disconnect()
      this.connectionState = false
      this.communication.log.push({
        payload: "Ocorreu um erro.",
        source: "info",
        color: "#ff5555",
        ts: new Date().toLocaleTimeString(),
      })
      if (error !== null)
        this.communication.log.push({
          payload: error,
          source: "info",
          color: "#ff5555",
          ts: new Date().toLocaleTimeString(),
        })
    },
    sendMessage() {
      const eventName = this.communication.eventName
      let message

      try {
        message = JSON.parse(this.communication.input)
      } catch (err) {
        message = this.communication.input
      }

      if (this.io) {
        // TODO: support only one argument now
        // maybe should support more argument
        this.io.emit(eventName, message, (data) => {
          // receive response from server
          this.communication.log.push({
            payload: `[${eventName}] ${JSON.stringify(data)}`,
            source: "server",
            ts: new Date().toLocaleTimeString(),
          })
        })

        this.communication.log.push({
          payload: `[${eventName}] ${JSON.stringify(message)}`,
          source: "client",
          ts: new Date().toLocaleTimeString(),
        })
        this.communication.input = ""
      }
    },
  },
}
</script>
