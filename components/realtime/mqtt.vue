<template>
  <div>
    <pw-section class="blue" label="'Requisição'">
      <ul>
        <li>
          <label for="mqtt-url">URL</label>
          <input id="mqtt-url" type="url" v-model="url" spellcheck="false" />
        </li>
        <div>
          <li>
            <label for="connect" class="hide-on-small-screen">&nbsp;</label>
            <button id="connect" :disabled="!validUrl" @click="toggleConnection">
              {{ this.connectionState ? "Desconectar" : "Conectar" }}
              <span>
                <i class="material-icons">{{ !connectionState ? "sync" : "sync_disabled" }}</i>
              </span>
            </button>
          </li>
        </div>
      </ul>
    </pw-section>

    <pw-section class="blue" label="Comunicação">
      <ul>
        <li>
          <realtime-log title="Log" :log="this.log" />
        </li>
      </ul>
      <ul>
        <li>
          <label for="pub_topic">Tópico</label>
          <input id="pub_topic" type="text" v-model="pub_topic" spellcheck="false" />
        </li>
        <li>
          <label for="mqtt-message">Mensagem</label>
          <input id="mqtt-message" type="text" v-model="msg" spellcheck="false" />
        </li>
        <div>
          <li>
            <label for="publish" class="hide-on-small-screen">&nbsp;</label>
            <button id="publish" name="get" :disabled="!canpublish" @click="publish">
              Publicar
              <span>
                <i class="material-icons">send</i>
              </span>
            </button>
          </li>
        </div>
      </ul>
      <ul>
        <li>
          <label for="sub_topic">Tópico</label>
          <input id="sub_topic" type="text" v-model="sub_topic" spellcheck="false" />
        </li>
        <div>
          <li>
            <label for="subscribe" class="hide-on-small-screen">&nbsp;</label>
            <button id="subscribe" name="get" :disabled="!cansubscribe" @click="toggleSubscription">
              {{ subscriptionState ? "Cancelar subscrição" : "Subscrever" }}
              <span>
                <i class="material-icons">{{ subscriptionState ? "sync_disabled" : "sync" }}</i>
              </span>
            </button>
          </li>
        </div>
      </ul>
    </pw-section>
  </div>
</template>

<script>
import Paho from "paho-mqtt"
import { wsValid } from "~/helpers/utils/valid"

export default {
  components: {
    "pw-section": () => import("~/components/layout/section"),
    realtimeLog: () => import("./log"),
  },
  data: function () {
    return {
      url: "wss://test.mosquitto.org:8081",
      client: null,
      pub_topic: "",
      sub_topic: "",
      msg: "",
      connectionState: false,
      log: null,
      manualDisconnect: false,
      subscriptionState: false,
    }
  },
  computed: {
    validUrl() {
      return wsValid(this.url)
    },
    canpublish() {
      return this.pub_topic != "" && this.msg != "" && this.connectionState
    },
    cansubscribe() {
      return this.sub_topic != "" && this.connectionState
    },
  },
  methods: {
    connect() {
      this.log = [
        {
          payload: `Conectando à ${this.url}...`,
          source: "info",
          color: "var(--ac-color)",
          ts: new Date().toLocaleTimeString(),
        },
      ]
      let parseUrl = new URL(this.url)
      this.client = new Paho.Client(
        parseUrl.hostname,
        parseUrl.port != "" ? Number(parseUrl.port) : 8081,
        "postwoman"
      )
      this.client.connect({
        onSuccess: this.onConnectionSuccess,
        onFailure: this.onConnectionFailure,
        useSSL: true,
      })
      this.client.onConnectionLost = this.onConnectionLost
      this.client.onMessageArrived = this.onMessageArrived
    },
    onConnectionFailure() {
      this.connectionState = false
      this.log.push({
        payload: "Ocorreu um erro.",
        source: "info",
        color: "#ff5555",
        ts: new Date().toLocaleTimeString(),
      })
    },
    onConnectionSuccess() {
      this.connectionState = true
      this.log.push({
        payload: `Conectado a ${this.url}`,
        source: "info",
        color: "var(--ac-color)",
        ts: new Date().toLocaleTimeString(),
      })
      this.$toast.success("Conectado", {
        icon: "sync",
      })
    },
    onMessageArrived(message) {
      this.log.push({
        payload: `Message: ${message.payloadString} arrived on topic: ${message.destinationName}`,
        source: "info",
        color: "var(--ac-color)",
        ts: new Date().toLocaleTimeString(),
      })
    },
    toggleConnection() {
      if (this.connectionState) {
        this.disconnect()
      } else {
        this.connect()
      }
    },
    disconnect() {
      this.manualDisconnect = true
      this.client.disconnect()
      this.log.push({
        payload: `Desconectado de ${this.url}`,
        source: "info",
        color: "#ff5555",
        ts: new Date().toLocaleTimeString(),
      })
    },
    onConnectionLost() {
      this.connectionState = false
      if (this.manualDisconnect) {
        this.$toast.error("Desconectado", {
          icon: "sync_disabled",
        })
      } else {
        this.$toast.error("Algo de errado ocorreu!", {
          icon: "error",
        })
      }
      this.manualDisconnect = false
      this.subscriptionState = false
    },
    publish() {
      try {
        this.client.publish(this.pub_topic, this.msg, 0, false)
        this.log.push({
          payload: `Published message: ${this.msg} to topic: ${this.pub_topic}`,
          ts: new Date().toLocaleTimeString(),
          source: "info",
          color: "var(--ac-color)",
        })
      } catch (e) {
        this.log.push({
          payload:
            "Ocorreu um erro " + `ao publicar mensagem: ${this.msg} no tópico:  ${this.pub_topic}`,
          source: "info",
          color: "#ff5555",
          ts: new Date().toLocaleTimeString(),
        })
      }
    },
    toggleSubscription() {
      if (this.subscriptionState) {
        this.unsubscribe()
      } else {
        this.subscribe()
      }
    },
    subscribe() {
      try {
        this.client.subscribe(this.sub_topic, {
          onSuccess: this.usubSuccess,
          onFailure: this.usubFailure,
        })
      } catch (e) {
        this.log.push({
          payload: "Ocorreu um erro " + `subscrever no tópico:  ${this.sub_topic}`,
          source: "info",
          color: "#ff5555",
          ts: new Date().toLocaleTimeString(),
        })
      }
    },
    usubSuccess() {
      this.subscriptionState = !this.subscriptionState
      this.log.push({
        payload:
          `Successfully ` +
          (this.subscriptionState ? "subscribed" : "unsubscribed") +
          ` to topic: ${this.sub_topic}`,
        source: "info",
        color: "var(--ac-color)",
        ts: new Date().toLocaleTimeString(),
      })
    },
    usubFailure() {
      this.log.push({
        payload:
          `Failed to ` +
          (this.subscriptionState ? "unsubscribe" : "subscribe") +
          ` to topic: ${this.sub_topic}`,
        source: "info",
        color: "#ff5555",
        ts: new Date().toLocaleTimeString(),
      })
    },
    unsubscribe() {
      this.client.unsubscribe(this.sub_topic, {
        onSuccess: this.usubSuccess,
        onFailure: this.usubFailure,
      })
    },
  },
}
</script>
