<template>
  <div class="page">
    <pw-section class="blue" label="Requisição" ref="request">
      <ul>
        <li>
          <label for="server">Servidor</label>
          <input
            id="server"
            type="url"
            :class="{ error: !serverValid }"
            v-model="server"
            @keyup.enter="serverValid ? toggleSSEConnection() : null"
          />
        </li>
        <div>
          <li>
            <label for="start" class="hide-on-small-screen">&nbsp;</label>
            <button :disabled="!serverValid" id="start" name="start" @click="toggleSSEConnection">
              {{ !connectionSSEState ? "Iniciar" : "Parar" }}
              <span>
                <i class="material-icons">
                  {{ !connectionSSEState ? "sync" : "sync_disabled" }}
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
          <realtime-log title="Eventos" :log="events.log" />
          <div id="result"></div>
        </li>
      </ul>
    </pw-section>
  </div>
</template>

<script>
import { httpValid } from "~/helpers/utils/valid"

export default {
  components: {
    "pw-section": () => import("../layout/section"),
    realtimeLog: () => import("./log"),
  },
  data() {
    return {
      connectionSSEState: false,
      server: "https://express-eventsource.herokuapp.com/events",
      sse: null,
      events: {
        log: null,
        input: "",
      },
    }
  },
  computed: {
    serverValid() {
      return httpValid(this.server)
    },
  },
  methods: {
    toggleSSEConnection() {
      // If it is connecting:
      if (!this.connectionSSEState) return this.start()
      // Otherwise, it's disconnecting.
      else return this.stop()
    },
    start() {
      this.events.log = [
        {
          payload: `Conectando à ${this.server}...`,
          source: "info",
          color: "var(--ac-color)",
        },
      ]
      if (typeof EventSource !== "undefined") {
        try {
          this.sse = new EventSource(this.server)
          this.sse.onopen = (event) => {
            this.connectionSSEState = true
            this.events.log = [
              {
                payload: `Conectado a ${this.server}`,
                source: "info",
                color: "var(--ac-color)",
                ts: new Date().toLocaleTimeString(),
              },
            ]
            this.$toast.success("Conectado", {
              icon: "sync",
            })
          }
          this.sse.onerror = (event) => {
            this.handleSSEError()
          }
          this.sse.onclose = (event) => {
            this.connectionSSEState = false
            this.events.log.push({
              payload: `Desconectado de ${this.server}`,
              source: "info",
              color: "#ff5555",
              ts: new Date().toLocaleTimeString(),
            })
            this.$toast.error("Desconectado", {
              icon: "sync_disabled",
            })
          }
          this.sse.onmessage = ({ data }) => {
            this.events.log.push({
              payload: data,
              source: "server",
              ts: new Date().toLocaleTimeString(),
            })
          }
        } catch (ex) {
          this.handleSSEError(ex)
          this.$toast.error("Ocorreu um erro!", {
            icon: "error",
          })
        }
      } else {
        this.events.log = [
          {
            payload: "Parece que este browser não suporta 'Server Sent Events'.",
            source: "info",
            color: "#ff5555",
            ts: new Date().toLocaleTimeString(),
          },
        ]
      }
    },
    handleSSEError(error) {
      this.stop()
      this.connectionSSEState = false
      this.events.log.push({
        payload: "Ocorreu um erro.",
        source: "info",
        color: "#ff5555",
        ts: new Date().toLocaleTimeString(),
      })
      if (error !== null)
        this.events.log.push({
          payload: error,
          source: "info",
          color: "#ff5555",
          ts: new Date().toLocaleTimeString(),
        })
    },
    stop() {
      this.sse.onclose()
      this.sse.close()
    },
  },
}
</script>
