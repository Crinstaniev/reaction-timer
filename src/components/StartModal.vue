<template>
  <!-- Start Game, Global Rank -->
  <!-- <div class="container">
    <div class="header">Reaction Timer</div>
    <div class="modal-container">
      <div class="grid" @click="handleRankingClick"><p>Global Ranking</p></div>
      <div class="grid" @click="handleStartClick"><p>Game Start</p></div>
    </div>
  </div> -->
  <el-container style="width: 100%">
    <Header />
    <el-main>
      <el-row>
        <el-col :span="24">
          <div class="header">Reaction Timer</div>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="24" class="card-container">
          <el-card class="modal-container">
            <div class="button-wrap">
              <el-button class="button" type="success" @click="handleStartClick"
                ><p class="button-text">Game Start</p></el-button
              >
            </div>
            <div class="button-wrap">
              <el-button
                class="button"
                type="primary"
                @click="handleRankingClick"
                ><p class="button-text">Global Ranking</p></el-button
              >
            </div>
          </el-card>
        </el-col>
      </el-row>
    </el-main>
    <el-footer>{{ footer }}</el-footer>
  </el-container>
</template>

<script>
import Header from "./modules/Header.vue";
export default {
  components: { Header },
  data() {
    return {
      footer:
        "Powered by Johnathan Zhuang | Blog - blog.ppsh.su | GitHub@Crinstaniev",
    };
  },

  methods: {
    async handleRankingClick() {
      this.$emit("to-rank");
    },

    async handleStartClick() {
      this.$emit("to-start");
    },
  },
};
</script>

<style>
.modal-container {
  width: 450px;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: columns;
}

.header {
  font-size: 35px;
  margin: 15px;
  font-weight: bold;
}

.grid {
  height: 75px;
  width: 75%;
  background-color: white;
  margin: 20px;
  border-radius: 20px;
  background-color: whitesmoke;
  display: inherit;
  align-items: center;
  justify-content: center;
  font-size: 1.5em;
  font-weight: bold;
  user-select: none;
}

.grid:hover {
  background-color: #e2e6ed;
}

.grid:active {
  background-color: #dad0c6;
}

.box-card {
  width: 480px;
}

.card-container {
  display: flex;
  justify-content: center;
  align-items: center;
}

.button {
  width: 350px;
  height: 75px;
}

.button-wrap {
  padding: 15px;
}

.button-text {
  font-size: large;
}
</style>