<template>
  <div>
    <button class="icon" @click="logout" v-close-popover>
      <i class="material-icons">exit_to_app</i>
      <span>logout</span>
    </button>
  </div>
</template>

<script>
import firebase from "firebase/app"
import { fb } from "~/helpers/fb"

export default {
  data() {
    return {
      fb,
    }
  },
  methods: {
    logout() {
      fb.currentUser = null
      const self = this
      firebase
        .auth()
        .signOut()
        .catch((err) => {
          self.$toast.show(err.message || err, {
            icon: "error",
          })
        })
      self.$toast.info("logged_out", {
        icon: "vpn_key",
      })
    },
  },
}
</script>
