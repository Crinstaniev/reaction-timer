<template>
  <el-button
    @click="handleLogin"
    round
    icon="../assets/logo.svg"
    class="login-button"
  >
    <el-row>
      <el-col :span="12" class="login-text">
        <div v-if="!identity">Login with</div>
        <div v-if="identity">Hello, {{ identity }}</div>
      </el-col>
      <el-col :span="12"
        ><img
          src="../../assets/logo.svg"
          id="dfinity-logo"
          style="width: 45px; padding-left: 5px"
        />
      </el-col>
    </el-row>
  </el-button>
  <el-dialog title="Congradulations!" v-model="dialogVisible" width="30%">
    <span>Login Success!</span>
    <template #footer>
      <span class="dialog-footer">
        <el-button type="primary" @click="handleLoginSuccess">OK</el-button>
      </span>
    </template>
  </el-dialog>
</template>

<script>
import { AuthClient } from "@dfinity/auth-client";

export default {
  emits: ["success"],
  data() {
    return {
      dialogVisible: false,
      identity: null,
    };
  },

  mounted() {
    this.fetchIdentity();
  },

  methods: {
    async handleLogin() {
      let that = this;
      const authClient = await AuthClient.create();
      authClient.login({
        onSuccess: async () => {
          that.dialogVisible = true;
        },
      });
    },

    handleLoginSuccess() {
      this.dialogVisible = false;
      this.fetchIdentity();
      this.$emit("success");
    },

    async fetchIdentity() {
      if (localStorage.getItem("ic-identity")) {
        const authClient = await AuthClient.create();
        const identity = authClient.getIdentity();
        this.identity = identity
          .getPrincipal()
          .toText()
          .slice(0, 5)
          .toUpperCase();
      }
    },
  },
};
</script>

<style scope>
.login-text {
  display: flex;
  justify-content: center;
  align-items: center;
}
</style>