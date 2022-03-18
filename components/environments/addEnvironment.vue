<template>
  <modal v-if="show" @close="hideModal">
    <div slot="header">
      <ul>
        <li>
          <div class="flex-wrap">
            <h3 class="title">Novo Ambiente</h3>
            <div>
              <button class="icon" @click="hideModal">
                <i class="material-icons">close</i>
              </button>
            </div>
          </div>
        </li>
      </ul>
    </div>
    <div slot="body">
      <ul>
        <li>
          <input
            type="text"
            v-model="name"
            placeholder="Meu Novo Ambiente"
            @keyup.enter="addNewEnvironment"
          />
        </li>
      </ul>
    </div>
    <div slot="footer">
      <div class="flex-wrap">
        <span></span>
        <span>
          <button class="icon" @click="hideModal">Cancelar</button>
          <button class="icon primary" @click="addNewEnvironment">Salvar</button>
        </span>
      </div>
    </div>
  </modal>
</template>

<script>
import { fb } from "~/helpers/fb"

export default {
  props: {
    show: Boolean,
  },
  components: {
    modal: () => import("~/components/ui/modal"),
  },
  data() {
    return {
      name: undefined,
    }
  },
  methods: {
    syncEnvironments() {
      if (fb.currentUser !== null) {
        if (fb.currentSettings[1].value) {
          fb.writeEnvironments(JSON.parse(JSON.stringify(this.$store.state.postwoman.environments)))
        }
      }
    },
    addNewEnvironment() {
      if (!this.$data.name) {
        this.$toast.info("Por favor, forneça um nome válido para o ambiente")
        return
      }
      let newEnvironment = [
        {
          name: this.$data.name,
          variables: [],
        },
      ]
      this.$store.commit("postwoman/importAddEnvironments", {
        environments: newEnvironment,
        confirmation: "Environment added",
      })
      this.$emit("hide-modal")
      this.syncEnvironments()
    },
    hideModal() {
      this.$emit("hide-modal")
      this.$data.name = undefined
    },
  },
}
</script>
