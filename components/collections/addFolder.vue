<template>
  <modal v-if="show" @close="show = false">
    <div slot="header">
      <ul>
        <li>
          <div class="flex-wrap">
            <h3 class="title">Novo Diretório</h3>
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
            placeholder="Meu Novo Diretório"
            @keyup.enter="addNewFolder"
          />
        </li>
      </ul>
    </div>
    <div slot="footer">
      <div class="flex-wrap">
        <span></span>
        <span>
          <button class="icon" @click="hideModal">Cancelar</button>
          <button class="icon primary" @click="addNewFolder">Salvar</button>
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
    collection: Object,
    collectionIndex: Number,
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
    addNewFolder() {
      this.$store.commit("postwoman/addNewFolder", {
        folder: { name: this.$data.name },
        collectionIndex: this.$props.collectionIndex,
      })
      this.hideModal()
      this.syncCollections()
    },
    syncCollections() {
      if (fb.currentUser !== null) {
        if (fb.currentSettings[0].value) {
          fb.writeCollections(JSON.parse(JSON.stringify(this.$store.state.postwoman.collections)))
        }
      }
    },
    hideModal() {
      this.$emit("hide-modal")
    },
  },
}
</script>
