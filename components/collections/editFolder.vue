<template>
  <modal v-if="show" @close="show = false">
    <div slot="header">
      <ul>
        <li>
          <div class="flex-wrap">
            <h3 class="title">Editar Diretório</h3>
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
          <input type="text" v-model="name" :placeholder="folder.name" @keyup.enter="editFolder" />
        </li>
      </ul>
    </div>
    <div slot="footer">
      <div class="flex-wrap">
        <span></span>
        <span>
          <button class="icon" @click="hideModal">Cancelar</button>
          <button class="icon primary" @click="editFolder">Salvar</button>
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
    folder: Object,
    folderIndex: Number,
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
    syncCollections() {
      if (fb.currentUser !== null) {
        if (fb.currentSettings[0].value) {
          fb.writeCollections(JSON.parse(JSON.stringify(this.$store.state.postwoman.collections)))
        }
      }
    },
    editFolder() {
      this.$store.commit("postwoman/editFolder", {
        collectionIndex: this.$props.collectionIndex,
        folder: { ...this.$props.folder, name: this.$data.name },
        folderIndex: this.$props.folderIndex,
      })
      this.hideModal()
      this.syncCollections()
    },
    hideModal() {
      this.$emit("hide-modal")
    },
  },
}
</script>
