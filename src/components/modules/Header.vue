<template>
  <el-header class="header">
    <el-row>
      <el-col :span="19"></el-col>
      <el-col :span="5">
        <login-button />
      </el-col>
    </el-row>
  </el-header>
</template>

<script>
import LoginButton from "./LoginButton.vue";

export default {
  components: { LoginButton },
};
</script>

<style scoped>
</style>