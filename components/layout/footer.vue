<template>
  <footer class="footer">
    <div class="flex-wrap">
      <span class="copyright">Infracommerce © {{ year }} Todos os direitos reservados</span>
    </div>
  </footer>
</template>

<style scoped lang="scss">
.footer {
  flex-flow: column nowrap;

  .copyright {
    font-weight: 500;
    font-size: 16px;
    font-family: "Poppins", "Roboto", "Noto", sans-serif;
    line-height: 1.5;
    color: var(--fg-light-color);
    fill: var(--fg-light-color);
  }
}
</style>

<script>
export default {
  data() {
    return {
      year: new Date().getFullYear(),
    }
  },
}
</script>
