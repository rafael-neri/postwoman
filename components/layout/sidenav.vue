<template>
  <aside class="nav-first">
    <nav class="primary-nav">
      <nuxt-link to="/" :class="linkActive('/')" v-tooltip.right="'Início'" aria-label="Início">
        <logo alt class="material-icons" style="height: 24px"></logo>
      </nuxt-link>

      <nuxt-link to="/" :class="linkActive('/')" v-tooltip.right="'Rest Client'">
        <i class="material-icons">language</i>
      </nuxt-link>

      <nuxt-link to="/realtime" :class="linkActive('/realtime')" v-tooltip.right="'Tempo real'">
        <i class="material-icons">bolt</i>
      </nuxt-link>

      <nuxt-link
        to="/graphql"
        :class="linkActive('/graphql')"
        v-tooltip.right="'GraphQL'"
        aria-label="GraphQL"
      >
        <i class="material-icons">landscape</i>
      </nuxt-link>

      <nuxt-link
        to="/doc"
        :class="linkActive('/doc')"
        v-tooltip.right="'Documentação'"
        aria-label="Documentação"
      >
        <i class="material-icons">topic</i>
      </nuxt-link>

      <nuxt-link
        to="/settings"
        :class="linkActive('/settings')"
        v-tooltip.right="'Configurações'"
        aria-label="Configurações"
      >
        <i class="material-icons">settings</i>
      </nuxt-link>
    </nav>
  </aside>
</template>

<style scoped lang="scss">
$responsiveWidth: 768px;

.nav-first {
  z-index: 1;
  height: 100vh;
  padding: 0 8px;
  background-color: var(--bg-dark-color);
  transition: all 0.2s ease-in-out;
}

nav.primary-nav {
  display: flex;
  flex-flow: column nowrap;
  align-items: center;
  justify-content: center;

  svg {
    fill: var(--fg-light-color);
    transition: all 0.2s ease-in-out;
  }

  a {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
    padding: 14px;
    border-radius: 50%;
    background-color: var(--bg-light-color);
    color: var(--fg-light-color);
    fill: var(--fg-light-color);
    margin: 8px 0;

    &:hover {
      color: var(--fg-color);
      fill: var(--fg-color);

      svg {
        fill: var(--fg-color);
      }
    }

    &.main {
    }

    &.nuxt-link-exact-active {
      background-color: var(--ac-color);
      color: var(--act-color);
      fill: var(--act-color);
      border-radius: 16px;

      svg {
        fill: var(--act-color);
      }
    }
  }
}

nav.secondary-nav {
  display: flex;
  flex-flow: column nowrap;
  align-items: center;
  justify-content: center;
  border-top: 2px dashed var(--brd-color);
  margin-top: 4px;

  ul {
    display: flex;
    flex-flow: column nowrap;

    li {
      display: flex;

      a {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        flex-shrink: 0;
        padding: 14px;
        border-radius: 50%;
        background-color: var(--bg-dark-color);
        color: var(--fg-light-color);
        fill: var(--fg-light-color);
        margin: 8px 0;

        &:hover {
          color: var(--fg-color);
          fill: var(--fg-color);
        }

        &.current {
          color: var(--ac-color);
          fill: var(--ac-color);
        }
      }
    }
  }
}

@media (max-width: $responsiveWidth) {
  .nav-first {
    position: fixed;
    top: auto;
    bottom: 0;
    height: auto;
    padding: 0;
    width: 100%;
    background-color: var(--bg-color);
    box-shadow: 0 2px 6px 0 rgba(0, 0, 0, 0.45);
  }

  nav.primary-nav {
    flex-flow: row nowrap;
    overflow: auto;
    justify-content: space-between;
    background-color: var(--bg-dark-color);

    a {
      background-color: transparent;
      margin: 8px;
      flex: 1;

      &.nuxt-link-exact-active {
        background-color: transparent;
        color: var(--ac-color);
        fill: var(--ac-color);

        svg {
          fill: var(--ac-color);
        }
      }
    }
  }

  nav.secondary-nav {
    display: none;
  }
}
</style>

<script>
export default {
  components: {
    logo: () => import("./logo"),
  },

  methods: {
    linkActive(path) {
      return {
        "nuxt-link-exact-active": this.$route.path === path,
        "nuxt-link-active": this.$route.path === path,
      }
    },
  },

  mounted() {
    window.addEventListener("scroll", (event) => {
      let mainNavLinks = document.querySelectorAll("nav ul li a")
      let fromTop = window.scrollY
      mainNavLinks.forEach(({ hash, classList }) => {
        let section = document.querySelector(hash)

        if (
          section &&
          section.offsetTop <= fromTop &&
          section.offsetTop + section.offsetHeight > fromTop
        ) {
          classList.add("current")
        } else {
          classList.remove("current")
        }
      })
    })
  },
}
</script>
